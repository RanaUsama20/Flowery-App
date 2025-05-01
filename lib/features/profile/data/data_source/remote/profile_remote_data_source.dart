import 'package:flowery_app/features/profile/data/model/request/change_password/change_password_request_model.dart';
import 'package:flowery_app/features/profile/data/model/response/change_password/change_password_response_model.dart';

import '../../../../../core/network/common/api_result.dart';

import 'package:flowery_app/features/profile/domain/entity/profile_data_entity/profile_data_entity.dart';

import '../../model/response/orders/orders_response_dto.dart';

abstract class ProfileRemoteDataSource {
  // ex:
  //  Future<Result<ModelEntity>> functionName();
  Future<Result<ProfileDataEntity>> getProfileData();
  Future<Result<ChangePasswordResponseDto?>> changePassword(ChangePasswordRequestDto? passwordData);
  Future<Result<String>> deleteAddress(String id);
  Future<Result<OrdersResponseDto?>> getOrders();


}
