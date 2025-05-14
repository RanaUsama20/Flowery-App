import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final steps = [
    {'title': 'Received your order', 'date': '03 Sep 2024 - 2:10'},
    {'title': 'Preparing your order', 'date': '03 Sep 2024 - 2:10'},
    {'title': 'Out for delivery', 'date': '03 Sep 2024 - 2:10'},
    {'title': 'Delivered', 'date': '03 Sep 2024 - 2:10'},
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile_Track_order.tr()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated arrival',
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '03 Sep 2024, 11:00 AM',
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Divider(
                color: AppColors.white[AppColors.colorCode70],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      SvgAssets.deliveryBoySvg,
                      width: 36,
                      height: 36,
                    ),
                    Expanded(
                        child: ListTile(
                      title: Text(
                        'Muhamed',
                        style: theme.textTheme.labelMedium,
                      ),
                      subtitle: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Is your delivery hero for today',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: AppColors.gray),
                        ),
                      ),
                    )),
                    SvgPicture.asset(SvgAssets.callPinkSvg),
                    SizedBox(width: 20),
                    SvgPicture.asset(SvgAssets.whatsappSvg),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(SvgAssets.carSvg)),
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
                            Container(width: 2, height: 30, color: Colors.grey),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isFirst ? Colors.pink : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor:
                                  isFirst ? Colors.pink : Colors.grey.shade300,
                            ),
                          ),
                          if (!isLast)
                            Container(width: 2, height: 50, color: Colors.grey),
                        ],
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              steps[index]['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isFirst ? Colors.black : Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              steps[index]['date']!,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
