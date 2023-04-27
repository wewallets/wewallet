import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/socket/ripple_web_socket.dart';

//登录
class LoginPage extends StatefulWidget {
  @override
  _LoginNewPageState createState() => _LoginNewPageState();
}

class _LoginNewPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController submitAnimationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1700));
    submitAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    Future.delayed(Duration(milliseconds: 150), () => animationController.forward());

    RippleWebSocket().connect();
  }

  @override
  void dispose() {
    animationController.dispose();
    submitAnimationController.dispose();
    super.dispose();
  }

  Future<bool> _requestPop() {
    if (GlobalTransaction.isRelease)
      SystemNavigator.pop();
    else
      Navigator.pop(context);
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: SlideTransition(
                        position: Tween(begin: Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(
                          parent: animationController,
                          curve: Interval(0.0, 0.4, curve: Curves.ease),
                        )),
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: ScreenUtil().setWidth(280)),
                          child: LoadAssetImage(Images.ic_launcher, width: ScreenUtil().setWidth(200)),
                        ),
                      ),
                    ),
                    _buildLoginBody(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          child: IconButton(
                            icon: LoadAssetImage("break_black", height: ScreenUtil().setWidth(44)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), top: ScreenUtil().statusBarHeight + ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(30))),
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget _buildSubmit() {
    var submitWidth = CurvedAnimation(parent: submitAnimationController, curve: Interval(0.0, 0.5, curve: Curves.ease));
    return new AnimatedBuilder(
      animation: submitAnimationController,
      builder: (ctx, w) {
        return Container(
          margin: EdgeInsets.only(top: adaptationDp(25)),
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(88),
                width: double.infinity,
                child: inkButton(
                    child: Text('${getString().cjqbdiz}', style: TextStyle(color: Colours.white, fontSize: Tween<double>(begin: ScreenUtil().setWidth(32), end: 0.0).animate(submitWidth).value)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, PageTransactionRouter.create_wallet_page);
                    }),
              ),
              Gaps.vGap25,
              Container(
                height: ScreenUtil().setWidth(88),
                width: double.infinity,
                child: inkButton(
                    child: Text('${getString().daoruqb}', style: TextStyle(color: Colours.white, fontSize: Tween<double>(begin: ScreenUtil().setWidth(32), end: 0.0).animate(submitWidth).value)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, PageTransactionRouter.import_wallet_page);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginBody() {
    var cardCurve = CurvedAnimation(parent: animationController, curve: Interval(0, 0.4, curve: Curves.ease));
    var accountCurve = CurvedAnimation(parent: animationController, curve: Interval(0.3, 0.5, curve: Curves.ease));
    var submitCurve = CurvedAnimation(parent: animationController, curve: Interval(0.5, 0.7, curve: Curves.ease));
    return Container(
      child: Center(
        child: SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(cardCurve),
          child: Container(
              height: ScreenUtil().screenHeight / 2,
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60), top: ScreenUtil().setWidth(250)),
              child: Column(children: <Widget>[
                SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(accountCurve),
                  child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(accountCurve),
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, PageTransactionRouter.webview_page, arguments: Bundle()..putString('titleName', '${getString().ysxy}')..putString('url', '${ApiTransaction.BASE_URL}explorer/protocol.html'));
                            },
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${getString().daorjsty}', style: TextStyles.textGrey13.copyWith(color: Colours.colorFF97A2AF)),
                                  Text('${getString().ysxy}', style: TextStyles.textGrey13.copyWith(color: Colours.colorFFD94F57)),
                                ],
                              ),
                            )),
                      )),
                ),
                SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(submitCurve),
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(submitCurve),
                      child: _buildSubmit(),
                    )),
              ])),
        ),
      ),
    );
  }

  login() async {}
}
