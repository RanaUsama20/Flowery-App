import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';
import 'package:flowery_app/features/notification/domain/usecase/get_all_notification_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_state.dart';
@injectable
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._getAllNotificationUseCase)
      : super(NotificationState());
  GetAllNotificationUseCase _getAllNotificationUseCase;
  getAllNotification({String? sort}) async {
    emit(state.copyWith(getAllNotificationState: BaseLoadingState()));
    final ans = await _getAllNotificationUseCase(sort);
    switch (ans) {
      case SuccessResult():
        {
          emit(state.copyWith(
              getAllNotificationState:
                  BaseSuccessState<List<AllNotificationEntity>?>(
                      data: ans.data)));
        }
      case FailureResult():
        {
          emit(state.copyWith(
              getAllNotificationState:
                  BaseErrorState(errorMessage: ans.exception.toString())));
        }
    }
  }
}
