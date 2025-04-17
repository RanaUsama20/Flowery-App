import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../view_model/cubit/edit_profile_cubit.dart';

Future ShowModelBottomSheet(EditProfileCubit cubit, BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true, // Makes the modal respond better to keyboard
    builder: (BuildContext context) {
      return Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text(LocaleKeys.Authentication_takeAPhoto.tr()),
            onTap: () {
              cubit.handleImagePicking(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text(LocaleKeys.Authentication_ChooseFromGallery.tr()),
            onTap: () {
              cubit.handleImagePicking(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
