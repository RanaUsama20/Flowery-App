import 'package:flutter/material.dart';

abstract class AppValues {
  static const appTitle = 'Flowery';
  static const String pathTranslation = "assets/translations";
  static const Locale arabicLocale = Locale("ar");
  static const Locale englishLocale = Locale("en");
  static const String arabic = "ar";
  static const String english = "en";
  static const List<Locale> supportedLocales = [englishLocale, arabicLocale];
  static const String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String passwordRegex = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@]{6,}$';
  static const String usernameRegex = r'^[a-zA-Z0-9,.-]+$';
  static const String pendingState = "pending";
  static const String inProgressState = "inProgress";
  static const String completedState = "completed";
  static const String canceledState = "canceled";

  // shared preferences keys
  static const String stateUser = "StateUser";
  static const String token = "token";
}
