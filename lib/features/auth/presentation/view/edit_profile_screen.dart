import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flowery_app/features/auth/data/model/request/edit_profile_request.dart';
import 'package:flowery_app/features/auth/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:flowery_app/features/auth/presentation/view_model/cubit/edit_profile_state.dart';
import 'package:flowery_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../widgets/build_profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileRequest userData;

  EditProfileScreen({required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

enum Gender { male, female }



class _EditProfileScreenState extends State<EditProfileScreen> {
  Gender? selectedGender;
  late EditProfileCubit cubit;
  bool check = false;
  EditProfileRequest request = EditProfileRequest();

  late TextEditingController firstNameC ;
  late TextEditingController lastNameC ;
  late TextEditingController emailC ;
  late TextEditingController phoneC ;



  @override
  void initState() {
    super.initState();
    cubit = serviceLocator.get<EditProfileCubit>();
    firstNameC = TextEditingController(text: widget.userData.firstName);
    lastNameC = TextEditingController(text: widget.userData.lastName);
    emailC = TextEditingController(text: widget.userData.email);
    phoneC = TextEditingController(text: widget.userData.phone);

  }

  @override
  void dispose() {
    firstNameC.dispose();
    lastNameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.status == EditProfileStatus.loading) {
          AppDialogs.showLoadingDialog(context);
        } else if (state.status == EditProfileStatus.success) {
          Navigator.of(context).pop();
          AppDialogs.showSuccessDialog(context, message: "success");
        } else if (state.status == EditProfileStatus.failure) {
          Navigator.of(context).pop();
          AppDialogs.showFailureDialog(context,
              message: state.errorMessage.toString());
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context, 'refresh');
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: context.sp(20),
                              ),
                            ),
                            Text(
                              " ${LocaleKeys.Profile_EditProfile.tr()}",
                              style: AppTheme.lightTheme.textTheme.titleLarge,
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          SvgAssets.notificationSvg,
                          width: context.wp(4),
                          height: context.hp(3.5),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 12,
                      child: Container(
                        width: context.wp(4),
                        height: context.hp(2.5),
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                              "3",
                              style: AppTheme.lightTheme.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.white),
                            )),
                      ),
                    ),
                  ]),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return buildProfileImage(cubit, context,widget.userData.url!);
                    },
                  ),
                  SizedBox(
                    height: context.hp(7),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextFormField(
                            controller: firstNameC,
                            hint: "",
                            label: LocaleKeys.Authentication_FirstName.tr(),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: CustomTextFormField(
                            controller: lastNameC,
                            hint: "",
                            label: LocaleKeys.Authentication_LastName.tr(),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: context.hp(3.5),
                  ),
                  CustomTextFormField(
                    controller: emailC,
                    hint: "",
                    label: LocaleKeys.Authentication_Email.tr(),
                  ),
                  SizedBox(
                    height: context.hp(3.5),
                  ),
                  CustomTextFormField(
                    controller: phoneC,
                    hint: "",
                    label: LocaleKeys.Authentication_PhoneNumber.tr(),
                  ),
                  SizedBox(
                    height: context.hp(3.5),
                  ),
                  CustomTextFormField(
                    hint: "",
                    label: LocaleKeys.Authentication_Password.tr(),
                    widget: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: context.sp(16),
                        ),
                        Icon(
                          Icons.star,
                          size: context.sp(16),
                        ),
                        Icon(
                          Icons.star,
                          size: context.sp(16),
                        ),
                        Icon(
                          Icons.star,
                          size: context.sp(16),
                        ),
                        Icon(
                          Icons.star,
                          size: context.sp(16),
                        ),
                        Icon(
                          Icons.star,
                          size: context.sp(16),
                        ),
                      ],
                    ),
                    suffixWidget: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.changePassword);

                        },
                        child: Text(LocaleKeys.Profile_Change.tr(),
                            style: AppTheme.lightTheme.textTheme.labelLarge!
                                .copyWith(
                              fontSize: 12,
                            ))),
                  ),

                  SizedBox(
                    height: context.hp(4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        LocaleKeys.Authentication_Gender.tr(),
                        style: AppTheme.lightTheme.textTheme.titleMedium!
                            .copyWith(color: AppColors.gray),
                      ),
                      Radio<Gender>(
                        value: Gender.male,
                        groupValue: selectedGender,
                        overlayColor: WidgetStatePropertyAll(
                            Colors.transparent), // no big color on press

                        onChanged: (Gender? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text(
                        LocaleKeys.Authentication_Male.tr(),
                        style: AppTheme.lightTheme.textTheme.labelMedium,
                      ),
                      Row(
                        children: [
                          Radio<Gender>(
                            value: Gender.female,
                            groupValue: selectedGender,
                            overlayColor: WidgetStatePropertyAll(
                                Colors.transparent), // no big color on press

                            onChanged: (Gender? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          Text(LocaleKeys.Authentication_Female.tr(),
                              style: AppTheme.lightTheme.textTheme.labelMedium),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.hp(4)),
                  // Female Option

                  InkWell(
                    onTap: () {
                      cubit.submitProfile(
                        firstName: firstNameC.text,
                        lastName: lastNameC.text,
                        email: emailC.text,
                        phone: phoneC.text,
                      );
                    },
                    child: Container(
                      width: context.wp(90),
                      height: context.hp(7),
                      decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.circular(context.sp(40)),
                      ),
                      child: Center(
                        child: Text(
                          LocaleKeys.Profile_Update.tr(),
                          style: AppTheme.lightTheme.textTheme.labelLarge!
                              .copyWith(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






