import 'package:easy_localization/easy_localization.dart';
import '../../generated/locale_keys.g.dart';
import '../constants/app_values.dart';

class Validator {
  Validator._();

  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(
      AppValues.emailRegex,
    );
    if (val == null) {
      return LocaleKeys.Error_EmailCannotBeEmpty.tr();
    } else if (val.trim().isEmpty) {
      return LocaleKeys.Error_EmailCannotBeEmpty.tr();
    } else if (emailRegex.hasMatch(val) == false) {
      return LocaleKeys.Error_EnterAValidEmail.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    final RegExp passwordRegex = RegExp(AppValues.passwordRegex);
    if (val == null) {
      return LocaleKeys.Error_PasswordCannotBeEmpty.tr();
    } else if (val.isEmpty) {
      return LocaleKeys.Error_PasswordCannotBeEmpty.tr();
    } else if (!passwordRegex.hasMatch(val)) {
      return LocaleKeys.Error_PasswordEnterAValidPassword.tr();
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return LocaleKeys.Error_PasswordCannotBeEmpty.tr();
    } else if (val != password) {
      return LocaleKeys.Error_ConfirmPasswordMustMatch.tr();
    } else {
      return null;
    }
  }

  static String? validateName(String? val) {
    if (val == null || val.isEmpty) {
      return LocaleKeys.Error_NameCannotBeEmpty.tr();
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return LocaleKeys.Error_PhoneNumberCannotBeEmpty.tr();
    } else if (int.tryParse(val.trim()) == null) {
      return LocaleKeys.Error_InvalidPhoneNumber.tr();
    } else if (val.trim().length != 11) {
      return LocaleKeys.Error_InvalidPhoneNumber.tr();
    } else {
      return null;
    }
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return LocaleKeys.Error_CodeCannotBeEmpty.tr();
    } else if (val.length < 6) {
      return LocaleKeys.Error_CodeShouldBeAtLeast6Digits.tr();
    } else {
      return null;
    }
  }
}
