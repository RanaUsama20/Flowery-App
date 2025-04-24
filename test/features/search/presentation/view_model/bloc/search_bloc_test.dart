import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/core/enum/search_type.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/search/domain/usecase/search_query_use_case.dart';
import 'package:flowery_app/features/search/presentation/view_model/bloc/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchQueryUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    "testing view model search bloc",
    () {
      const String query = "query";
      final products = ProductItemEntity(
        id: "1",
        title: "title",
        price: 1.0,
        description: "description",
        category: "category",
        createdAt: '',
        discount: 1.0,
        images: [],
        imgCover: '',
        quantity: 1,
        occasion: '',
        priceAfterDiscount: 1,
        rateAvg: 10.0,
        rateCount: 1,
        slug: 'slug',
        sold: 1,
        updatedAt: query,
      );

      List<ProductItemEntity> listOfResult = [
        products,
        products,
        products,
      ];

      late SearchBloc viewModel;
      late MockSearchQueryUseCase mockSearchQueryUseCase;

      setUp(() {
        mockSearchQueryUseCase = MockSearchQueryUseCase();
        viewModel = SearchBloc(mockSearchQueryUseCase);
      });

      blocTest<SearchBloc, SearchState>(
        'when SearchQueryChanged event then should emit new state loading and success'
        'when result is success and not empty list of products',
        build: () => viewModel,
        act: (bloc) => bloc.add(const SearchQueryChanged(query)),
        expect: () => [
          SearchState(
            searchType: SearchType.result,
            stateSearchResults: Status.loading,
          ),
          SearchState(
            products: listOfResult,
            stateSearchResults: Status.success,
            searchType: SearchType.result,
          ),
        ],
        setUp: () {
          final result = SuccessResult<List<ProductItemEntity>>(listOfResult);
          provideDummy<Result<List<ProductItemEntity>>>(result);
          when(mockSearchQueryUseCase.call(query)).thenAnswer((_) async => result);
        },
      );

      blocTest<SearchBloc, SearchState>(
        'when SearchQueryChanged event then should emit new state loading and success'
        'when result is success and empty list of products',
        build: () => viewModel,
        act: (bloc) => bloc.add(const SearchQueryChanged(query)),
        expect: () => [
          SearchState(
            searchType: SearchType.result,
            stateSearchResults: Status.loading,
          ),
          SearchState(
            products: [],
            stateSearchResults: Status.success,
            searchType: SearchType.empty,
          ),
        ],
        setUp: () {
          final result = SuccessResult<List<ProductItemEntity>>([]);
          provideDummy<Result<List<ProductItemEntity>>>(result);
          when(mockSearchQueryUseCase.call(query)).thenAnswer((_) async => result);
        },
      );

      blocTest<SearchBloc, SearchState>(
        'when SearchQueryChanged event then should emit new state loading and Failure',
        build: () => viewModel,
        act: (bloc) => bloc.add(const SearchQueryChanged(query)),
        expect: () => [
          SearchState(
            searchType: SearchType.result,
            stateSearchResults: Status.loading,
          ),
          SearchState(
            searchType: SearchType.result,
            stateSearchResults: Status.failure,
            errorMassage: Exception("Error").toString(),
          ),
        ],
        setUp: () {
          final result = FailureResult<List<ProductItemEntity>>(Exception("Error"));
          provideDummy<Result<List<ProductItemEntity>>>(result);
          when(mockSearchQueryUseCase.call(query)).thenAnswer((_) async => result);
        },
      );
    },
  );
}
