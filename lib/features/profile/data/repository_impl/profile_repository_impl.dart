import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:flowery_app/features/profile/domain/entity/change_password/change_password__response_entity.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import 'package:flowery_app/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/change_password/change_password__request_entity.dart';
import '../model/response/change_password/change_password_response_model.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepositoryImpl(this._profileRemoteDataSource);

  @override
  Future<Result<ChangePasswordResponseEntity?>> changePassword(ChangePasswordRequestEntity? passwordData) async {
    final result = await _profileRemoteDataSource.changePassword(passwordData!.toDto());


    if (result is SuccessResult<ChangePasswordResponseDto?>) {
      return SuccessResult(result.data?.toDomain());
    }
    else if (result is FailureResult<ChangePasswordResponseDto?>) {
      return FailureResult(result.exception);
    }
    return FailureResult(Exception("Unknown error occurred"));
  }






  //! ex:
  // @override
  // Future<Result<ModelEntity>> functionName() {
  //   return _profileRemoteDataSource.functionName();
  // }

  @override
  Future<Result<ProfileDataEntity>> getProfileData() async {
    return await _profileRemoteDataSource.getProfileData();
  }
  Future<Result<void>> deleteAddress(String id) async {
    return await _profileRemoteDataSource.deleteAddress(id);
  }
}
