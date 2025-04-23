import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/search_type.dart';
import 'package:flowery_app/core/enum/status.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/prodect_entity.dart';
import 'package:flowery_app/features/search/domain/usecase/search_query_use_case.dart';
import 'package:flowery_app/features/search/presentation/view_model/search_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchQueryUseCase useCase;

  SearchBloc(this.useCase) : super(const SearchState()) {
    on<SearchQueryChanged>(
      (event, emit) async {
        print("[Bloc] SearchQueryChanged: '${event.query}'");

        if (event.query.trim().isEmpty) {
          print("[Bloc] Query is empty -> SKIP");
          return;
        }
        emit(state.copyWith(
          searchType: SearchType.result,
          stateSearchResults: Status.loading,
        ));
        final result = await useCase.call(event.query);
        switch (result) {
          case SuccessResult<List<ProductItemEntity>>():
            emit(state.copyWith(
              products: result.data,
              stateSearchResults: Status.success,
              searchType: result.data.isEmpty ? SearchType.empty : SearchType.result,
            ));
          case FailureResult<List<ProductItemEntity>>():
            emit(state.copyWith(
              stateSearchResults: Status.failure,
              errorMassage: result.exception.toString(),
            ));
        }
      },
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(seconds: 1)).switchMap(mapper),
    );

    on<FetchLatestSearches>(
      (event, emit) async {
        print("[Bloc] FetchLatestSearches");
        emit(state.copyWith(
          searchType: SearchType.onClick,
          stateLatestSearches: Status.loading,
        ));

        // emit(state.copyWith(
        //   searchType: SearchType.onClick,
        //   stateLatestSearches: Status.success,
        //   listLatestSearches: itemsLastSearches,
        // ));
      },
      //   transformer: restartable(),
    );

    on<PerformSearch>(
      (event, emit) async {
        emit(state.copyWith(searchType: SearchType.result));
      },
    );
  }
}
