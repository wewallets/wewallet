import 'package:mars/wallet/common/component_index.dart';
import 'package:mars/wallet/widgets/loading_shade_custom.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../component_index.dart';

abstract class BaseAliveState<T extends StatefulWidget> extends State with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  T get widget => super.widget;

  @protected
  Widget get appBar;

  Widget floatingActionButton;

  Color backgroundColor = Colours().background;

  bool noScaffold = false;
  @protected
  bool resizeToAvoidBottomInset = true;

  static bool _isLoadingDialog = true;

  @protected
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return noScaffold
        ? buildContent(context)
        : Scaffold(
            appBar: appBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            backgroundColor: backgroundColor,
            floatingActionButton: floatingActionButton,
            body: buildContent(context),
          );
  }

//界面跳转
  navigatorPush(path, {Bundle bundle, transition = TransitionType.cupertino, isPop}) {
    if (isPop == true) pop();
    return PageWalletRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition);
  }

  bool isLogin({isShowLogin = true}) {
    return isLoginContext(context, isShowLogin: isShowLogin);
  }

  //关闭当前界面
  pop() {
    return PageWalletRouter.router.pop(context);
  }

  navigateTo(path, {Bundle bundle, transition = TransitionType.cupertino, bool replace = false, bool clearStack = false}) {
    return PageWalletRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition, replace: replace, clearStack: clearStack);
  }

  //手动调用软键盘弹起
  getRequestFocus(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }

  //手动关闭软键盘
  closeRequestFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

//通用标题
  Widget getAppBar(title, {colors, leading = "break_left", List<Widget> actions, double elevation: 0.0, onPressed, noLeading = false, textColor}) {
    return getContextAppBar(context, title.toString().toUpperCase(), colors: colors, leading: leading, actions: actions, elevation: elevation, onPressed: onPressed, noLeading: noLeading, textColor: textColor);
  }

  //通用图片背景标题
  Widget getImageAppBar(title, {image, leading = "zuobianfanhui", actions, elevation: 0.0, titleStyle, onPressed, noLeading = false, leadingWidth = 44, leadingHeight = 44}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
            decoration: image == null ? BoxDecoration() : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage(getImgPath(image)))),
            child: AppBar(
              brightness: Brightness.dark,
              leading: noLeading
                  ? Container()
                  : CupertinoButton(
                      child: LoadImage(leading, width: adaptation(leadingWidth), height: adaptation(leadingHeight), fit: BoxFit.contain),
                      padding: EdgeInsets.zero,
                      onPressed: onPressed ??
                          () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.pop(context);
                          },
                    ),
              elevation: elevation,
              title: Text(title, style: titleStyle ?? TextStyle(fontSize: ScreenUtil().setSp(36), color: Colours().textTheme1, fontWeight: FontWeight.bold)),
              backgroundColor: Colours().transparent,
              centerTitle: true,
              actions: actions != null
                  ? [
                      Row(children: [actions])
                    ]
                  : [],
            )));
  }

  //等待中的窗口
  showLoadingDialog({msg: 'Please Wait...'}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    _isLoadingDialog = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            child: LoadingShadeCustom(alpha: 0.1, msg: msg, loading: true, child: Container(), textColor: Colours().textTheme1),
            onWillPop: () {
              _isLoadingDialog = false;
              return new Future.value(true);
            },
          );
        });
  }

  closeLoadingDialog() {
    if (_isLoadingDialog) Navigator.pop(context);
  }
}
