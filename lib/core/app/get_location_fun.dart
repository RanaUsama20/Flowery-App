import 'package:location/location.dart';

Future<LocationData?> getUserLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.error('Location permissions are denied');
    }
  }

  return await location.getLocation();
}
