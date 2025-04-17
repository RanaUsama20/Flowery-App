import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';
import 'package:flowery_app/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileDataUseCase {
  ProfileRepository repository;
  GetProfileDataUseCase(this.repository);

  Future<Result<ProfileDataEntity>> call() => repository.getProfileData();
}
