import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../generated/l10n.dart';
import '../widgets/dialog/select_country_dialog.dart';
import '../widgets/loading_shade_custom.dart';
import 'component_index.dart';

//适配
double adaptation(double px) {
  return ScreenUtil().setWidth(px);
}

//适配DP
double dp(double dp) {
  return ScreenUtil().setWidth(dp * 2);
}

//适配文字
double adaptationSp(double sp) {
  return ScreenUtil().setSp(sp);
}

//适配文字DP
double textDp(double dp) {
  return ScreenUtil().setSp(dp * 2);
}

inkButton({child, onPressed, double minSize}) {
  return CupertinoButton(
    minSize: minSize ?? 0,
    child: child,
    padding: EdgeInsets.zero,
    onPressed: onPressed,
  );
}

load(locale) {
  return S.load(locale);
}

S get s {
  return S.of(Global.getContext);
}

S getString() {
  return S.of(Global.getContext);
}

//界面跳转
navigatorContextPush(context, path, {Bundle bundle, transition = TransitionType.cupertino, isPop}) {
  if (isPop == true) PageWalletRouter.router.pop(context);
  return PageWalletRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition);
}

navigateToContext(context, path, {Bundle bundle, transition = TransitionType.cupertino, bool replace = false, bool clearStack = false}) {
  return PageWalletRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition, replace: replace, clearStack: clearStack);
}

//获取通用listView
Widget listViewBuilder({@required IndexedWidgetBuilder itemBuilder, padding, isSlide = false, itemCount, scrollDirection = Axis.vertical}) {
  return ListView.builder(
    padding: padding ?? EdgeInsets.zero,
    itemBuilder: itemBuilder,
    shrinkWrap: isSlide,
    scrollDirection: scrollDirection,
    physics: isSlide ? NeverScrollableScrollPhysics() : null,
    itemCount: itemCount,
  );
}

Widget waterfallFlowBuilder({@required IndexedWidgetBuilder itemBuilder, padding, isSlide = false, itemCount, crossAxisCount = 2}) {
  return WaterfallFlow.builder(
    gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, lastChildLayoutTypeBuilder: (index) => index == itemCount ? LastChildLayoutType.foot : LastChildLayoutType.none),
    padding: padding ?? EdgeInsets.zero,
    itemBuilder: itemBuilder,
    shrinkWrap: isSlide,
    physics: isSlide ? NeverScrollableScrollPhysics() : null,
    itemCount: itemCount,
  );
}

Widget gridViewBuilder({@required IndexedWidgetBuilder itemBuilder, padding, isSlide = false, itemCount, crossAxisCount = 2}) {
  return GridView.builder(
    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, mainAxisSpacing: 0, crossAxisSpacing: 0, childAspectRatio: 0.8),
    padding: padding ?? EdgeInsets.zero,
    itemBuilder: itemBuilder,
    shrinkWrap: isSlide,
    physics: isSlide ? NeverScrollableScrollPhysics() : null,
    itemCount: itemCount,
  );
}

//关闭当前界面
contextPop(context) {
  PageWalletRouter.router.pop(context);
}

//普通提示
showToast(msg, {Toast toastLength, int timeInSecForIos = 1, double fontSize = 16.0, ToastGravity gravity: ToastGravity.CENTER, Color backgroundColor, Color textColor}) {
  Fluttertoast.showToast(msg: msg, toastLength: toastLength, fontSize: fontSize, gravity: gravity, backgroundColor: backgroundColor, textColor: textColor);
}

buildLoadingShadeCustom({text, double top = 0.0}) {
  return Padding(padding: EdgeInsets.only(top: adaptation(top)), child: LoadingShadeCustom(alpha: 0.1, msg: text ?? 'Loading', loading: true, child: Container(), textColor: Colours().textTheme1));
}

bool isLoginContext(context, {isShowLogin = true}) {
  if (Global.isLogin) {
    return true;
  } else if (isShowLogin) {
    showDialog(
        context: context,
        builder: (context) => SelectCountryDialog(0, (data) async {
              if (data == '创建新钱包')
                navigateToContext(context, PageWalletRouter.select_chain_page, bundle: Bundle()..putInt('type', 0));
              else
                navigateToContext(context, PageWalletRouter.select_chain_page, bundle: Bundle()..putInt('type', 1));
            }, ['创建新钱包', '导入钱包']));
    return false;
  } else {
    return false;
  }
}

getCurrencyNumber(String data) {
  final format = NumberFormat("#,##0", "en_US");
  return format.format(double.parse(data)).toString();
}

//通用标题
Widget getContextAppBar(context, title, {colors, leading = "break_left", List<Widget> actions, double elevation: 0.0, onPressed, noLeading = false, textColor}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight - adaptation(10)),
      child: AppBar(
        leading: noLeading
            ? Container()
            : CupertinoButton(
                child: LoadAssetImage(leading, width: adaptation(40), height: adaptation(40), fit: BoxFit.contain),
                padding: EdgeInsets.zero,
                onPressed: onPressed ??
                    () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pop(context);
                    },
              ),
        elevation: elevation,
        title: Text(title, style: TextStyle(fontSize: adaptationSp(37), color: textColor ?? Colours().textTheme1, fontWeight: FontWeight.w500)),
        backgroundColor: colors ?? Colours().textTheme2,
        centerTitle: true,
        actions: actions ?? [],
      ));
}

buildErrorWidget({String errorImage = 'no_data', String errorText, double topHeight = 0, double bottomHeight = 0, double imageWidth = 300}) {
  return Container(
    width: ScreenUtil().screenWidth,
    margin: EdgeInsets.only(top: ScreenUtil().setWidth(topHeight), bottom: ScreenUtil().setWidth(bottomHeight)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadImage(
          errorImage,
          width: ScreenUtil().setWidth(imageWidth),
        ),
        Gaps.vGap10,
        Text(errorText ?? '${s.text324}', style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xFFC8CFDB)))
      ],
    ),
  );
}

bool _isLoadingDialog = true;
//等待中的窗口
showLoadingContextDialog(context, {msg}) async {
  FocusScope.of(context).requestFocus(FocusNode());
  _isLoadingDialog = true;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          child: LoadingShadeCustom(alpha: 0.1, msg: msg ?? '${s.text325}', loading: true, child: Container(), textColor: Colours().textTheme1),
          onWillPop: () {
            _isLoadingDialog = false;
            return new Future.value(true);
          },
        );
      });
}

closeLoadingContextDialog(context) {
  if (_isLoadingDialog) contextPop(context);
}

toConfigWebView(context, String title, String type) {
  showLoadingContextDialog(context, msg: '${s.text326}');
}

getHeaderBuilder() {
  return CustomHeader(builder: (context, mode) {
    Widget body = Container();
    if (mode == RefreshStatus.idle) {
      body = Text('Loading', style: TextStyle(color: Colours().textGrey));
    } else if (mode == RefreshStatus.refreshing) {
      body = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(child: LoadImage('common_loading', format: 'gif', fit: BoxFit.fill, height: adaptation(30), width: adaptation(30)), padding: EdgeInsets.only(right: adaptation(30))),
          Padding(child: Text('${s.text328}', style: TextStyle(color: Colours().textGrey)), padding: EdgeInsets.only(right: adaptation(80))),
        ],
      );
    } else if (mode == RefreshStatus.failed) {
      body = Text('Failed to load', style: TextStyle(color: Colours().textGrey));
    } else if (mode == RefreshStatus.completed) {
      body = Text('Failed to load', style: TextStyle(color: Colours().textGrey));
    } else if (mode == RefreshStatus.canRefresh) {
      body = Text('Failed to load', style: TextStyle(color: Colours().textGrey));
    }
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight + adaptation(10), bottom: adaptation(20)),
      child: Center(child: body),
    );
  });
}

getClassicFooter() {
  return ClassicFooter(
    canLoadingText: '',
    idleText: '',
    loadingText: '${s.text332}',
    noDataText: '${s.text333}',
    failedText: '${s.text334}',
    loadingIcon: SizedBox(width: adaptation(40), height: adaptation(40), child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colours().themeColor))),
  );
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
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
