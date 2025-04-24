import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/network/remote/api_manager.dart';
import 'package:flowery_app/features/home/data/model/response/occasions/prodect_response_dto.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/search/data/api/search_retrofit_client.dart';
import 'package:flowery_app/features/search/data/data_source/search_query_data_source_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_query_data_source_imp_test.mocks.dart';

@GenerateMocks([SearchRetrofitClient, ApiManager])
void main() {
  group(
    "Search Query Data Source testing ",
    () {
      late SearchQueryDataSourceImp dataSource;
      late MockSearchRetrofitClient mockClient;
      late MockApiManager mockApiManager;
      setUp(() {
        mockClient = MockSearchRetrofitClient();
        mockApiManager = MockApiManager();
        dataSource = SearchQueryDataSourceImp(mockClient, mockApiManager);
      });

      test(
        "search product by query should return data success",
        () async {
          // arrange
          // initialize data
          final productDto = ProductResponseDto();
          final ProductEntity productEntity = productDto.toEntity();
          final successResultDto = SuccessResult<ProductResponseDto>(productDto);
          final successResultEntity = SuccessResult<ProductEntity>(productEntity);

          provideDummy<Result<ProductEntity>>(successResultEntity);
          provideDummy<Result<ProductResponseDto>>(successResultDto);
          when(mockClient.searchProduct("query")).thenAnswer((_) async => productDto);
          when(
            mockApiManager.execute<ProductResponseDto>(any),
          ).thenAnswer((_) async => successResultDto);

          // act
          final actual = await dataSource.getProductsByQuery("query");

          // assert
          expect(actual, isA<SuccessResult<ProductEntity>>());
          expect(
            (actual as SuccessResult).data.message,
            equals(successResultEntity.data.message),
          );

          verify(mockApiManager.execute<ProductResponseDto>(any)).called(1);
        },
      );

      test(
        "search product by query should return data failure",
        () async {
          // arrange
          // initialize data
          final failureResultDto = FailureResult<ProductResponseDto>(Exception("error"));
          final failureResultEntity = FailureResult<ProductEntity>(Exception("error"));

          provideDummy<Result<ProductEntity>>(failureResultEntity);
          provideDummy<Result<ProductResponseDto>>(failureResultDto);
          when(mockClient.searchProduct("query")).thenThrow(Exception("error"));
          when(
            mockApiManager.execute<ProductResponseDto>(any),
          ).thenAnswer((_) async => failureResultDto);

          // act
          final actual = await dataSource.getProductsByQuery("query");

          // assert
          expect(actual, isA<FailureResult<ProductEntity>>());
          expect(
            (actual as FailureResult).exception.toString(),
            contains("error"),
          );

          verify(mockApiManager.execute<ProductResponseDto>(any)).called(1);
        },
      );
    },
  );
}
