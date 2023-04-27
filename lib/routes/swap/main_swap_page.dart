import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/routes/swap/pledge_swap_page.dart';

import 'assets_swap_page.dart';
import 'flow_swap_page.dart';
import 'home_swap_page.dart';
import 'ledger_swap_page.dart';

//首页
class MainSwapPage extends StatefulWidget {
  @override
  _MainSwapPageState createState() => _MainSwapPageState();
}

class _MainSwapPageState extends State<MainSwapPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  AnimationController size1Controller;
  AnimationController size2Controller;
  AnimationController size3Controller;
  AnimationController size4Controller;

  var appBarIcons = [
    ['swap_tab_0', 'swap_tab_1'],
    ['swap_tab_2', 'swap_tab_3'],
    ['swap_tab_6', 'swap_tab_7'],
    ['swap_tab_4', 'swap_tab_5'],
  ];

  static int _currentIndex = 0;
  var _pageList = [];
  var _titles = [];
  TabController _controller;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    size1Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.2);
    size2Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.2);
    size3Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.2);
    size4Controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this, lowerBound: 1.0, upperBound: 1.2);

    Future.delayed(Duration.zero, () async {
      await initTitle();
    });
  }

  initTitle() async {
    _titles.add('${s.shouye}');
    _titles.add('${s.text34}');
    _titles.add('${s.text94}');
    _titles.add('${s.zc}');
    _pageList.add(HomeSwapPage());
    _pageList.add(FlowSwapPage());
    _pageList.add(PledgeSwapPage());
    _pageList.add(AssetsSwapPage());

    _controller = TabController(length: _pageList.length, vsync: this);
    _pageController = PageController();
    setState(() {});
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    if (_pageController != null) _pageController.dispose();

    size1Controller.dispose();
    size2Controller.dispose();
    size3Controller.dispose();
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
                bottomNavigationBar: Container(
                    color: Color(0xFFFFFFFF),
                    child: SafeArea(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(color: Colours.colorEE, height: ScreenUtil().setWidth(2)),
                        Container(
                            height: ScreenUtil().setWidth(100),
                            decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                            padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                            child: TabBar(
                              controller: _controller,
                              indicatorColor: Color(0xFFFFFFFF),
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              unselectedLabelColor: Colours.textGrey,
                              onTap: (i) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                _pageController.jumpToPage(i);
                                _currentIndex = i;

                                switch (_currentIndex) {
                                  case 0:
                                    size1Controller.forward();
                                    size2Controller.reverse();
                                    size3Controller.reverse();
                                    size4Controller.reverse();
                                    break;
                                  case 1:
                                    size2Controller.forward();
                                    size1Controller.reverse();
                                    size3Controller.reverse();
                                    size4Controller.reverse();
                                    break;
                                  case 2:
                                    size3Controller.forward();
                                    size1Controller.reverse();
                                    size2Controller.reverse();
                                    size4Controller.reverse();
                                    break;
                                  case 3:
                                    size4Controller.forward();
                                    size1Controller.reverse();
                                    size2Controller.reverse();
                                    size3Controller.reverse();
                                    break;
                                }
                                if (mounted) setState(() {});
                              },
                              tabs: <Widget>[
                                Tab(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ScaleTransition(alignment: Alignment.topCenter, scale: size1Controller, child: LoadAssetImage(getTabIcon(0), height: getSize(0), width: getSize(0), fit: BoxFit.contain)),
                                      Gaps.vGap4,
                                      Text(_titles[0], style: TextStyle(color: getColor(0), fontSize: ScreenUtil().setSp(18))),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ScaleTransition(alignment: Alignment.topCenter, scale: size2Controller, child: LoadAssetImage(getTabIcon(1), height: getSize(1), width: getSize(1), fit: BoxFit.contain)),
                                      Gaps.vGap4,
                                      Text(_titles[1], style: TextStyle(color: getColor(1), fontSize: ScreenUtil().setSp(18))),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ScaleTransition(alignment: Alignment.topCenter, scale: size3Controller, child: LoadAssetImage(getTabIcon(2), height: getSize(2), width: getSize(2), fit: BoxFit.contain)),
                                      Gaps.vGap4,
                                      Text(_titles[2], style: TextStyle(color: getColor(2), fontSize: ScreenUtil().setSp(18))),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ScaleTransition(alignment: Alignment.topCenter, scale: size4Controller, child: LoadAssetImage(getTabIcon(3), height: getSize(3), width: getSize(3), fit: BoxFit.contain)),
                                      Gaps.vGap4,
                                      Text(_titles[3], style: TextStyle(color: getColor(3), fontSize: ScreenUtil().setSp(18))),
                                    ],
                                  ),
                                ),
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
    return ScreenUtil().setWidth(44);
  }

  Color getColor(int curIndex) {
    if (curIndex == _controller.index) {
      return Color(0xFFE74561);
    }
    return Color(0xFFCACACA);
  }
}
