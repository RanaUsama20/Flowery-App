import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import 'package:flowery_app/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class HomeRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  HomeRepositoryImpl(this._profileRemoteDataSource);

  //! ex:
  // @override
  // Future<Result<ModelEntity>> functionName() {
  //   return _profileRemoteDataSource.functionName();
  // }

  @override
  Future<Result<ProfileDataEntity>> getProfileData() async {
    return await _profileRemoteDataSource.getProfileData();
  }
}
