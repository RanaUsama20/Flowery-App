import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/tracking_order/presentation/widget/section_estimate.dart';
import 'package:flowery_app/features/tracking_order/presentation/widget/section_info_of_driver.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapTrackingScreen extends StatefulWidget {
  const GoogleMapTrackingScreen({super.key});

  @override
  State<GoogleMapTrackingScreen> createState() =>
      _GoogleMapTrackingScreenState();
}

class _GoogleMapTrackingScreenState extends State<GoogleMapTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
            child: GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: (controller) {
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(31.00221002, 30.125552211),
                          zoom: 10)));
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(31.00221002, 30.125552211), zoom: 10))),
        SizedBox(height: 20),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionEstimate(
                  estimateTime: '03 Sep 2024, 11:00 AM',
                ),
                SizedBox(height: 16),
                Divider(
                  color: AppColors.white[AppColors.colorCode70],
                ),
                SizedBox(height: 40),
                SectionInfoOfDriver(
                    driverName: 'Muhamed', phoneNumber: '02111111'),
                SizedBox(height: 40),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Order details')))
              ],
            ))
      ],
    )));
  }
}
