part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  BaseState? getAllNotificationState;

  NotificationState({this.getAllNotificationState});
  NotificationState copyWith({BaseState? getAllNotificationState}) {
    return NotificationState(
      getAllNotificationState: getAllNotificationState ?? this.getAllNotificationState,
    );
  }
  @override
  List<Object?> get props => [getAllNotificationState];
}
