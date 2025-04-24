import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/features/categories/presentation/view/categories_screen.dart';
import 'package:flowery_app/features/home/presentation/view/home_screen.dart';
import 'package:flowery_app/features/profile/presentation/view/profile_screen.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cart/presentation/view/cart_screen.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const ProfileScreen(),
  ];

  Key _cartKey = UniqueKey(); // Unique key to force rebuild

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // The main content area (indexed stack to manage the different tabs)
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  _pages[0],  // Home screen
                  _pages[1],  // Categories screen
                  CartScreen(key: _cartKey), // Cart screen (use dynamic key here)
                  _pages[3],  // Profile screen
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar remains fixed at the bottom
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (selectedIndex) {
          setState(() {
            _currentIndex = selectedIndex;

            // Regenerate cart key on cart tab tap to force rebuild
            if (_currentIndex == 2) {
              _cartKey = UniqueKey();
            }
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

  // Icon for inactive state
  Widget _iconBar(String image) {
    return SvgPicture.asset(
      image,
      height: 27,
      width: 27,
    );
  }

  // Icon for active state
  Widget _activeIconBar(String image) {
    return SvgPicture.asset(
      image,
      height: 27,
      width: 27,
      color: AppColors.pink[AppColors.colorCode50],
    );
  }
}
