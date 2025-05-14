import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrderEntity {
  DateTime dataTimeOfOrder;
  LatLng locationOfDriver;
  LatLng locationOfClient;
  String phoneNumberOfDriver;
  String urlWhatsUpOfDriver;
  TrackOrderEntity(
      {required this.dataTimeOfOrder,
      required this.locationOfClient,
      required this.locationOfDriver,
      required this.phoneNumberOfDriver,
      required this.urlWhatsUpOfDriver});
}
