// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flowery_app/features/profile/data/data_source/remote/profile_remote_data_source_impl.dart';
// import 'package:flowery_app/core/network/common/api_result.dart';
// import 'package:flowery_app/features/profile/data/api/profile_retrofit_client.dart';
// import 'package:flowery_app/features/profile/data/model/request/change_password/change_password_request_model.dart';
// import 'package:flowery_app/features/profile/data/model/response/change_password/change_password_response_model.dart';
// import 'package:flowery_app/core/network/remote/api_manager.dart';
// import 'package:flowery_app/core/utils/save_local.dart';
// import 'package:mockito/annotations.dart';
//
// import 'profile_remote_data_source_impl_test.mocks.dart';
//
// @GenerateMocks([ProfileRetrofitClient, ApiManager])
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;
//   late MockProfileRetrofitClient mockProfileRetrofitClient;
//   late MockApiManager mockApiManager;
//
//   setUp(() {
//     mockProfileRetrofitClient = MockProfileRetrofitClient();
//     mockApiManager = MockApiManager();
//     profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(mockProfileRetrofitClient, mockApiManager);
//   });
//
//   group('ProfileRemoteDataSourceImpl', () {
//     test('should return SuccessResult when changePassword is successful', () async {
//       final passwordData = ChangePasswordRequestDto(password: 'oldPass', newPassword: 'newPass');
//       final changePasswordResponse = ChangePasswordResponseDto(token: 'newToken', message: 'Password changed');
//       final token = 'mocked_token';
//
//       when(SaveLocal.getString('token')).thenAnswer((_) async => token);
//
//       when(mockProfileRetrofitClient.changePassword(any, any))
//           .thenAnswer((_) async => changePasswordResponse);
//
//       when(mockApiManager.execute<ChangePasswordResponseDto?>(any)).thenAnswer(
//             (_) async {
//           return SuccessResult(changePasswordResponse);
//         },
//       );
//
//       final result = await profileRemoteDataSourceImpl.changePassword(passwordData);
//
//       expect(result, isA<SuccessResult>());
//       final successResult = result as SuccessResult;
//       expect(successResult.data?.message, 'Password changed');
//     });
//
//     test('should return FailureResult when changePassword fails', () async {
//       final passwordData = ChangePasswordRequestDto(password: 'oldPass', newPassword: 'newPass');
//       final token = 'mocked_token';
//
//       when(SaveLocal.getString('token')).thenAnswer((_) async => token);
//
//       when(mockProfileRetrofitClient.changePassword(any, any)).thenThrow(Exception('Failed to change password'));
//
//       when(mockApiManager.execute<ChangePasswordResponseDto?>(any)).thenAnswer(
//             (_) async {
//           return FailureResult(Exception('Failed to change password'));
//         },
//       );
//
//       final result = await profileRemoteDataSourceImpl.changePassword(passwordData);
//
//       expect(result, isA<FailureResult>());
//       final failureResult = result as FailureResult;
//       expect(failureResult.exception.toString(), 'Exception: Failed to change password');
//     });
//   });
// }
