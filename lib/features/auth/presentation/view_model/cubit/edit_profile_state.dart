import 'dart:io';

import 'package:equatable/equatable.dart';

enum EditProfileStatus { initial, loading, success, failure }
class EditProfileState extends Equatable {
  final EditProfileStatus status;
  final String? errorMessage;
  final File? profileImageUrl;

  const EditProfileState({
    this.status = EditProfileStatus.initial,
    this.errorMessage,
    this.profileImageUrl,
  });

  EditProfileState copyWith({
    EditProfileStatus? status,
    String? errorMessage,
    File? profileImageUrl,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    profileImageUrl,
  ];
}