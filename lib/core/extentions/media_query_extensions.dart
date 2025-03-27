import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext {
  // navigation methods
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();

  double wp(double percent) => MediaQuery.of(this).size.width * (percent / 100);
  double hp(double percent) =>
      MediaQuery.of(this).size.height * (percent / 100);
  double sp(double size) => MediaQuery.of(this).textScaler.scale(size);
}
