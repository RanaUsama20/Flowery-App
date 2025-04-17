import 'dart:developer';

import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/profile/data/model/response/profile_data/profile_data_dto.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/remote/api_manager.dart';

import '../../api/profile_retrofit_client.dart';
import 'profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileRetrofitClient _profileRetrofitClient;
  final ApiManager _apiManager;

  ProfileRemoteDataSourceImpl(this._profileRetrofitClient, this._apiManager);

  //! ex:
  // @override
  // Future<Result<ModelEntity>> functionName() async {
  //   final result = await _apiManager.execute<ModelDto>(() async {
  //     return await _homeRetrofitClient.functionName();
  //   });
  //   switch (result) {
  //     case SuccessResult<ModelDto>():
  //       return SuccessResult<ModelEntity>(result.data.toEntity());
  //     case FailureResult<ModelDto>():
  //       return FailureResult<ProductEntity>(result.exception);
  //   }
  // }

  @override
  Future<Result<ProfileDataEntity>> getProfileData() async {
    final result = await _apiManager.execute<ProfileDataDto>(() async {
      final token = await SaveLocal.getString("token");
      log("token: $token");
      return await _profileRetrofitClient.getProfile("Bearer $token");
    });
    switch (result) {
      case SuccessResult<ProfileDataDto>():
        return SuccessResult<ProfileDataEntity>(result.data.toProfileDataEntity());
      case FailureResult<ProfileDataDto>():
        return FailureResult<ProfileDataEntity>(result.exception);
    }
  }
}
