import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_app/core/constants/app_values.dart';
import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/core/utils/app_shared_preference.dart';
import 'package:flowery_app/features/tracking_order/data/data_source/remote/fire_base/track_order_data_source.dart';
import 'package:flowery_app/features/tracking_order/domain/entity/track_order_details_entity.dart';
import 'package:flowery_app/features/tracking_order/domain/repository/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRepository)
class TrackOrderRepositoryImpl implements TrackOrderRepository {
  final TrackOrderDataSource _trackOrderDataSource;

  TrackOrderRepositoryImpl(this._trackOrderDataSource);
  @override
  Future<Result<TrackOrderDetailsEntity>> getTrackOrderDetails(
      String orderNumber) async {
    try {
      final userId =
          SharedPreferencesUtils.getData(key: AppValues.userId) as String;
      final result =
          await _trackOrderDataSource.getDetailsOfTrackingOrderDirver(
              orderNumber: orderNumber, userId: userId);
      final ans = result.toTrackOrderDetailsEntity();
      return SuccessResult<TrackOrderDetailsEntity>(ans);
    } on FirebaseException catch (e) {
      return FailureResult<TrackOrderDetailsEntity>(e);
    }
  }
}
