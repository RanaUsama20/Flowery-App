import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: context.wp(5),
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: context.sp(25),
        ),
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.titleLarge,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
