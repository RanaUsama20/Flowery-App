import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_app/features/tracking_order/data/data_source/remote/fire_base/track_order_data_source.dart';
import 'package:flowery_app/features/tracking_order/data/model/track_order_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderDataSource)
class TrackOrderDataSourceImpl implements TrackOrderDataSource {
  final FirebaseFirestore _firebaseFirestore;
  TrackOrderDataSourceImpl(this._firebaseFirestore);
  @override
  Future<TrackOrderResponse> getDetailsOfTrackingOrderDirver(
      {required String orderNumber, required String userId}) async {
        print('');
        print('the userId is $userId  the orderNumber is $orderNumber');
        print('');
    final doc = await _firebaseFirestore
        .collection('drivers')
        .doc('blrWu2jTFcPK4a3LFRMBK2Tq5be2')
        .collection('orders')
        .doc('#125012')
        .get();
    //  print('****************************************************');
    //  print('the doc from firebase is now $doc');
    //  print('****************************************************');
    final ans = doc.data() as Map<String, dynamic>;
    
    return TrackOrderResponse.fromJson(ans);
  }
}
