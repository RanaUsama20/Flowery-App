import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_fonts_family.dart';
import 'package:flowery_app/core/constants/app_values.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/custom_cache_network_image.dart';
import 'package:flowery_app/features/profile/presentation/view_model/profile_main/profile_main_cubit.dart';
import 'package:flowery_app/features/profile/presentation/widget/custom_witch.dart';
import 'package:flowery_app/features/profile/presentation/widget/language_bottom_sheet.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/app/app_cubit/app_cubit_cubit.dart';
import '../../../../core/enum/state_user.dart';
import '../../../../core/utils/widgets/error_widget.dart';
import '../../../auth/data/model/request/edit_profile_request.dart';
import '../view_model/profile_main/profile_main_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileMainCubit cubit;
  late AppCubit _appCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = serviceLocator<ProfileMainCubit>();
    _appCubit = serviceLocator<AppCubit>();
    if (_appCubit.getStateUser == StateUser.login) {
      cubit.getProfileData();
    }
  }

  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileMainCubit, ProfileMainState>(
      builder: (context, state) {
        if (state.isProfileMainLoading) {
          return Skeletonizer(
            child: _topSectionDetails(
              email: "Mohamed@gmail.com",
              name: "Mohamed",
              imageUrl: imageUrl,
            ),
          );
        }
        if (state.isProfileMainFailure) {
          return Center(
            child: ErrorStateWidget(
                height: 50,
                width: 50,
                message: state.errorMessage,
                onRetry: () =>
                    context.read<ProfileMainCubit>().getProfileData()),
          );
        }
        if (state.isProfileMainSuccess){
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _customAppBar(),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              children: [
                _topSectionDetails(
                  email: state.profileData.user.email,
                  editProfileData: EditProfileRequest(
                      firstName: state.profileData.user.firstName,
                      lastName: state.profileData.user.lastName,
                      email: state.profileData.user.email,
                      phone: state.profileData.user.phone,
                      url: state.profileData.user.photo),
                  name:
                      "${state.profileData.user.firstName} ${state.profileData.user.lastName}",
                  imageUrl: state.profileData.user.photo,
                ),
                const SizedBox(height: 32),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _itemSection(
                        leading: _iconSvg(SvgAssets.order),
                        trailing: _arrowIos(),
                        title: LocaleKeys.profile_MyOrder.tr(),
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.order);
                        },
                      ),
                      _itemSection(
                        leading: _iconSvg(SvgAssets.location2Svg),
                        trailing: _arrowIos(),
                        title: LocaleKeys.profile_SavedAddress.tr(),
                        onTap: () {
                          final state = context.read<ProfileMainCubit>().state;

                          if (state.isProfileMainSuccess) {
                            print("------------------------------");
                            print(
                              state.profileData.user.addresses,
                            );
                            Navigator.pushNamed(
                              context,
                              Routes.savedAddress,
                              arguments: state.profileData.user.addresses,
                            ).then((result) {
                              if (result == 'refresh') {
                                context
                                    .read<ProfileMainCubit>()
                                    .getProfileData();
                              }
                            });
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      const Divider(),
                      SizedBox(height: 16),
                      _itemSection(
                        leading: CustomSwitch(
                          width: 42,
                          height: 20,
                          value: isOn,
                          onChanged: (value) {
                            setState(() {
                              isOn = value;
                            });
                          },
                        ),
                        trailing: _arrowIos(),
                        title: LocaleKeys.profile_Notification.tr(),
                        onTap: () {},
                      ),
                      SizedBox(height: 16),
                      const Divider(),
                      SizedBox(height: 16),
                      _itemSection(
                        leading: _iconSvg(SvgAssets.translate),
                        trailing: Text(
                          context.locale.languageCode == AppValues.english
                              ? LocaleKeys.profile_English.tr()
                              : LocaleKeys.profile_Arabic.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        title: LocaleKeys.profile_Language.tr(),
                        onTap: () {
                          _showBottomSheetLang();
                        },
                      ),
                      _itemSection(
                        trailing: _arrowIos(),
                        title: LocaleKeys.profile_AboutUs.tr(),
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.aboutApp);
                        },
                      ),
                      _itemSection(
                        trailing: _arrowIos(),
                        title: LocaleKeys.profile_TermsConditions.tr(),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.termsAndCondition);
                        },
                      ),
                      SizedBox(height: 16),
                      const Divider(),
                      SizedBox(height: 16),
                      BlocListener<ProfileMainCubit, ProfileMainState>(
                        listener: (context, state) {
                          if (state.isLogoutLoading) {
                            AppDialogs.showLoadingDialog(context);
                          } else if (state.isLogoutSuccess) {
                            Navigator.pushNamed(context, Routes.appSection);
                          } else if (state.isLogoutFailure) {
                            AppDialogs.showFailureDialog(context,
                                message: state.logOutMessageResponse);
                          }
                        },
                        child: _itemSection(
                          trailing: Icon(Icons.login_outlined),
                          title: LocaleKeys.profile_Logout.tr(),
                          onTap: () {
                            context.read<ProfileMainCubit>().logout();
                          },
                        ),
                      ),
                      const SizedBox(),
                      Text(
                        "v 6.3.0 - (446)",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.white[AppColors.colorCode90],
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          )
        ]);}
       return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.Error_YouHaveToLoginToUseThisFeature.tr()),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.login);
                  },
                  child: Text(LocaleKeys.Authentication_Login.tr()))
            ],
          ),
        );

      },
    );
  }

  Widget _topSectionDetails({
    required String imageUrl,
    required String name,
    required String email,
    EditProfileRequest? editProfileData,
  }) {
    return Column(
      children: [
        CustomCacheNetworkImage(
          imageUrl: imageUrl,
          height: 90,
          width: 90,
          isCircular: true,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.editProfile,
                          arguments: editProfileData)
                      .then((result) {
                    if (result == 'refresh') {
                      context.read<ProfileMainCubit>().getProfileData();
                    }
                  });
                },
                child: SvgPicture.asset(SvgAssets.pen)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.white[AppColors.colorCode90],
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _itemSection({
    Widget? leading,
    required Widget trailing,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            leading ?? const SizedBox.shrink(),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.black,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }

  Icon _arrowIos() {
    return Icon(
      Icons.arrow_forward_ios,
      size: 20,
      color: AppColors.white[AppColors.colorCode90],
    );
  }

  SvgPicture _iconSvg(String iconPath) {
    return SvgPicture.asset(
      iconPath,
      height: 20,
      width: 20,
      color: AppColors.black,
    );
  }

  Widget _customAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgAssets.flowerSvg,
            height: 25,
            width: 25,
          ),
          const SizedBox(width: 6),
          Text(
            AppValues.appTitle,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontFamily: AppFontsFamily.imFelli,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.notification);
            },
            child: Badge(
              smallSize: 3,
              isLabelVisible: true,
              // largeSize: 30,
              label: Text('3'),
              child: SvgPicture.asset(
                SvgAssets.notificationSvg,
                width: 25,
                height: 25,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showBottomSheetLang() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }
}

String imageUrl =
    "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
