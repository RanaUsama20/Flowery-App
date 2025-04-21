part of 'search_cubit.dart';

class SearchState extends Equatable {
  final SearchType searchType;

  final List<Item> listLatestSearches;
  final Status stateLatestSearches;
  final String messageLatestSearches;

  final List<Item> listSearchWriteResults;
  final Status stateSearchResults;
  final String messageSearchResults;

  const SearchState({
    this.listLatestSearches = const [],
    this.stateLatestSearches = Status.initial,
    this.messageLatestSearches = '',
    this.searchType = SearchType.start,
    this.listSearchWriteResults = const [],
    this.stateSearchResults = Status.initial,
    this.messageSearchResults = '',
  });

  SearchState copyWith({
    List<Item>? listLatestSearches,
    Status? stateLatestSearches,
    String? messageLatestSearches,
    SearchType? searchType,
    List<Item>? listSearchResults,
    Status? stateSearchResults,
    String? messageSearchResults,
  }) {
    return SearchState(
      listLatestSearches: listLatestSearches ?? this.listLatestSearches,
      stateLatestSearches: stateLatestSearches ?? this.stateLatestSearches,
      messageLatestSearches: messageLatestSearches ?? this.messageLatestSearches,
      searchType: searchType ?? this.searchType,
      listSearchWriteResults: listSearchResults ?? this.listSearchWriteResults,
      stateSearchResults: stateSearchResults ?? this.stateSearchResults,
      messageSearchResults: messageSearchResults ?? this.messageSearchResults,
    );
  }

  @override
  List<Object> get props => [
        listLatestSearches,
        stateLatestSearches,
        messageLatestSearches,
        searchType,
        listSearchWriteResults,
        stateSearchResults,
        messageSearchResults,
      ];
}
