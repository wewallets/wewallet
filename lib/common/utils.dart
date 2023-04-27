import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../widgets/loading_shade_custom.dart';
import 'transaction_component_index.dart';

//适配
double adaptation(double px) {
  return ScreenUtil().setWidth(px);
}

//适配DP
double dp(double dp) {
  return ScreenUtil().setWidth(dp * 2);
}

//适配DP
double adaptationDp(double dp) {
  return ScreenUtil().setWidth(dp * 2);
}

//适配文字
double adaptationSp(double sp) {
  return ScreenUtil().setSp(sp);
}

//适配文字DP
double adaptationDpSp(double dp) {
  return ScreenUtil().setSp(dp * 2);
}

inkButton({child, onPressed, double minSize, padding}) {
  return CupertinoButton(
    minSize: minSize ?? 0,
    padding: padding ?? EdgeInsets.zero,
    child: child,
    onPressed: onPressed,
  );
}

//界面跳转
navigatorTransactionContextPush(context, path, {Bundle bundle, transition = TransitionType.cupertino, isPop, onValue}) {
  if (isPop == true) PageTransactionRouter.router.pop(context);
  return PageTransactionRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition).then(onValue);
}

navigateToContext(context, path, {Bundle bundle, transition = TransitionType.cupertino, bool replace = false, bool clearStack = false}) {
  return PageTransactionRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition, replace: replace, clearStack: clearStack);
}

//获取通用listView
Widget listViewBuilder({@required IndexedWidgetBuilder itemBuilder, padding, isSlide = false, itemCount}) {
  return ListView.builder(
    padding: padding ?? EdgeInsets.zero,
    itemBuilder: itemBuilder,
    shrinkWrap: isSlide,
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

Map<String, dynamic> keySort(Map<String, dynamic> oldParamsMap) {
  Map<String, dynamic> newParamsMap = Map();
  List<String> oldKeys = oldParamsMap.keys.toList();
  if (oldKeys.isEmpty) return newParamsMap;
  oldKeys.sort((a, b) {
    List<int> al = a.codeUnits;
    List<int> bl = b.codeUnits;
    for (int i = 0; i < al.length; i++) {
      if (bl.length <= i) return 1;
      if (al[i] > bl[i]) {
        return 1;
      } else if (al[i] < bl[i]) return -1;
    }
    return 0;
  });
  for (int i = 0; i < oldKeys.length; i++) {
    newParamsMap[oldKeys[i]] = oldParamsMap[oldKeys[i]];
  }
  return newParamsMap;
}

//关闭当前界面
contextPop(context) {
  PageTransactionRouter.router.pop(context);
}

Widget getContextAppBar(context, title, {colors, leading = "break_black", List<Widget> actions, double elevation: 0.0, onPressed, noLeading = false, textColor, leftWidth, leftHeight}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight - adaptation(10)),
      child: AppBar(
        leading: noLeading
            ? Container()
            : CupertinoButton(
                child: LoadAssetImage(leading, width: leftWidth ?? adaptation(40), height: leftHeight ?? adaptation(40), fit: BoxFit.contain, color: textColor ?? null),
                padding: EdgeInsets.zero,
                onPressed: onPressed ??
                    () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pop(context);
                    },
              ),
        elevation: elevation,
        title: Text(title, style: TextStyle(fontSize: adaptationSp(37), color: textColor ?? Colours.textBlack, fontWeight: FontWeight.w500)),
        backgroundColor: colors ?? Colours.white,
        centerTitle: true,
        actions: actions ?? [],
      ));
}

//普通提示
showToast(msg, {Toast toastLength, int timeInSecForIos = 1, double fontSize = 16.0, ToastGravity gravity = ToastGravity.CENTER, Color backgroundColor, Color textColor}) {
  Fluttertoast.showToast(msg: msg, toastLength: toastLength, fontSize: fontSize, gravity: gravity, backgroundColor: backgroundColor, textColor: textColor);
}

buildErrorWidget({String errorImage = 'zhanwushuju', String errorText, double topHeight = 0, double imageWidth = 220}) {
  return Container(
    width: ScreenUtil().screenWidth,
    margin: EdgeInsets.only(top: ScreenUtil().setWidth(topHeight)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadImage(
          errorImage,
          width: ScreenUtil().setWidth(imageWidth),
        ),
        Gaps.vGap10,
        Text(errorText ?? '${getString().zwsj}', style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xFFC8CFDB)))
      ],
    ),
  );
}

buildLoadingShadeCustom({text = '正在加载数据...', top = 0.0}) {
  return Padding(padding: EdgeInsets.only(top: adaptation(top)), child: LoadingShadeCustom(alpha: 0.1, msg: text, loading: true, child: Container(), textColor: Colours.textBlack));
}

bool _isLoadingDialog = true;
//等待中的窗口
showLoadingContextDialog(context, {msg: '请稍等...'}) async {
  FocusScope.of(context).requestFocus(FocusNode());
  _isLoadingDialog = true;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          child: LoadingShadeCustom(alpha: 0.1, msg: msg, loading: true, child: Container(), textColor: Colours.textBlack),
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
