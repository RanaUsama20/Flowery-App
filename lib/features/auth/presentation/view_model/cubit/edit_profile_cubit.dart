import 'dart:io';

import 'package:flowery_app/features/auth/data/model/request/edit_profile_request.dart';
import 'package:flowery_app/features/auth/domain/usecase/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/network/common/api_result.dart';
import 'edit_profile_state.dart';
@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.useCase) : super(const EditProfileState());
  AuthUseCase useCase;
  File? image;
  final ImagePicker _picker = ImagePicker();
  Future<bool> updateImageApi() async {
    if (image == null) return false;

    final result = await useCase.uploadPhoto(image!); // safe now, already checked

    switch (result) {
      case SuccessResult<String>():
        return true;
      case FailureResult<String>():
        emit(state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: result.exception.toString(),
        ));
        return false;
    }
  }
  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(state.copyWith(profileImageUrl: image));
    }

  }

  Future<void> pickImageFromCamera() async {

    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(state.copyWith(profileImageUrl: image)); // Emit the new image in the state
    }
  }

  Future<void> handleImagePicking(ImageSource source) async {
    bool permissionGranted = await _checkAndRequestPermission(source);

    if (!permissionGranted) {
      emit(state.copyWith(
        status: EditProfileStatus.failure,
        errorMessage: "Permission denied. Please enable it in settings.",
      ));
      return;
    }

    if (source == ImageSource.camera) {
      await pickImageFromCamera();
    } else {
      await pickImageFromGallery();
    }
  }
  Future<bool> _checkAndRequestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.status;
      if (status.isGranted) return true;

      status = await Permission.camera.request();
      return status.isGranted;
    } else {
      // Gallery: Handle both Android and iOS
      var storageStatus = await Permission.storage.status;
      var photosStatus = await Permission.photos.status;

      if (storageStatus.isGranted || photosStatus.isGranted) return true;

      final resultStorage = await Permission.storage.request();
      final resultPhotos = await Permission.photos.request();

      return resultStorage.isGranted || resultPhotos.isGranted;
    }
  }


  void submitProfile({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? phone,
  }) async {
    EditProfileRequest request = EditProfileRequest();

    bool hasUpdate = false;

    if ((firstName ?? '').trim().isNotEmpty) {
      request.firstName = firstName!.trim();
      hasUpdate = true;
    }

    if ((lastName ?? '').trim().isNotEmpty) {
      request.lastName = lastName!.trim();
      hasUpdate = true;
    }

    if ((email ?? '').trim().isNotEmpty) {
      request.email = email!.trim();
      hasUpdate = true;
    }

    if ((phone ?? '').trim().isNotEmpty) {
      request.phone = phone!.trim();
      hasUpdate = true;
    }
    emit(EditProfileState(status: EditProfileStatus.loading));
 if (image != null&&!hasUpdate) {
     final check= await  updateImageApi();
     if(check==true)
       {
         emit(EditProfileState(status: EditProfileStatus.success));
       }
     return;
 }
 else if (!hasUpdate) {
      emit(state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: "Please fill in at least one field to update."));
      return;
    }

    final result = await useCase.editProfile(request);

    switch (result) {
      case SuccessResult<String>():
        emit(state.copyWith(status: EditProfileStatus.success));
      case FailureResult<String>():
        emit(state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: result.exception.toString(),
        ));
    }
  }


}