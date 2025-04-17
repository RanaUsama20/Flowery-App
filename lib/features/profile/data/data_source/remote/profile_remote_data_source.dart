import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';

abstract class ProfileRemoteDataSource {
  // ex:
  //  Future<Result<ModelEntity>> functionName();
  Future<Result<ProfileDataEntity>> getProfileData();
}
