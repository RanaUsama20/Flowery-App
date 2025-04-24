part of 'search_bloc.dart';

extension OccasionsCubitX on SearchState {
  bool get isSearchLoading => stateSearchResults == Status.loading;
  bool get isSearchSuccess => stateSearchResults == Status.success;
  bool get isSearchFailure => stateSearchResults == Status.failure;

  // bool get isProductsLoading => productsStatus == Status.loading;
  // bool get isProductsSuccess => productsStatus == Status.success;
  // bool get isProductsFailure => productsStatus == Status.failure;
}

class SearchState extends Equatable {
  final SearchType searchType;
  final List<SearchQuery> listLatestSearches;
  final Status stateLatestSearches;
  final List<ProductItemEntity> products;
  final Status stateSearchResults;
  final String errorMassage;

  const SearchState({
    this.searchType = SearchType.start,
    this.listLatestSearches = const [],
    this.stateLatestSearches = Status.initial,
    this.products = const [],
    this.stateSearchResults = Status.initial,
    this.errorMassage = '',
  });

  SearchState copyWith({
    SearchType? searchType,
    List<SearchQuery>? listLatestSearches,
    Status? stateLatestSearches,
    List<ProductItemEntity>? products,
    Status? stateSearchResults,
    String? errorMassage,
  }) {
    return SearchState(
      searchType: searchType ?? this.searchType,
      listLatestSearches: listLatestSearches ?? this.listLatestSearches,
      stateLatestSearches: stateLatestSearches ?? this.stateLatestSearches,
      products: products ?? this.products,
      stateSearchResults: stateSearchResults ?? this.stateSearchResults,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }

  @override
  List<Object> get props => [
        searchType,
        listLatestSearches,
        stateLatestSearches,
        products,
        stateSearchResults,
        errorMassage,
      ];
}
