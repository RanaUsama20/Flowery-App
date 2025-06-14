import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/tracking_order/domain/entity/track_order_details_entity.dart';
import 'package:flowery_app/features/tracking_order/domain/repository/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderDetailsUsecase {
  final TrackOrderRepository _trackOrderDataSource;
  TrackOrderDetailsUsecase(this._trackOrderDataSource);
  Future<Result<TrackOrderDetailsEntity>> call(String orderNumber) =>
      _trackOrderDataSource.getTrackOrderDetails(orderNumber);
}
