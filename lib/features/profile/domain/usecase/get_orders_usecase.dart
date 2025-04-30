import 'package:flowery_app/features/profile/domain/entity/orders/orders_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../repository/profile_repository.dart';

@injectable
class GetOrdersUseCase {
  final ProfileRepository _profileRepository;
  GetOrdersUseCase(this._profileRepository);
  Future<Result<OrdersResponseEntity?>> call() async {
    final result = await _profileRepository.getOrders();

    return result;

  }}