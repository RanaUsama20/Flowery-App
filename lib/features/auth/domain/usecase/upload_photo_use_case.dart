
import 'dart:io';

import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../repository/auth_repository.dart';
@injectable
class UploadPhotoUseCase {
  final AuthRepository authRepo;

  UploadPhotoUseCase(this.authRepo);
  Future<Result<String>> uploadPhoto(File request) async
  {

    return await authRepo.uploadPhoto(request);
  }



}