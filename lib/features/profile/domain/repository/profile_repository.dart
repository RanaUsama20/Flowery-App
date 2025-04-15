import '../../../../core/network/common/api_result.dart';
import '../../data/model/request/change_password/change_password_request_model.dart';
import '../entity/change_password/change_password__request_entity.dart';
import '../entity/change_password/change_password__response_entity.dart';

abstract class ProfileRepository {
  // ex:
  // Future<Result<ModelEntity>> functionName();
  Future<Result<ChangePasswordResponseEntity?>> changePassword(ChangePasswordRequestEntity? passwordData);

}
