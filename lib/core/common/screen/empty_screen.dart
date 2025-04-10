import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.wp(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(SvgAssets.empty),
        ],
      ),
    );
  }
}
