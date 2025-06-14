import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/core/utils/widgets/error_widget.dart';
import 'package:flowery_app/features/tracking_order/domain/entity/track_order_details_entity.dart';
import 'package:flowery_app/features/tracking_order/presentation/view/google_map_tracking_screen.dart';
import 'package:flowery_app/features/tracking_order/presentation/view_model/cubit/track_order_cubit.dart';
import 'package:flowery_app/features/tracking_order/presentation/widget/section_estimate.dart';
import 'package:flowery_app/features/tracking_order/presentation/widget/section_info_of_driver.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderNumber;
  const TrackOrderScreen({required this.orderNumber, super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final steps = [
    {'title': 'Received your order', 'date': '30'},
    {'title': 'Preparing your order', 'date': '60'},
    {'title': 'Out for delivery', 'date': '90'},
    {'title': 'Delivered', 'date': '120'},
  ];
  final _trackOrderCubit = serviceLocator.get<TrackOrderCubit>();
  @override
  void initState() {
    _trackOrderCubit.getDetailsOfTrackingOrderDirver(widget.orderNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile_Track_order.tr()),
      ),
      body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        bloc: _trackOrderCubit,
        builder: (context, state) {
          if (state.trackOrderState is BaseLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state.trackOrderState is BaseErrorState) {
            return Center(
              child: ErrorStateWidget(
                height: 50,
                width: 50,
                message: (state.trackOrderState as BaseErrorState).errorMessage,
                onRetry: () => _trackOrderCubit
                    .getDetailsOfTrackingOrderDirver(widget.orderNumber),
              ),
            );
          } else if (state.trackOrderState is BaseSuccessState) {
            final data = (state.trackOrderState
                    as BaseSuccessState<TrackOrderDetailsEntity>)
                .data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionEstimate(
                            estimateTime: DateFormat('dd MMM yyyy, hh:mm a')
                                .format(data!.dateTime))),
                    SizedBox(height: 16),
                    Divider(
                      color: AppColors.white[AppColors.colorCode70],
                    ),
                    SizedBox(height: 40),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionInfoOfDriver(
                            driverName: data!.firstName + " " + data.lastName,
                            phoneNumber: data.phone)),
                    SizedBox(height: 40),
                    Align(
                        alignment: Alignment.center,
                        child: CustomCacheNetworkImage(
                          width: double.infinity,
                          height: size * .17,
                          imageUrl: data.vehicleImage,
                        )),
                    SizedBox(height: 40),
                    Column(
                      children: List.generate(steps.length, (index) {
                        final isFirst = index == 0;
                        final isLast = index == steps.length - 1;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                if (!isFirst)
                                  Container(
                                      width: 2, height: 30, color: Colors.grey),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          isFirst ? Colors.pink : Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: isFirst
                                        ? Colors.pink
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                if (!isLast)
                                  Container(
                                      width: 2, height: 50, color: Colors.grey),
                              ],
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    steps[index]['title'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isFirst ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    DateFormat('dd MMM yyyy, hh:mm a').format(
                                        data.dateTime.add(Duration(
                                            minutes: int.parse(
                                                steps[index]['date']!)))),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => GoogleMapTrackingScreen()));
                            // Navigator.of(context).pushNamed(Routes.);
                          },
                          child: Text('Show map'),
                        ))
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
