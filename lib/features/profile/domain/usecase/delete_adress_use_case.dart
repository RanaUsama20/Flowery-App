import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUseCase {
  ProfileRepository repository;
  DeleteAddressUseCase(this.repository);

  Future<Result<String>> call(String id )
  {

   return repository.deleteAddress(id);
  }
}
