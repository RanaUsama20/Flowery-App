import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_app/features/tracking_order/domain/entity/track_order_details_entity.dart';

class TrackOrderResponse {
  final String firstName;
  final String lastName;
  final String driverLatlang;
  final String userLatlang;
  final String phone;
  final String orderStatus;
  final String vehicleImage;
  final String userId;
  DateTime dateTime;
  TrackOrderResponse(
      {required this.firstName,
      required this.lastName,
      required this.driverLatlang,
      required this.userLatlang,
      required this.phone,
      required this.orderStatus,
      required this.vehicleImage,
      required this.userId,
      required this.dateTime});

  factory TrackOrderResponse.fromJson(Map<String, dynamic> json) {
    return TrackOrderResponse(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        driverLatlang: json['driverLatLong'] as String,
        userLatlang: json['userLatLong'] as String,
        phone: json['phone'] as String,
        orderStatus: json['orderStatus'] as String,
        vehicleImage: json['vehicleImage'] as String,
        userId: json['uid'] as String,
        dateTime: (json['initializedAt'] as Timestamp).toDate());
  }

  TrackOrderDetailsEntity toTrackOrderDetailsEntity() {
    return TrackOrderDetailsEntity(
        firstName: firstName,
        lastName: lastName,
        driverLatlang: driverLatlang,
        userLatlang: userLatlang,
        phone: phone,
        orderStatus: orderStatus,
        vehicleImage: vehicleImage,
        userId: userId,
        dateTime: DateTime.now());
  }
}
