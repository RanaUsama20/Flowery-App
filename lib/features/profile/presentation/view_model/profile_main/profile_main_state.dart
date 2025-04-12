part of 'profile_main_cubit.dart';

class ProfileMainState extends Equatable {
  final Status profileMainStatus;

  const ProfileMainState({
    this.profileMainStatus = Status.initial,
  });

  ProfileMainState copyWith({
    Status? profileMainStatus,
  }) {
    return ProfileMainState(
      profileMainStatus: profileMainStatus ?? this.profileMainStatus,
    );
  }

  @override
  List<Object> get props => [
        profileMainStatus,
      ];
}

extension ProfileMainCubitX on ProfileMainState {
  bool get isProfileMainLoading => profileMainStatus == Status.loading;
  bool get isProfileMainSuccess => profileMainStatus == Status.success;
  bool get isProfileMainFailure => profileMainStatus == Status.failure;
}
