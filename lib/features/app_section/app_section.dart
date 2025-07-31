import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flowery_app/features/categories/presentation/view/categories_screen.dart';
import 'package:flowery_app/features/categories/presentation/view_model/categories_cubit.dart';
import 'package:flowery_app/features/home/presentation/view/home_screen.dart';
import 'package:flowery_app/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:flowery_app/features/profile/presentation/view/profile_screen.dart';
import 'package:flowery_app/features/profile/presentation/view_model/profile_main/profile_main_cubit.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cart/presentation/view/cart_screen.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  late final Widget _homePage;
  late final HomeCubit _homeCubit;
  late final Widget _profilePage;
  late final ProfileMainCubit _profileMainCubit;
  late List<Widget> _pages;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeCubit = serviceLocator.get<HomeCubit>()..getHomeData();
    _profileMainCubit = serviceLocator.get<ProfileMainCubit>()..getProfileData();
    _homePage = BlocProvider<HomeCubit>(
      create: (_) => _homeCubit,
      child: const HomeScreen(),
    );
    _profilePage = BlocProvider<ProfileMainCubit>(
      create: (_) => _profileMainCubit,
      child: const ProfileScreen(),
    );
    _pages = [
      _homePage,
      BlocProvider<CategoriesCubit>(
        create: (context) => serviceLocator.get<CategoriesCubit>(),
        child: const CategoriesScreen(),
      ),
      BlocProvider<CartCubit>(
        create: (context) => serviceLocator.get<CartCubit>(),
        child: CartScreen(),
      ),
      _profilePage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (selectedIndex) {
          setState(() {
            _currentIndex = selectedIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _iconBar(SvgAssets.homeSvg),
            activeIcon: _activeIconBar(SvgAssets.homeSvg),
            label: LocaleKeys.Home_Home.tr(),
          ),
          BottomNavigationBarItem(
            icon: _iconBar(SvgAssets.categorySvg),
            activeIcon: _activeIconBar(SvgAssets.categorySvg),
            label: LocaleKeys.Home_Categories.tr(),
          ),
          BottomNavigationBarItem(
            icon: _iconBar(SvgAssets.shoppingCartSvg),
            activeIcon: _activeIconBar(SvgAssets.shoppingCartSvg),
            label: LocaleKeys.Home_Cart.tr(),
          ),
          BottomNavigationBarItem(
            icon: _iconBar(SvgAssets.personSvg),
            activeIcon: _activeIconBar(SvgAssets.personSvg),
            label: LocaleKeys.Home_Profile.tr(),
          ),
        ],
      ),
    );
  }

  Widget _iconBar(String image) {
    return SvgPicture.asset(
      image,
      height: 27,
      width: 27,
    );
  }

  Widget _activeIconBar(String image) {
    return SvgPicture.asset(
      image,
      height: 27,
      width: 27,
      color: AppColors.pink[AppColors.colorCode50],
    );
  }
}
