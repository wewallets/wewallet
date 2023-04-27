import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/generated/l10n.dart';
import 'package:mars/widgets/dialog/selection_tips_dialog.dart';
import 'package:mars/widgets/loading_shade_custom.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:typed_data';

class LayoutUtil {
  static bool _isLoadingDialog = true;

  //通用标题
  static Widget getAppBar(context, title, {colors = Colours.white, leading = "break_black", actions, elevation: 0.5, onPressed, noLeading = false}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - ScreenUtil().setWidth(10)),
        child: AppBar(
          leading: noLeading
              ? Container()
              : CupertinoButton(
                  child: LoadImage(leading, width: ScreenUtil().setWidth(44), fit: BoxFit.contain),
                  padding: EdgeInsets.zero,
                  onPressed: onPressed ??
                      () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pop(context);
                      },
                ),
          elevation: elevation,
          title: Text(title, style: Styles.textTitle.copyWith(fontWeight: FontWeight.w500)),
          backgroundColor: colors,
          centerTitle: true,
          actions: actions ?? <Widget>[],
        ));
  }

  static buildErrorWidget({String errorImage, String errorText, double topHeight = 0, double imageWidth}) {
    return Container(
      width: ScreenUtil().screenWidth,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(topHeight)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[LoadImage(errorImage, width: imageWidth), Gaps.vGap10, Text(errorText ?? '${getString().zwsj}', style: TextStyle(fontSize: ScreenUtil().setSp(22), color: ColorsUtil.hexColor(0x999999)))],
      ),
    );
  }

  //等待中的窗口
  static showLoadingDialog(context, {msg}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    _isLoadingDialog = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            child: LoadingShadeCustom(alpha: 0.1, msg: msg ?? '${getString().zzjz}', loading: true, child: Container(), textColor: Colours.textBlack),
            onWillPop: () {
              _isLoadingDialog = false;
              return new Future.value(true);
            },
          );
        });
  }

  static closeLoadingDialog(context) {
    if (_isLoadingDialog) Navigator.pop(context);
  }

  static getCoin(coin) {
    return coin == 'USDT' ? 'UST' : coin;
  }

  static getLoadingShadeCustom({text, top = 0}) {
    return Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(top)), child: LoadingShadeCustom(alpha: 0.1, msg: text ?? '${getString().zzjz}', loading: true, child: Container(), textColor: Colours.textBlack));
  }

  //是否激活
  static bool isActivation(context) {
    if (GlobalTransaction.walletInfo == null || GlobalTransaction.walletInfo.is_activation == null || GlobalTransaction.walletInfo.is_activation == '0') {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colours.transparent,
          context: context,
          builder: (builder) {
            return SelectionTipsDialog(title: '${getString().zhzn}', content: '${getString().zhznsm}', rightText: '${getString().wzdl}', voidCallback: () {}, noLeftText: true);
          });
      return false;
    } else {
      return true;
    }
  }

  //是否登录
  static bool isLogin(context, {isShowLogin = false}) {
    if (GlobalTransaction.isLogin) {
      return true;
    } else if (isShowLogin) {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colours.transparent,
          context: context,
          builder: (builder) {
            return SelectionTipsDialog(
                title: '${getString().wcjqbdz}',
                content: '${getString().qxcjqb}',
                rightText: '${getString().cj}',
                leftText: '${getString().zb}',
                voidCallback: () {
                  Navigator.pushNamed(context, PageTransactionRouter.login_Page);
                });
          });
      return false;
    } else {
      return false;
    }
  }

  static getClassicFooter() {
    return ClassicFooter(
      canLoadingText: '',
      idleText: '',
      loadingText: getString().nljjz,
      noDataText: getString().mysjl,
      failedText: getString().hqhqsjsb,
      loadingIcon: SizedBox(width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40), child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colours.themeColor))),
    );
  }

  static getHeaderBuilder() {
    return CustomHeader(builder: (context, mode) {
      Widget body = Container();
      if (mode == RefreshStatus.idle) {
        body = Text(getString().xlsx, style: TextStyle(color: Colours.textGrey));
      } else if (mode == RefreshStatus.refreshing) {
        body = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(child: LoadImage('common_loading', format: 'gif', fit: BoxFit.fill, height: ScreenUtil().setWidth(30), width: ScreenUtil().setWidth(30)), padding: EdgeInsets.only(right: ScreenUtil().setWidth(30))),
            Padding(child: Text(getString().zzsx, style: TextStyle(color: Colours.textGrey)), padding: EdgeInsets.only(right: ScreenUtil().setWidth(80))),
          ],
        );
      } else if (mode == RefreshStatus.failed) {
        body = Text(getString().gxsb, style: TextStyle(color: Colours.textGrey));
      } else if (mode == RefreshStatus.completed) {
        body = Text(getString().gxwc, style: TextStyle(color: Colours.textGrey));
      } else if (mode == RefreshStatus.canRefresh) {
        body = Text(getString().sksx, style: TextStyle(color: Colours.textGrey));
      }
      return Container(
        margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
        child: Center(child: body),
      );
    });
  }
}

S get s {
  return S.of(GlobalTransaction.context);
}
S getString() {
  return S.of(GlobalTransaction.context);
}

bool getLocaleType() {
  if (SpUtil.getString('locale') == null || SpUtil.getString('locale') == 'zh') {
    return true;
  } else {
    return false;
  }
}

String getLocale() {
 return SpUtil.getString('locale');
}

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE
]);
