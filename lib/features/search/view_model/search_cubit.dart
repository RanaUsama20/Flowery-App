import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/search_type.dart';
import 'package:flowery_app/core/enum/status.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());
  //* emit change screens search
  void _changeSearchType(SearchType searchType) =>
      emit(state.copyWith(searchType: searchType));
  //* emit change screens search
  Future<void> getListResultsWritingSearches(String query) async {
    _changeSearchType(SearchType.onType);
    emit(state.copyWith(stateSearchResults: Status.loading));
    emit(state.copyWith(
      listSearchResults: itemsSearch,
      stateSearchResults: Status.success,
    ));
  }

  Future<void> getListLatestSearches() async {
    _changeSearchType(SearchType.onClick);
    emit(state.copyWith(stateLatestSearches: Status.loading));
    emit(state.copyWith(
      listLatestSearches: itemsLastSearches,
      stateLatestSearches: Status.success,
    ));
  }

  Future<void> getSearchResults() async {
    _changeSearchType(SearchType.result);
  }
}

//? dummy data for testing
// get data from api first 10 last searches
class Item {
  final int itemId;
  final String itemTitle;

  const Item({
    required this.itemId,
    required this.itemTitle,
  });
}

final List<Item> itemsLastSearches = [
  const Item(itemId: 1, itemTitle: 'برجر'),
  const Item(itemId: 2, itemTitle: 'مشويات'),
  const Item(itemId: 3, itemTitle: 'مشروبات'),
  const Item(itemId: 4, itemTitle: 'محلات ملابس'),
  const Item(itemId: 5, itemTitle: 'جراب ايفون'),
  const Item(itemId: 6, itemTitle: 'برجر'),
  const Item(itemId: 7, itemTitle: 'مشويات'),
  const Item(itemId: 8, itemTitle: 'مشروبات'),
  const Item(itemId: 9, itemTitle: 'محلات ملابس'),
  const Item(itemId: 10, itemTitle: 'جراب ايفون'),
];
final List<Item> itemsSearch = [
  const Item(itemId: 1, itemTitle: 'بروكار'),
  const Item(itemId: 2, itemTitle: 'برجر'),
  const Item(itemId: 3, itemTitle: 'برجر'),
  const Item(itemId: 4, itemTitle: 'بروكار'),
  const Item(itemId: 5, itemTitle: 'بروكار'),
  const Item(itemId: 6, itemTitle: 'برجر'),
  const Item(itemId: 7, itemTitle: 'مشويات'),
];
