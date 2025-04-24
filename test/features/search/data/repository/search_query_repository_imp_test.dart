import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/occasions_entity.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/search/data/repository/search_query_repository_imp.dart';
import 'package:flowery_app/features/search/domain/data_source/search_query_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_query_repository_imp_test.mocks.dart';

@GenerateMocks([SearchQueryDataSource])
void main() {
  group("testing state search query repository", () {
    late SearchQueryRepositoryImp repository;
    late SearchQueryDataSource mockDataSource;
    setUp(() {
      mockDataSource = MockSearchQueryDataSource();
      repository = SearchQueryRepositoryImp(mockDataSource);
    });
    test(
      "should return data success when call function getProductsByQuery",
      () async {
        // arrange
        final productEntity = ProductEntity(
          message: "",
          metadata: MetadataEntity(),
          products: [],
        );
        final result = SuccessResult<ProductEntity>(productEntity);
        provideDummy<Result<ProductEntity>>(result);
        when(mockDataSource.getProductsByQuery("query")).thenAnswer((_) async => result);

        /// act
        final act = await repository.getProductsByQuery("query");

        /// assert
        expect(act, isA<SuccessResult<List<ProductItemEntity>>>());
        expect((act as SuccessResult).data, equals([]));
        verify(mockDataSource.getProductsByQuery("query")).called(1);
      },
    );

    test(
      "should return error when call function getProductsByQuery",
      () async {
        // arrange
        final result = FailureResult<ProductEntity>(Exception("error"));
        provideDummy<Result<ProductEntity>>(result);
        when(mockDataSource.getProductsByQuery("query")).thenAnswer((_) async => result);

        /// act
        final act = await repository.getProductsByQuery("query");

        /// assert
        expect(act, isA<FailureResult<List<ProductItemEntity>>>());
        expect((act as FailureResult).exception, isA<Exception>());
        expect((act as FailureResult).exception.toString(), contains("error"));
        verify(mockDataSource.getProductsByQuery("query")).called(1);
      },
    );
  });
}
