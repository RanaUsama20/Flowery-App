import 'package:flowery_app/features/profile/data/data_source/remote/home_remote_data_source.dart';
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
}
