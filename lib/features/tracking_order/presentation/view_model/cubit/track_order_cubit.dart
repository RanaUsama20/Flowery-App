import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/tracking_order/domain/entity/track_order_details_entity.dart';
import 'package:flowery_app/features/tracking_order/domain/usecase/track_order_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'track_order_state.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final TrackOrderDetailsUsecase _trackOrderDetailsUsecase;
  TrackOrderCubit(this._trackOrderDetailsUsecase) : super(TrackOrderState());

  getDetailsOfTrackingOrderDirver(String orderNumber) async {
    emit(state.copyWith(trackOrderState: BaseLoadingState()));
    final ans = await _trackOrderDetailsUsecase(orderNumber);
    switch (ans) {
      case SuccessResult():
        {
          emit(state.copyWith(
              trackOrderState:
                  BaseSuccessState<TrackOrderDetailsEntity>(data: ans.data)));
        }
      case FailureResult():
        {
          emit(state.copyWith(
              trackOrderState:
                  BaseErrorState(errorMessage: ans.exception.toString())));
        }
    }
  }
}
