import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SectionInfoOfDriver extends StatelessWidget {
 final  String driverName;
 final  String phoneNumber;
  const SectionInfoOfDriver({required this.driverName,required this.phoneNumber,super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Row(
                  children: [
                    SvgPicture.asset(
                      SvgAssets.deliveryBoySvg,
                      width: 36,
                      height: 36,
                    ),
                    Expanded(
                        child: ListTile(
                      title: Text(
                        driverName,
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
                );
  }
}