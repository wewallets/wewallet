import 'package:flutter/cupertino.dart';
import 'package:mars/wallet/common/component_index.dart';

class Images {
  //登录
  static String login_b_bg = 'login_b_bg';
  static String home_qianbao = 'home_qianbao';

  //主页
  static String main_icon1 = 'main_icon1';
  static String main_icon2 = 'main_icon2';
  static String main_icon3 = 'main_icon3';
  static String main_icon4 = 'main_icon4';
  static String main_icon5 = 'main_icon5';
  static String main_icon6 = 'main_icon6';
  static String main_icon7 = 'main_icon7';
  static String main_icon8 = 'main_icon8';
  static String main_icon9 = 'main_icon9';
  static String main_icon10 = 'main_icon10';
}

//按钮
class Buttons {
  //确定按钮
  static Widget getDetermineButton({bool isUse = true, String buttonText = '确定', VoidCallback onPressed, height, margin, color}) {
    return inkButton(
      onPressed: onPressed,
      child: Container(
        height: height ?? dp(48),
        width: double.infinity,
        margin: margin,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(25))), color: color ?? Colours().themeColor),
        child: Center(child: Text(buttonText, style: TextStyles().textWhite16.copyWith(color: Colours().white))),
      ),
    );
  }

  static Widget getSmallButton({double widthDp = 183, double heightDp = 40, String buttonText = 'Cancel', textColor, VoidCallback voidCallback, bgColor}) {
    return CupertinoButton(
      child: Container(
          width: dp(widthDp),
          height: dp(heightDp),
          child: Text('$buttonText', style: TextStyles().textWhite16.copyWith(color: textColor ?? Colours().white)),
          alignment: Alignment.center,
          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage(getImgPath('small_button'))))),
      padding: EdgeInsets.zero,
      onPressed: voidCallback,
    );
  }

  static Widget buildButton({child, onPressed}) {
    return CupertinoButton(
      child: child,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
    );
  }
}

//输入框
class InputBox {}

//列表
class ListItem {}
