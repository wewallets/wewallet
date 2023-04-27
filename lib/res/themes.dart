import 'package:mars/common/transaction_component_index.dart';

class Styles {
  static TextStyle textHeadline = TextStyle(fontSize: ScreenUtil().setSp(54), color: Colours.textBlack, fontWeight: FontWeight.bold);
  static TextStyle textTitle = TextStyle(fontSize: ScreenUtil().setSp(36), color: Colours.textBlack);
  static TextStyle textContent = TextStyle(fontSize: ScreenUtil().setSp(28), color: Colours.textBlack);
  static TextStyle textSmallContent = TextStyle(fontSize: ScreenUtil().setSp(24), color: Colours.textBlack);
  static TextStyle textAuxiliary = TextStyle(fontSize: ScreenUtil().setSp(22), color: Colours.textGrey6);
  static TextStyle textWeaken = TextStyle(fontSize: ScreenUtil().setSp(20), color: Colours.textGrey);
}

//图片
class Images {
  //app内部logo
  static String ic_launcher = 'ic_launcher';

  //首页TAB
  static String home_tab_0 = 'home_tab_0';
  static String home_tab_1 = 'home_tab_1';
  static String home_tab_2 = 'home_tab_2';
  static String home_tab_3 = 'home_tab_3';
  static String home_tab_4 = 'home_tab_4';
  static String home_tab_5 = 'home_tab_5';
  static String home_tab_6 = 'home_tab_6';
  static String home_tab_7 = 'home_tab_7';
  static String home_tab_8 = 'home_tab_8';
  static String home_tab_9 = 'home_tab_9';

  //窗口关闭图标
  static String combined_shape_26671 = 'combined_shape_26671';

  //返回箭头
  static String break_black = 'break_black';

  //密码显示隐藏
  static String asset_eye = 'asset_eye';
  static String asset_eyg = 'asset_eyg';
  static String asset_eye1 = 'asset_eye1';
  static String asset_eyg1 = 'asset_eyg1';

  static String choice = 'choice';
  static String no_choice = 'no_choice';
  static String content_tx = 'content_tx';
  static String understanding_bg = 'understanding_bg';

  static String coin_record = 'coin_record';
}

//按钮
class Buttons {
  //确定按钮
  static Widget getDetermineButton({bool isUse = true, String buttonText , VoidCallback voidCallback, bgImage = 'qt_qrann', color = Colours.themeColor,borderRadius=44}) {
    return Container(
      height: ScreenUtil().setWidth(88),
      width: double.infinity,
      decoration: isUse == false ? BoxDecoration(color: Colours.colorDE, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(44))) : BoxDecoration(color: color, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(borderRadius))),
      child: InkWell(
        //#
        onTap: voidCallback,
        child: Center(child: Text(buttonText??'${s.qd}', style: TextStyles.textWhite16)),
      ),
    );
  }

  //小确定按钮
  static Widget getSmallDetermineButton({bool isUse = true, String buttonText = '确定', VoidCallback voidCallback}) {
    return Container(
      height: ScreenUtil().setWidth(80),
      width: ScreenUtil().setWidth(450),
      child: inkButton(
        // color: isUse == false ? Colours.colorDE : Colours.themeColor,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(44))),
        child: Text(buttonText, style: TextStyles.textWhite16),
        onPressed: voidCallback,
      ),
    );
  }
}

//输入框
class InputBox {}

//列表
class ListItem {}
