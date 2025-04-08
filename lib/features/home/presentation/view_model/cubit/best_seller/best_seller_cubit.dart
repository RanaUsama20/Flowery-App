import 'package:flowery_app/features/home/presentation/view_model/cubit/best_seller/best_seller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/base_state/base_state.dart';
import '../../../../../../core/network/common/api_result.dart';
import '../../../../domain/entity/best_seller/best_seller_response_entity.dart';
import '../../../../domain/usecase/home_use_case.dart';


@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  final HomeUseCase _homeUseCase;

  BestSellerCubit(this._homeUseCase) : super(BestSellerState(baseState: BaseInitialState()));

  void doIntent(BestSellerAction action) {
    switch (action) {
      case GetDataAction():
        {
          _fetchBestSeller();
        }

    }
  }

  Future<BestSellerResponseEntity?> _fetchBestSeller() async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _homeUseCase.call();


    switch (result)  {
      case SuccessResult<BestSellerResponseEntity>():
        {
          emit(state.copyWith(baseState: BaseHideLoadingState()));
          emit(state.copyWith(baseState: BaseSuccessState(data: result)));
        }
      case FailureResult<BestSellerResponseEntity>():
        {
          emit(state.copyWith(baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
              exception: result.exception),
          ),
          );
        }
    }
    return null;
  }


}



