import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../entity/change_password/change_password__request_entity.dart';
import '../entity/change_password/change_password__response_entity.dart';
import '../repository/profile_repository.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepository _profileRepository;
  ChangePasswordUseCase(this._profileRepository);
  Future<Result<ChangePasswordResponseEntity?>> call(ChangePasswordRequestEntity? passwordData) async {
    final result = await _profileRepository.changePassword(passwordData);

    return result;

  }}