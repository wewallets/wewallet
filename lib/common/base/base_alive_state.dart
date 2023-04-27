import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/loading_shade_custom.dart';
import '../transaction_component_index.dart';

abstract class BaseAliveState<T extends StatefulWidget> extends State with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  T get widget => super.widget;

  @protected
  Widget get appBar;

  Widget floatingActionButton;

  Color backgroundColor = Color(0xFF08070F);

  bool noScaffold = false;

  bool isResizeToAvoidBottomPadding = true;
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
            backgroundColor: backgroundColor,
            floatingActionButton: floatingActionButton,
            body: buildContent(context),
          );
  }

//界面跳转
  navigatorPush(path, {Bundle bundle, transition = TransitionType.cupertino, isPop}) {
    if (isPop == true) pop();
    return PageTransactionRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition);
  }

  bool isLogin({isShowLogin = false}) {
    if (GlobalTransaction.isLogin) {
      return true;
    } else if (isShowLogin) {
      showToast('please log in first');
      navigateToContext(context, PageTransactionRouter.login_Page);
      return false;
    } else {
      return false;
    }
  }

  //关闭当前界面
  pop() {
    return PageTransactionRouter.router.pop(context);
  }

  navigateTo(path, {Bundle bundle, transition = TransitionType.cupertino, bool replace = false, bool clearStack = false}) {
    return PageTransactionRouter.router.navigateTo(context, path, routeSettings: RouteSettings(arguments: bundle), transition: transition, replace: replace, clearStack: clearStack);
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
  Widget getAppBar(title, {leading = "digital_left", List<Widget> actions, double elevation: 0.0, onPressed, noLeading = false, textColor = Colours.white}) {
    return getContextAppBar(context, title.toString().toUpperCase(), colors: Color(0xFF08070F), leading: leading, actions: actions, elevation: elevation, onPressed: onPressed, noLeading: noLeading, textColor: textColor);
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
            child: LoadingShadeCustom(alpha: 0.1, msg: msg, loading: true, child: Container(), textColor: Colours.textBlack),
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
