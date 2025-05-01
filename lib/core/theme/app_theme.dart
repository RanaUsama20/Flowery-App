import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts_family.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        splashColor: AppColors.pink[AppColors.colorCode10],
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.pink[AppColors.colorCode50]),
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.pink[AppColors.colorCode50],
    secondaryHeaderColor: AppColors.black,
    fontFamily: AppFontsFamily.inter,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: AppColors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 20),
      titleMedium: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 18),
      titleSmall: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 16),
      labelLarge: TextStyle(
          color: AppColors.pink, fontWeight: FontWeight.w700, fontSize: 20),
      labelMedium: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 14),
      labelSmall: TextStyle(
          color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 13),
      bodyLarge: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 12),
      bodyMedium: TextStyle(
          color: AppColors.pink, fontWeight: FontWeight.w500, fontSize: 12),
      bodySmall: TextStyle(
          color: AppColors.gray, fontWeight: FontWeight.w400, fontSize: 13),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.pink[AppColors.colorCode50],
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(AppColors.pink[AppColors.colorCode50]),
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10000),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(14),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(color: AppColors.red, fontSize: 12),
      contentPadding: const EdgeInsets.all(16),
      iconColor: AppColors.lightPink,
      hintStyle: TextStyle(
        color: AppColors.black[AppColors.colorCode30],
        fontSize: 14,
      ),
      prefixIconColor: AppColors.black,
      suffixIconColor: AppColors.black,
      labelStyle: TextStyle(
        fontSize: 12,
        color: AppColors.black[AppColors.colorCode40],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.black,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.red,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor:
            WidgetStateProperty.all(AppColors.pink[AppColors.colorCode50]),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
                color: AppColors.pink[AppColors.colorCode50],
                fontWeight: FontWeight.w600);
          }
          return TextStyle(
              color: AppColors.black[30], fontWeight: FontWeight.w500);
        },
      ),
      elevation: 0,
      backgroundColor: AppColors.lightPink,
      surfaceTintColor: AppColors.pink,
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: AppColors.pink),
      ),
      indicatorColor: AppColors.pink[AppColors.colorCode10],
    ),
    radioTheme: RadioThemeData(
        fillColor:
            WidgetStatePropertyAll((AppColors.pink[AppColors.colorCode50])),
        overlayColor:
            WidgetStatePropertyAll(AppColors.pink[AppColors.colorCode50])),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: AppColors.pink[AppColors.colorCode50],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.gray,
      selectedLabelStyle: TextStyle(
        fontSize: 14,
        color: AppColors.pink[AppColors.colorCode50],
        fontWeight: FontWeight.bold,
        fontFamily: AppFontsFamily.inter,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        color: AppColors.gray,
        fontFamily: AppFontsFamily.inter,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.pink[AppColors.colorCode50],
      unselectedLabelColor: AppColors.white[AppColors.colorCode70],
      dividerColor: Colors.transparent,
      labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      indicator: UnderlineTabIndicator(
        insets: EdgeInsets.zero,
        borderSide:
            BorderSide(width: 3, color: AppColors.pink[AppColors.colorCode50]!),
      ),
      labelPadding: const EdgeInsets.only(right: 24),
      tabAlignment: TabAlignment.start,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      backgroundColor: AppColors.white,
      dragHandleSize: Size(80, 4),
      dragHandleColor: AppColors.black,
      showDragHandle: true,
      elevation: 0,
    ),
  );
}

// isScrollable: true,
//
//       unselectedLabelStyle: Theme.of(context).textTheme.titleSmall!,
//       dividerColor: Colors.transparent,
