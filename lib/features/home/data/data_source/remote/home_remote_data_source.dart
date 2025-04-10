
import 'package:flowery_app/features/home/data/model/response/best-seller/best_seller_response_model.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../domain/entity/home_entity.dart';
import '../../../domain/entity/occasions_entity.dart';
import '../../../domain/entity/prodect_entity.dart';

abstract class HomeRemoteDataSource {
  Future<Result<BestSellerResponseDto>> getBestSeller();
  Future<HomeEntity> getHomedata();
  Future<Result<OccasionsEntity>> getTabOccasions();
  Future<Result<ProductEntity>> getProductsByOccasion(String occasionId);

}