import 'package:flowery_app/features/profile/data/model/request/change_password/change_password_request_model.dart';
import 'package:flowery_app/features/profile/data/model/response/change_password/change_password_response_model.dart';

import '../../../../../core/network/common/api_result.dart';

abstract class ProfileRemoteDataSource {
  // ex:
  //  Future<Result<ModelEntity>> functionName();
  Future<Result<ChangePasswordResponseDto?>> changePassword(ChangePasswordRequestDto? passwordData);

}
