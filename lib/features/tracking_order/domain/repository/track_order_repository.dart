import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/tracking_order/domain/entity/track_order_details_entity.dart';

abstract class TrackOrderRepository {
  Future<Result<TrackOrderDetailsEntity>>getTrackOrderDetails(String orderNumber);
    
  
}