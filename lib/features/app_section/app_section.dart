import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_assets.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_values.dart';
import 'package:flowery_app/core/utils/app_shared_preference.dart';
import 'package:flowery_app/features/cart/presentation/view/cart_screen.dart';
import 'package:flowery_app/features/categories/presentation/view/categories_screen.dart';
import 'package:flowery_app/features/home/presentation/view/didnot_login_screen.dart';
import 'package:flowery_app/features/home/presentation/view/home_screen.dart';
import 'package:flowery_app/features/profile/presentation/view/profile_screen.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  int _currentIndex = 0;
  Key _cartKey = UniqueKey();
  late Future<List<Widget>> _pagesFuture;

  @override
  void initState() {
    super.initState();
    _pagesFuture = _getPages();
  }

  Future<List<Widget>> _getPages() async {
    final token = await SharedPreferencesUtils.getString(AppValues.token);
    final isLoggedIn = token != null && token.isNotEmpty;

    return isLoggedIn
        ? [
      const HomeScreen(),
      const CategoriesScreen(),
      CartScreen(key: _cartKey), // Use key to reload cart
      const ProfileScreen(),
    ]
        : [
      const HomeScreen(),
      const CategoriesScreen(),
      const DidnotLoginScreen(), // Replace cart
      const DidnotLoginScreen(), // Replace profile
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: _pagesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final pages = snapshot.data!;

        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: _currentIndex,
              children: pages,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (selectedIndex) {
              if (selectedIndex == 2) {
                _cartKey = UniqueKey(); // Regenerate cart key
                _pagesFuture = _getPages(); // Rebuild future with new cart
              }
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
      },
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
