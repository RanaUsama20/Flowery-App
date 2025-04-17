import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/domain/entity/change_password/change_password__request_entity.dart';
import 'package:flowery_app/features/profile/domain/entity/change_password/change_password__response_entity.dart';
import 'package:flowery_app/features/profile/domain/repository/profile_repository.dart';
import 'package:flowery_app/features/profile/domain/usecase/change_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late ChangePasswordUseCase useCase;
  late MockProfileRepository repo;
  late ChangePasswordRequestEntity passwordData;

  setUp(() {
    repo = MockProfileRepository();
    useCase = ChangePasswordUseCase(repo);
    passwordData = ChangePasswordRequestEntity(
      password: 'old@123',
      newPassword: 'new@123',
    );
  });

  group('ChangePasswordUseCase Tests', () {
    test(
        'should call changePassword on the repo and return SuccessResult when repository succeeds',
            () async {
          final response = ChangePasswordResponseEntity(
              message: 'Password changed successfully');
          final result = SuccessResult<ChangePasswordResponseEntity?>(response);
          provideDummy<Result<ChangePasswordResponseEntity?>>(result);
          when(repo.changePassword(passwordData)).thenAnswer((_) async => result);

          final actual = await useCase.call(passwordData);

          verify(repo.changePassword(passwordData)).called(1);
          expect(actual, isA<SuccessResult<ChangePasswordResponseEntity?>>());
          expect((actual as SuccessResult).data.message,
              'Password changed successfully');
        });

    test(
        'should call changePassword on the repo and return FailureResult when repository fails',
            () async {
          final exception = Exception('Invalid old password');
          final result = FailureResult<ChangePasswordResponseEntity?>(exception);
          provideDummy<Result<ChangePasswordResponseEntity?>>(result);

          when(repo.changePassword(passwordData)).thenAnswer((_) async => result);

          final actual = await useCase.call(passwordData);

          verify(repo.changePassword(passwordData)).called(1);
          expect(actual, isA<FailureResult<ChangePasswordResponseEntity?>>());
          expect((actual as FailureResult).exception.toString(),
              contains('Invalid old password'));
        });
  });
}
