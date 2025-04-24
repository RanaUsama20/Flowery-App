part of 'profile_main_cubit.dart';

class ProfileMainState extends Equatable {
  final Status profileMainStatus;
  final Status logoutStatus;
  final Status deleteAddressStatus;

  final ProfileDataEntity profileData;
  final String errorMessage;
  final String logOutMessageResponse;

  const ProfileMainState({
    this.profileMainStatus = Status.initial,
    this.logoutStatus = Status.initial,
    this.deleteAddressStatus = Status.initial,

    this.profileData = const ProfileDataEntity(),
    this.errorMessage = '',
    this.logOutMessageResponse = ''
  });

  ProfileMainState copyWith({
    Status? profileMainStatus,
    Status? logoutStatus,
    Status? deleteAddressStatus,

    ProfileDataEntity? profileData,
    String? errorMessage,
    String? logOutMessageResponse,

  }) {
    return ProfileMainState(
      profileMainStatus: profileMainStatus ?? this.profileMainStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      deleteAddressStatus: deleteAddressStatus ?? this.deleteAddressStatus,

      profileData: profileData ?? this.profileData,
      errorMessage: errorMessage ?? this.errorMessage,
      logOutMessageResponse: logOutMessageResponse ?? this.logOutMessageResponse,

    );
  }

  @override
  List<Object> get props => [
       deleteAddressStatus, profileMainStatus,logoutStatus,logOutMessageResponse,errorMessage,profileData
      ];
}

extension ProfileMainCubitX on ProfileMainState {
  bool get isProfileMainLoading => profileMainStatus == Status.loading;
  bool get isProfileMainSuccess => profileMainStatus == Status.success;
  bool get isProfileMainFailure => profileMainStatus == Status.failure;
  bool get isLogoutLoading => logoutStatus == Status.loading;
  bool get isLogoutSuccess => logoutStatus == Status.success;
  bool get isLogoutFailure => logoutStatus == Status.failure;
  bool get isDeleteAddressLoading => deleteAddressStatus == Status.loading;
  bool get isDeleteAddressSuccess => deleteAddressStatus == Status.success;
  bool get isDeleteAddressFailure => deleteAddressStatus == Status.failure;
}
