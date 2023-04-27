import 'package:flutter/services.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:mars/wallet/common/notify_event.dart';
import 'package:mars/wallet/routes/home/home_page.dart';
import 'package:mars/wallet/routes/home/my_page.dart';

import '../../common/global.dart';
import 'home/dapp_page.dart';

//首页
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage> with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController size1Controller;
  AnimationController size2Controller;
  AnimationController size3Controller;
  AnimationController size4Controller;
  AnimationController size5Controller;

  @override
  bool get noScaffold => true;

  // var appBarIcons = [
  //   [Images.main_icon1, Images.main_icon2],
  //   [Images.main_icon3, Images.main_icon4],
  //   [Images.main_icon5, Images.main_icon6],
  //   [Images.main_icon7, Images.main_icon8],
  //   [Images.main_icon9, Images.main_icon10],
  // ];

  var appBarIcons = [
    [Images.main_icon1, Images.main_icon2],
    [Images.main_icon3, Images.main_icon4],
    [Images.main_icon5, Images.main_icon6],
  ];

  static int _currentIndex = 0;
  var _pageList = [];
  var _titles = [];
  TabController _controller;
  PageController _pageController;
  DateTime lastPopTime;

  @override
  void initState() {
    Global.getContext = context;
    GlobalTransaction.context = context;
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    size1Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.1);
    size2Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.1);
    size3Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.1);
    size4Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.1);
    size5Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.1);

    Future.delayed(Duration.zero, () async {
      await initTitle();
    });

    getUpdate();

    eventBus.on<SwitchTabPageEvent>().listen((event) {
      if (event.pageIndex > -1) {
        if (mounted) {
          setState(() {
            _controller.index = event.pageIndex;
            _pageController.jumpToPage(event.pageIndex);
          });
        }
      }
    });

    // Future.delayed(Duration(milliseconds: 200), () async {
    //   if (_pageController != null) {
    //     _controller.index = 0;
    //     _pageController.jumpToPage(0);
    //   }
    // });
  }

  initTitle() async {
    _titles.add('钱包');
    _titles.add('DAPP');
    _titles.add('我的');

    _pageList.add(HomePage());
    _pageList.add(DAPPPage());
    _pageList.add(MyPage());

    _controller = TabController(length: _pageList.length, vsync: this, initialIndex: 0);
    _pageController = PageController();
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_controller != null) _controller.dispose();
    if (_pageController != null) _pageController.dispose();
    size1Controller.dispose();
    size2Controller.dispose();
    size3Controller.dispose();
    size4Controller.dispose();
    super.dispose();
  }

  @override
  Widget get appBar => null;

  @override
  Widget buildContent(BuildContext context) {
    return _titles.length == 0
        ? Container()
        : WillPopScope(
            onWillPop: () async {
              if (lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
                lastPopTime = DateTime.now();
                Fluttertoast.showToast(msg: '${s.text305}');
                return new Future.value(false);
              }
              lastPopTime = DateTime.now();
              SystemNavigator.pop();
              return true;
            },
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Scaffold(
                  body: PageView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return _pageList[index];
                    },
                    controller: _pageController,
                    itemCount: _pageList.length,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  bottomNavigationBar: Container(
                      color: Colours().textTheme2,
                      child: SafeArea(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              height: adaptation(110),
                              child: TabBar(
                                controller: _controller,
                                indicatorColor: Colours().textTheme2,
                                indicatorPadding: EdgeInsets.zero,
                                labelPadding: EdgeInsets.zero,
                                unselectedLabelColor: Colours().textGrey,
                                onTap: (i) {
                                  if (i == 2) {
                                    if (!isLogin()) {
                                      _controller.index = _currentIndex;
                                      return;
                                    }
                                  }
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  _pageController.jumpToPage(i);

                                  _currentIndex = i;

                                  switch (_currentIndex) {
                                    case 0:
                                      size1Controller.forward();
                                      size2Controller.reverse();
                                      size3Controller.reverse();
                                      size4Controller.reverse();
                                      size5Controller.reverse();
                                      break;
                                    case 1:
                                      size2Controller.forward();
                                      size1Controller.reverse();
                                      size3Controller.reverse();
                                      size4Controller.reverse();
                                      size5Controller.reverse();
                                      break;
                                    case 2:
                                      size3Controller.forward();
                                      size1Controller.reverse();
                                      size2Controller.reverse();
                                      size4Controller.reverse();
                                      size5Controller.reverse();
                                      break;
                                    case 3:
                                      size4Controller.forward();
                                      size1Controller.reverse();
                                      size2Controller.reverse();
                                      size3Controller.reverse();
                                      size5Controller.reverse();
                                      break;
                                    case 4:
                                      size5Controller.forward();
                                      size1Controller.reverse();
                                      size2Controller.reverse();
                                      size3Controller.reverse();
                                      size4Controller.reverse();
                                      break;
                                  }
                                  if (mounted) setState(() {});
                                },
                                tabs: <Widget>[
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        ScaleTransition(alignment: Alignment.topCenter, scale: size1Controller, child: LoadAssetImage(getTabIcon(0), height: getSize(0), width: getSize(0), fit: BoxFit.contain)),
                                        Gaps.vGap5,
                                        Text(_titles[0], style: TextStyle(color: getColor(0), fontSize: ScreenUtil().setSp(18))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        ScaleTransition(alignment: Alignment.topCenter, scale: size2Controller, child: LoadAssetImage(getTabIcon(1), height: getSize(1), width: getSize(1), fit: BoxFit.contain)),
                                        Gaps.vGap5,
                                        Text(_titles[1], style: TextStyle(color: getColor(1), fontSize: ScreenUtil().setSp(18))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        ScaleTransition(alignment: Alignment.topCenter, scale: size3Controller, child: LoadAssetImage(getTabIcon(2), height: getSize(2), width: getSize(2), fit: BoxFit.contain)),
                                        Gaps.vGap5,
                                        Text(_titles[2], style: TextStyle(color: getColor(2), fontSize: ScreenUtil().setSp(18))),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   child: Column(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: <Widget>[
                                  //       ScaleTransition(alignment: Alignment.topCenter, scale: size4Controller, child: LoadAssetImage(getTabIcon(3), height: getSize(3), width: getSize(3), fit: BoxFit.contain)),
                                  //       Gaps.vGap5,
                                  //       Text(_titles[3], style: TextStyle(color: getColor(3), fontSize: ScreenUtil().setSp(18))),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Container(
                                  //   child: Column(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: <Widget>[
                                  //       ScaleTransition(alignment: Alignment.topCenter, scale: size4Controller, child: LoadAssetImage(getTabIcon(4), height: getSize(4), width: getSize(4), fit: BoxFit.contain)),
                                  //       Gaps.vGap5,
                                  //       Text(_titles[4], style: TextStyle(color: getColor(4), fontSize: ScreenUtil().setSp(18))),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ))
                        ],
                      ))),
                )),
          );
  }

  String getTabIcon(int curIndex) {
    if (curIndex == _controller.index) {
      return appBarIcons[curIndex][1];
    }
    return appBarIcons[curIndex][0];
  }

  double getSize(int curIndex) {
    return adaptation(44);
  }

  Color getColor(int curIndex) {
    if (curIndex == _controller.index) {
      return Colours().themeColor;
    }
    return Colours().textGrey;
  }

  getUpdate() async {
    // if (!Global.isManualRelease) return;
    // Net().post(Api.GET_APP_CONFIG, null, success: (data) async {
    //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //   var appConfig = GetAppConfigEntity().fromJson(data);
    //   if (Platform.isAndroid) {
    //     if (appConfig.versionNo != null && double.parse(appConfig.versionNo) > double.parse(packageInfo.buildNumber)) {
    //       showDialog(
    //           context: context,
    //           builder: (builder) {
    //             return SystemUpdateDialog(appConfig);
    //           });
    //     }
    //   } else {
    //     // if (appConfig.versionNo != null && double.parse(appConfig.versionNo) > double.parse(packageInfo.buildNumber)) {
    //     //   await launchUrl(Uri.parse('${appConfig.iosAddr}'));
    //     // }
    //   }
    // });
  }
}
