import 'dart:math';

import 'package:mars/common/utils/num_util.dart';

class NumberUtil {
  static String format(double n) {
    if (n >= 10000) {
      n /= 1000;
      return "${NumUtil.formatNum(n.toString(),4).toString()}K";
    } else {
      return NumUtil.formatNum(n.toString(),4).toString();
    }
  }

  static int getDecimalLength(double b) {
    String s = b.toString();
    int dotIndex = s.indexOf(".");
    if (dotIndex < 0) {
      return 0;
    } else {
      return s.length - dotIndex - 1;
    }
  }

  static int getMaxDecimalLength(double a, double b, double c, double d) {
    int result = max(getDecimalLength(a), getDecimalLength(b));
    result = max(result, getDecimalLength(c));
    result = max(result, getDecimalLength(d));
    return result;
  }

  static bool checkNotNullOrZero(double a) {
    if (a == null || a == 0) {
      return false;
    } else if (a.abs().toStringAsFixed(4) == "0.0000") {
      return false;
    } else {
      return true;
    }
  }
}
