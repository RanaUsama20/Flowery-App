import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/search/domain/repository/search_query_repository.dart';
import 'package:flowery_app/features/search/domain/usecase/search_query_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_query_use_case_test.mocks.dart';

@GenerateMocks([SearchQueryRepository])
void main() {
  group("Search Use Case testing ", () {
    late SearchQueryUseCase useCase;
    late MockSearchQueryRepository mockRepository;
    setUp(() {
      mockRepository = MockSearchQueryRepository();
      useCase = SearchQueryUseCase(mockRepository);
    });

    test(
      "should return success list of ProductItemEntity when call function ",
      () async {
        final successResult = SuccessResult<List<ProductItemEntity>>([]);
        provideDummy<Result<List<ProductItemEntity>>>(successResult);
        when(mockRepository.getProductsByQuery("query"))
            .thenAnswer((_) async => successResult);
        final act = await useCase.call("query");
        expect(act, isA<SuccessResult<List<ProductItemEntity>>>());
        expect((act as SuccessResult).data, equals([]));
        verify(mockRepository.getProductsByQuery("query")).called(1);
      },
    );

    test(
      "should return error when call function ",
      () async {
        final errorResult = FailureResult<List<ProductItemEntity>>(Exception("error"));
        provideDummy<Result<List<ProductItemEntity>>>(errorResult);
        when(mockRepository.getProductsByQuery("query"))
            .thenAnswer((_) async => errorResult);
        final act = await useCase.call("query");
        expect(act, isA<FailureResult<List<ProductItemEntity>>>());
        verify(mockRepository.getProductsByQuery("query")).called(1);
      },
    );
  });
}
