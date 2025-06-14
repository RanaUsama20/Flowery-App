import 'package:flowery_app/features/tracking_order/data/model/track_order_response.dart';

abstract class TrackOrderDataSource {
  Future<TrackOrderResponse> getDetailsOfTrackingOrderDirver(
      {required String orderNumber, required String userId});
}
