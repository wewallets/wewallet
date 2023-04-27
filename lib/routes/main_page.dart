import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/event_bus.dart';
import 'package:mars/models/appConfig.dart';
import 'package:mars/routes/home/assets_page.dart';
import 'package:mars/routes/home/home_page.dart';
import 'package:mars/routes/home/my_page.dart';
import 'package:mars/routes/home/quotation_page.dart';
import 'package:mars/routes/home/transaction_page.dart';
import 'package:mars/widgets/dialog/system_update_dialog.dart';
import 'package:package_info/package_info.dart';

import 'orepool/ore_pool_page.dart';

//首页
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin, WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;

  var appBarIcons = [
    // [Images.home_tab_0, Images.home_tab_1],
    [Images.home_tab_2, Images.home_tab_3],
    [Images.home_tab_4, Images.home_tab_5],
    [Images.home_tab_6, Images.home_tab_7],
  ];

  static int _currentIndex = 1;
  var _pageList = new List<StatefulWidget>();
  var _titles = new List<String>();
  TabController _controller;
  PageController _pageController;
  DateTime lastPopTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      initTitle();
    });

    // getUpdate();
    EventBus().on('main_switch', ({arg}) {
      if (arg['mainType'] == 'transaction') {
        _pageController.jumpToPage(1);
        _currentIndex = 1;
        _controller.index = _currentIndex;
        Future.delayed(Duration(milliseconds: 200), () {
          EventBus().send('switch_transaction', {'type': arg['type'], 'market1': arg['market1'], 'market2': arg['market2']});
        });
        if (mounted) setState(() {});
      }
    });
  }

  initTitle() async {
    // _titles.add("${getString().shouye}");
    _titles.add("${getString().hangq}");
    _titles.add("${getString().jiaoyi}");
    _titles.add("${getString().zhic}");
    // _pageList.add(HomePage());
    _pageList.add(QuotationPage());
    _pageList.add(TransactionPage());
    _pageList.add(AssetsPage());

    _controller = TabController(length: _pageList.length, vsync: this);
    _pageController = PageController();
    setState(() {});
    Future.delayed(Duration(milliseconds: 100), () {
      _pageController.jumpToPage(_currentIndex);
      _currentIndex = _currentIndex;
      _controller.index = _currentIndex;
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      try {
        if (_currentIndex == 0) {
          EventBus().send("refreshQuotation");
        } else if (_currentIndex == 1) {
          EventBus().send("refreshTransaction");
        } else if (_currentIndex == 2) {
          EventBus().send("refreshAssets");
        }
      } catch (e) {}
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_controller != null) _controller.dispose();
    if (_pageController != null) _pageController.dispose();
    EventBus().off('main_switch');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: _titles.length == 0
            ? Container()
            : Scaffold(
                body: PageView.builder(
                  itemBuilder: (BuildContext context, int index) => _pageList[index],
                  controller: _pageController,
                  itemCount: _pageList.length,
                  physics: NeverScrollableScrollPhysics(),
                ),
                //   TabBarView(
                //   physics: NeverScrollableScrollPhysics(),
                //   controller: _controller,
                //   onPageChanged: (int index) {
                //     Provide.value<CurrentIndexProvide>(context)
                //         .changeIndex(index);
                //   },
                //   children: <Widget>[_pageList[0], _pageList[1], _pageList[2], _pageList[3], _pageList[4]],
                // ),
                bottomNavigationBar: Container(
                    color: Colours.white,
                    child: SafeArea(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                        Container(
                            height: ScreenUtil().setWidth(100),
                            decoration: BoxDecoration(color: Colours.white),
                            padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                            child: TabBar(
                              controller: _controller,
                              indicatorColor: Colours.white,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              unselectedLabelColor: Colours.textGrey,
                              onTap: (i) {
                                // if (i == 2) {
                                //   showToast('${getString().jqqd}');
                                //   return;
                                // }
                                FocusScope.of(context).requestFocus(FocusNode());
                                _pageController.jumpToPage(i);
                                _currentIndex = i;

                                try {
                                  if (_currentIndex == 0) {
                                    EventBus().send("refreshQuotation");
                                  } else if (_currentIndex == 1) {
                                    EventBus().send("refreshTransaction");
                                  } else if (_currentIndex == 2) {
                                    EventBus().send("refreshAssets");
                                  }
                                } catch (e) {}
                                if (mounted) setState(() {});
                              },
                              tabs: <Widget>[
                                Tab(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(alignment: Alignment.center, width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), child: LoadAssetImage(getTabIcon(0), height: getSize(0), width: getSize(0), fit: BoxFit.contain)),
                                      Gaps.vGap4,
                                      Text(_titles[0], style: TextStyle(color: getColor(0), fontSize: ScreenUtil().setSp(18))),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(alignment: Alignment.center, width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), child: LoadAssetImage(getTabIcon(1), height: getSize(1), width: getSize(1), fit: BoxFit.contain)),
                                      Gaps.vGap4,
                                      Text(_titles[1], style: TextStyle(color: getColor(1), fontSize: ScreenUtil().setSp(18))),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(alignment: Alignment.center, width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), child: LoadAssetImage(getTabIcon(2), height: getSize(2), width: getSize(2), fit: BoxFit.contain)),
                                      Gaps.vGap4,
                                      Text(_titles[2], style: TextStyle(color: getColor(2), fontSize: ScreenUtil().setSp(18))),
                                    ],
                                  ),
                                ),
                                // Tab(
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: <Widget>[
                                //       Container(alignment: Alignment.center, width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), child: LoadAssetImage(getTabIcon(3), height: getSize(3), width: getSize(3))),
                                //       Gaps.vGap4,
                                //       Text(_titles[3], style: TextStyle(color: getColor(3), fontSize: ScreenUtil().setSp(18))),
                                //     ],
                                //   ),
                                // ),
                                // Tab(
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: <Widget>[
                                //       Container(alignment: Alignment.center, width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), child: LoadAssetImage(getTabIcon(4), height: getSize(4), width: getSize(4))),
                                //       Gaps.vGap4,
                                //       Text(_titles[4], style: TextStyle(color: getColor(4), fontSize: ScreenUtil().setSp(20))),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ))
                      ],
                    ))),
              ));
  }

  String getTabIcon(int curIndex) {
    if (curIndex == _controller.index) {
      return appBarIcons[curIndex][1];
    }
    return appBarIcons[curIndex][0];
  }

  double getSize(int curIndex) {
    if (curIndex == _controller.index) {
      return ScreenUtil().setWidth(44);
    }
    return ScreenUtil().setWidth(40);
  }

  Color getColor(int curIndex) {
    if (curIndex == _controller.index) {
      return Colours.colorFFC939F3;
    }
    return Colours.colorFFBBBBBB;
  }

  getUpdate() async {
    Net().post(ApiTransaction.GET_APP_CONFIG, null, success: (data) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var appConfig = AppConfig.fromJson(data);
      if (Platform.isAndroid) {
        if (appConfig.version_no != null && double.parse(appConfig.version_no) > double.parse(packageInfo.buildNumber)) {
          showDialog(
              context: context,
              builder: (builder) {
                return SystemUpdateDialog(appConfig);
              });
        }
      } else {
        if (appConfig.ios_version_no != null && double.parse(appConfig.ios_version_no) > double.parse(packageInfo.buildNumber)) {
          // showDialog(
          //     context: context,
          //     builder: (builder) {
          //       return VersionUpdateDialog(appConfig.forced_update, appConfig.ios_version, appConfig.tiltle, appConfig.content, appConfig.android_addr, appConfig.ios_addr);
          //     });
        }
      }
    });
  }
}
