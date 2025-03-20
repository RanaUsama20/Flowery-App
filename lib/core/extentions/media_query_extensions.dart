import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext {
  double wp(double percent) => MediaQuery.of(this).size.width * (percent / 100);
  double hp(double percent) => MediaQuery.of(this).size.height * (percent / 100);
  double sp(double size) => MediaQuery.of(this).textScaler.scale(size);
}
