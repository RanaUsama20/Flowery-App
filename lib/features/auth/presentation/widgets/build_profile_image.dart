import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/features/auth/presentation/widgets/show_model_bootom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../view_model/cubit/edit_profile_cubit.dart';

Widget buildProfileImage(EditProfileCubit cubit,BuildContext context) {
  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      if (cubit.image == null)
        CircleAvatar(
          radius: context.sp(55),
          backgroundColor: AppColors.gray,
          backgroundImage: AssetImage(SvgAssets.photoCameraSvg),
        )
      else
        CircleAvatar(
          radius: context.sp(55),
          backgroundImage: FileImage(cubit.image!),

        ),
      Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          onTap: () => ShowModelBottomSheet(cubit, context),
          child: Container(
            width: context.wp(7.5),
            height: context.hp(4),
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.camera_alt_outlined, color: AppColors.gray, size: context.sp(25)),
          ),
        ),
      ),
    ],
  );
}

