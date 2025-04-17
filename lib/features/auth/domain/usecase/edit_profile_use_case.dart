
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../data/model/request/edit_profile_request.dart';
import '../repository/auth_repository.dart';
@injectable
class EditProfileUseCase {
  final AuthRepository authRepo;

  EditProfileUseCase(this.authRepo);

  Future<Result<String>> editProfile(EditProfileRequest request) async
  {
    return await authRepo.editProfile(request);
  }



}