import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';

import '../../../../core/network/common/api_result.dart';
import '../entity/change_password/change_password__request_entity.dart';
import '../entity/change_password/change_password__response_entity.dart';

abstract class ProfileRepository {
  // ex:
  // Future<Result<ModelEntity>> functionName();
  Future<Result<ChangePasswordResponseEntity?>> changePassword(ChangePasswordRequestEntity? passwordData);

  Future<Result<ProfileDataEntity>> getProfileData();
  Future<Result<String>> deleteAddress(String id);

}
