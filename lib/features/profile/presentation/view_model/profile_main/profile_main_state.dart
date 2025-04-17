part of 'profile_main_cubit.dart';

class ProfileMainState extends Equatable {
  final Status profileMainStatus;
  final ProfileDataEntity profileData;
  final String errorMessage;

  const ProfileMainState({
    this.profileMainStatus = Status.initial,
    this.profileData = const ProfileDataEntity(),
    this.errorMessage = '',
  });

  ProfileMainState copyWith({
    Status? profileMainStatus,
    ProfileDataEntity? profileData,
    String? errorMessage,
  }) {
    return ProfileMainState(
      profileMainStatus: profileMainStatus ?? this.profileMainStatus,
      profileData: profileData ?? this.profileData,
      errorMessage: errorMessage ?? this.errorMessage,
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
