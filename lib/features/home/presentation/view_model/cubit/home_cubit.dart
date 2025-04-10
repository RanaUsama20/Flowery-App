import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/home/domain/entity/home_entity.dart';
import 'package:flowery_app/features/home/domain/usecase/home_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this._homeUseCase) : super(HomeStates());
  final HomeUseCase _homeUseCase;
  getHomeData() async {
    emit(HomeStates(homeData: BaseLoadingState()));
    final ans = await _homeUseCase();
    switch (ans) {
      case SuccessResult():
        {
          emit(HomeStates(homeData: BaseSuccessState<HomeEntity>(data: ans.data)));
        }
      case FailureResult():
        {
          emit(HomeStates(
              homeData: BaseErrorState(errorMessage: ans.toString())));
        }
    }
  }
}
