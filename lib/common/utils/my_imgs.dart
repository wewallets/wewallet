import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 功能：
/// 描述：
/// crated by xudailong on 2020/5/29.
///
class MImage {
  static String getImgPath(String imgPath) {
    return 'assets/$imgPath';
  }

  static Image assetImage(String imgPath, double width, double height,
      {BoxFit fit = BoxFit.scaleDown}) {
    return Image.asset(
      'assets/$imgPath',
      width: width,
      height: height,
      fit: fit,
    );
  }

  static netImage(String s, double w, double h,
      {bool isQrCode = false,
      bool isHome = false,
      bool isProfile = true,
      bool size = false,
      BoxFit fit = BoxFit.fitWidth}) {
    return CachedNetworkImage(
        imageUrl: s,
        fit: fit,
        width: w,
        height: h,
        placeholder: (context, url) {
          return Container(
            height: h,
            width: w,
            child: assetImage('ic_profile.png', w, h),
          );
        });
    // return Image.network(s,width:w,height: h,fit: BoxFit.fitWidth,);
  }

  static String iconHome = 'ic_home.png';
  static String iconHome1 = 'ic_home1.png';

  static String iconZixuan = 'ic_zixuan.png';
  static String iconZixuan1 = 'ic_zixuan1.png';

  static String iconCircle = 'ic_circle.png';
  static String iconCircle1 = 'ic_circle1.png';

  static String iconTrans = 'ic_trans.png';
  static String iconTrans2 = 'ic_trans1.png';

  static String iconMine = 'ic_mine.png';
  static String iconMine2 = 'ic_mine1.png';
  static String iconBack = 'ic_mine1.png';

  static Image icLogo = assetImage('icon_launch.png', 48, 48);
  static Image icLogoName = assetImage('ic_luxi_zq.png', 100, 20);

  static Image icBack = assetImage('break_black.png', ScreenUtil().setWidth(44), ScreenUtil().setWidth(44));
  static Image icWalletUsdt = assetImage('ic_wallet_usdt.png', 30, 30);
  static Image icOreTopBg =
      assetImage('ic_ore_top_bg_qt.png', double.infinity, 195, fit: BoxFit.cover);
  static Image icSearch = assetImage('ic_search.png', 14, 14);
  static Image icItemFirst = assetImage('ic_ore_first.png', 80, 24);
  static Image icItemSecond = assetImage('ic_ore_second.png', 80, 24);
  static Image icDotMore = assetImage('ic_dot_more.png', 20, 5);
  static Image icDetailTopBg = assetImage(
      'kuangcixq_bg.png', ScreenUtil().screenWidth, 43,
      fit: BoxFit.scaleDown);
  static Image icEmpty = assetImage('ic_search_empty.png', 110, 80);
  static Image icDel = assetImage('ic_del.png', 17, 17);
  static Image icBtcMenu = assetImage('ic_btc_menu.png', ScreenUtil().setWidth(42), ScreenUtil().setWidth(40));
  static Image icBtcKlineThree = assetImage('ic_kline_three.png', ScreenUtil().setWidth(44), ScreenUtil().setWidth(40));
  static Image icByBtn = assetImage('ic_by_btn.png', 86, 35);
  static Image icSelBtn = assetImage('ic_sell_btn.png', 86, 35);
  static Image icAllFlag = assetImage('ic_all_flag.png', ScreenUtil().setWidth(38), ScreenUtil().setWidth(36));
  static Image icJian = assetImage('ic_jian.png', 35, 40);
  static Image icJia = assetImage('ic_jia.png', 35, 40);
  static Image icAllTag = assetImage('ic_all_tag.png', ScreenUtil().setWidth(44), ScreenUtil().setWidth(44));
  static Image icByTag = assetImage('ic_by_tag.png', ScreenUtil().setWidth(44), ScreenUtil().setWidth(44));
  static Image icSaleTag = assetImage('ic_sale_tag.png', ScreenUtil().setWidth(44), ScreenUtil().setWidth(44));
  static Image icSelBtn2 = assetImage('ic_trans_sell_green.png', 86, 35);
  static Image icByBtn2 = assetImage('ic_by_wait_white.png', 86, 35);
}
