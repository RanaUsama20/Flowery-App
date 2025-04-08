
import 'package:flowery_app/features/home/domain/entity/best_seller/best_seller_response_entity.dart';
import '../../../../core/network/common/api_result.dart';

abstract class HomeRepository{

Future<Result<BestSellerResponseEntity>> getBestSeller();
}