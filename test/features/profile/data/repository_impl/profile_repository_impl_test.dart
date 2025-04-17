import 'package:flowery_app/features/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:flowery_app/features/profile/data/model/response/change_password/change_password_response_model.dart';
import 'package:flowery_app/features/profile/domain/entity/change_password/change_password__request_entity.dart';
import 'package:flowery_app/features/profile/domain/entity/change_password/change_password__response_entity.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  late MockProfileRemoteDataSource mockRemoteDataSource;
  late ProfileRepositoryImpl repository;
  late ChangePasswordRequestEntity requestEntity;
  late ChangePasswordResponseDto responseDto;
  provideDummy<Result<ChangePasswordResponseDto?>>(
    FailureResult(Exception("dummy")),
  );

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(mockRemoteDataSource);

    requestEntity = ChangePasswordRequestEntity(
      password: 'old123',
      newPassword: 'new123',
    );

    responseDto = ChangePasswordResponseDto(message: 'Password updated');

  });

  group('ProfileRepositoryImpl.changePassword', () {
    test('should return SuccessResult when remote data source succeeds', () async {
      when(mockRemoteDataSource.changePassword(any))
          .thenAnswer((_) async => SuccessResult(responseDto));

      final result = await repository.changePassword(requestEntity);

      expect(result, isA<SuccessResult<ChangePasswordResponseEntity?>>());
      expect((result as SuccessResult).data!.message, equals('Password updated'));
      verify(mockRemoteDataSource.changePassword(any)).called(1);
    });

    test('should return FailureResult when remote data source fails', () async {
      final exception = Exception('Something went wrong');
      when(mockRemoteDataSource.changePassword(any))
          .thenAnswer((_) async => FailureResult(exception));

      final result = await repository.changePassword(requestEntity);

      expect(result, isA<FailureResult<ChangePasswordResponseEntity?>>());
      expect((result as FailureResult).exception, equals(exception));
      verify(mockRemoteDataSource.changePassword(any)).called(1);
    });


    test('should return generic FailureResult when result is not Success or Failure', () async {
      final exception = Exception('Unknown error occurred');

      when(mockRemoteDataSource.changePassword(any))
          .thenAnswer((_) async => FailureResult(exception));

      final result = await repository.changePassword(requestEntity);

      expect(result, isA<FailureResult<ChangePasswordResponseEntity?>>());
      expect((result as FailureResult).exception.toString(),
          contains("Unknown error occurred"));

    });
  });
}
