import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/cart/presentation/pages/cart_screen.dart';
import 'package:flowery_app/features/categories/presentation/pages/categories_screen.dart';
import 'package:flowery_app/features/home/presentation/pages/home_screen.dart';
import 'package:flowery_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  final List<Widget> _pages = const [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (selectedIndex) {
          _currentIndex = selectedIndex;
          setState(() {});
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
