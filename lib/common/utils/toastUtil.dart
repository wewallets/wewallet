import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import 'colorsUtil.dart';

class ToastUtil {
  static showBottomToast(
    String msg, {
    int timeInSecForIos = 1,
    double fontSize = 30,
    Color textColor,
  }) {
    Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: msg, toastLength: Toast.LENGTH_SHORT, textColor: textColor == null ? ColorsUtil.hexColor(0x999999) : textColor, fontSize: fontSize);
  }

  static showCenterToast(
    String msg, {
    int timeInSecForIos = 1,
    double fontSize = 30,
    Color textColor,
  }) {
    Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: msg, toastLength: Toast.LENGTH_SHORT, textColor: textColor == null ? ColorsUtil.hexColor(0x999999) : textColor, fontSize: fontSize);
  }
}
