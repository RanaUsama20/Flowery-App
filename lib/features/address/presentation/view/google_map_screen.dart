import 'dart:async';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/features/address/presentation/view_model/cubit/address_cubit.dart';
import 'package:flowery_app/features/address/presentation/view_model/cubit/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as gecoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permin;

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.156321434883143, 29.703577653648683),
    zoom: 7,
  );

  Set<Marker> setOfMarker = {};
  LatLng? latLong;

  @override
  Widget build(BuildContext context) {
    final _addressCubit = BlocProvider.of<AddressCubit>(context);

    return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              markers: setOfMarker,
              onTap: (value) async {
                setOfMarker.clear();
                setOfMarker
                    .add(Marker(markerId: MarkerId('1'), position: value));
                latLong = LatLng(value.latitude, value.longitude);
                // _addressCubit.latLng = LatLng(value.latitude, value.longitude);
                // _addressCubit.getInfoLatLong();
                // await getInforAboutLatLong(
                //     LatLng(value.latitude, value.longitude));
                setState(() {});
              },
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
                bottom: 15,
                left: 10,
                right: 10,
                child: BlocConsumer<AddressCubit, AddressState>(
                  listener: (context, state) {
                    if (state.getInfoFromLatLong is BaseLoadingState) {
                    } else if (state.getInfoFromLatLong is BaseErrorState) {
                      final currentLocation = state.getInfoFromLatLong as BaseErrorState;
                      AppDialogs.showFailureDialog(context,
                          message: currentLocation.errorMessage);
                    } else if (state.getInfoFromLatLong is BaseSuccessState) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (latLong == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('You have chose your location'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );

                            return;
                          }
                          _addressCubit.getInfoLatLong(
                              latitude: latLong!.latitude,
                              longitude: latLong!.longitude);
                        },
                        child: state.getInfoFromLatLong is BaseLoadingState
                            ? Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text('Save'));
                  },
                ))
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            child: Icon(Icons.location_searching),
            onPressed: () async {
              final currentLocation = await getCurrentLocation();

              if (currentLocation != null) {
                latLong = LatLng(currentLocation.latitude!, currentLocation.longitude!);
                _goToCurrentLocation(currentLocation);
                setOfMarker.clear();
                setOfMarker.add(Marker(
                    markerId: MarkerId('2'),
                    position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
                    infoWindow: InfoWindow(title: 'Current Location'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRose)));
                setState(() {});
              }
            },
          ),
        ));
  }

  getInforAboutLatLong(LatLng latlng) async {
    try {
      List<gecoding.Placemark> placemarks = await gecoding
          .placemarkFromCoordinates(latlng.latitude, latlng.longitude);

      for (int i = 0; i < placemarks.length; i++) {
        print('');
        print(
            'locality: ${placemarks[i].subAdministrativeArea}  street: ${placemarks[i].street} addminArea ${placemarks[i].administrativeArea}  code: ${placemarks[i].subLocality}');
        print('');
      }
    } catch (e) {
      print('the error is baaaaaaaaa $e');
    }
  }

  Future<void> _goToCurrentLocation(LocationData location) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(location.latitude!, location.longitude!), 18));
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      final currentLocation = await location.requestPermission();
      if (currentLocation != PermissionStatus.granted) {
        await permin.openAppSettings();
        return null;
      }
    }
    if (permissionGranted == PermissionStatus.deniedForever) {
      await permin.openAppSettings();
      return null;
    }

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    locationData = await location.getLocation();

    print(' bbbbbbbbbbbbbbbbbbbbbbbb $locationData');

    return locationData;
  }
}
