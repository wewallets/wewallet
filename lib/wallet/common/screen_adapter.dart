import 'package:flutter/material.dart';

class ScreenAdapter {
  static double wRatio = 1;
  static double hRatio = 1;
  static double fontRatio = 1;

  static init(context) {
    wRatio = MediaQuery.of(context).size.width / 375;
    hRatio = MediaQuery.of(context).size.height / 667;
    fontRatio = ScreenAdapter.wRatio;
  }
}

extension SizeExtension on num {
  double get w => this * ScreenAdapter.wRatio;
  double get h => this * ScreenAdapter.hRatio;
  double get sp => this * ScreenAdapter.fontRatio;
}
