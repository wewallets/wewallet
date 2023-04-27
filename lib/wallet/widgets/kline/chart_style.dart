import 'package:flutter/material.dart' show Color;

class ChartColors {
  ChartColors._();

  static const Color kLineColor = Color(0xff4C86CD);
  static const Color lineFillColor = Color(0xFFD8D8D8);
  static const Color ma5Color = Color(0xff519D9B);
  static const Color ma10Color = Color(0xff927BC1);
  static const Color ma30Color = Color(0xff9979C6);
  static const Color upColor =Color(0xff16A47A) ;
  static const Color dnColor = Color(0xffD94F57);
  static const Color volColor = Color(0xffCCB280);

  static const Color macdColor = Color(0xff4729AE);
  static const Color difColor = Color(0xffC9B885);
  static const Color deaColor = Color(0xff6CB0A6);

  static const Color kColor = Color(0xffC9B885);
  static const Color dColor = Color(0xff6CB0A6);
  static const Color jColor = Color(0xff9979C6);
  static const Color rsiColor = Color(0xffC9B885);

  static const Color defaultTextColor = Color(0xff97A2AF);

  //深度颜色
  static const Color depthBuyColor = Color(0xffd94f57);
  static const Color depthSellColor = Color(0xff16a47a);

  //选中后显示值背景的填充颜色
  static const Color selectFillColor = Color(0xffffffff);

  static Color getMAColor(int index) {
    Color maColor = ma5Color;
    switch (index % 3) {
      case 0:
        maColor = ma5Color;
        break;
      case 1:
        maColor = ma10Color;
        break;
      case 2:
        maColor = ma30Color;
        break;
    }
    return maColor;
  }
}

class ChartStyle {
  ChartStyle._();

  //点与点的距离
  static const double pointWidth = 11.0;

  //蜡烛宽度
  static const double candleWidth = 8.5;

  //蜡烛中间线的宽度
  static const double candleLineWidth = 1.5;

  //vol柱子宽度
  static const double volWidth = 8.5;

  //macd柱子宽度
  static const double macdWidth = 3.0;

  //垂直交叉线宽度
  static const double vCrossWidth = 8.5;

  //水平交叉线宽度
  static const double hCrossWidth = 0.5;
}
