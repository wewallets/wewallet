import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/generated/l10n.dart';
import 'package:mars/models/appConfig.dart';
import 'package:mars/widgets/dialog/system_update_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'drawer/user_drawer.dart';
import 'ecology/ecology_page.dart';
import 'home/im_page.dart';
import 'home/new_home_page.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

//首页
class MainNewPage extends StatefulWidget {
  @override
  _MainNewPageState createState() => _MainNewPageState();
}

class _MainNewPageState extends State<MainNewPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  var appBarIcons = [
    ['h_0', 'h_1'],
    ['h_2', 'h_3'],
    ['h_4', 'h_5'],
    // ['h_6', 'h_7'],
    ['h_8', 'h_9']
  ];

  static int _currentIndex = 0;
  var _pageList = new List<StatefulWidget>();
  var _titles = new List<String>();
  TabController _controller;
  PageController _pageController;
  DateTime lastPopTime;

  @override
  void initState() {
    GlobalTransaction.context = context;
    super.initState();
    if (SpUtil.hasKey('isWsOnHttp')) GlobalTransaction.isWsOnHttp = SpUtil.getBool('isWsOnHttp');

    Future.delayed(Duration.zero, () async {
      await initTitle();
    });

    getUpdate();
  }

  initTitle() async {
    if (SpUtil.hasKey('locale')) {
      await S.load(Locale(SpUtil.getString('locale')));
    } else {
      await S.load(Locale('en'));
      SpUtil.putString('locale', 'en');
    }

    _titles.add("${getString().shouye}");
    _titles.add("${getString().shengtai}");
    _titles.add("IM");
    // _titles.add("${getString().faxian}");
    _titles.add("${getString().wode}");

    _pageList.add(NewHomePage());
    _pageList.add(EcologyPage());
    _pageList.add(ImPage());
    // _pageList.add(ImPage());
    _pageList.add(UserDrawer());

    _pageController = PageController();
    _controller = TabController(length: _pageList.length, vsync: this, initialIndex: 0);

    setState(() {});
  }

  getSign() {
    String address = GlobalTransaction.walletInfo.account_id;
    String sign1 = generateMD5(address.substring(2, 6) + address.substring(8, 12));
    String sign2 = generateMD5(sign1.substring(sign1.length - 10, sign1.length - 2));
    return sign2;
  }

  String generateMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    if (_pageController != null) _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
        onWillPop: () async {
          if (lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().zaianyictuichuyingyong}');
            return new Future.value(false);
          }
          lastPopTime = DateTime.now();
          SystemNavigator.pop();
          return true;
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                        color: Color(0xFF100F1A),
                        child: SafeArea(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                            Container(
                                height: ScreenUtil().setWidth(100),
                                decoration: BoxDecoration(color: Color(0xFF100F1A)),
                                padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                                child: TabBar(
                                  controller: _controller,
                                  indicatorColor: Color(0xFF100F1A),
                                  indicatorPadding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.zero,
                                  unselectedLabelColor: Colours.textGrey,
                                  onTap: (i) async {
                                    if (i == 2) {
                                      String lang;
                                      if (SpUtil.getString('locale') == 'zh') {
                                        lang = 'cn';
                                      } else if (SpUtil.getString('locale') == 'en') {
                                        lang = 'en';
                                      } else if (SpUtil.getString('locale') == 'ms') {
                                        lang = 'mys';
                                      } else if (SpUtil.getString('locale') == 'th') {
                                        lang = 'tha';
                                      }

                                      if (Platform.isIOS) {
                                        try {
                                          String url;
                                          if (GlobalTransaction.walletInfo != null)
                                            url = 'riseim://?address=${GlobalTransaction.walletInfo.account_id}&sign=${getSign()}&lang=${lang ?? 'en'}';
                                          else
                                            url = 'riseim://';
                                          // ignore: argument_type_not_assignable_to_error_handler
                                          await launch(url).catchError(() async {
                                            await launch(GlobalTransaction.imUrl);
                                            // ignore: missing_return
                                          }).onError((error, stackTrace) async {
                                            await launch(GlobalTransaction.imUrl);
                                          });
                                        } catch (e) {
                                          await launch(GlobalTransaction.imUrl);
                                        }
                                        return;
                                      }
                                      String url;
                                      if (GlobalTransaction.walletInfo != null)
                                        url = 'riseim://?address=${GlobalTransaction.walletInfo.account_id}&sign=${getSign()}&lang=${lang ?? 'en'}';
                                      else
                                        url = 'riseim://';

                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        await launch(GlobalTransaction.imUrl);
                                      }
                                      return;
                                    } else if (i == 0 ||i==1|| i == 3) {
                                      _pageController.jumpToPage(i);
                                      _currentIndex = i;
                                      if (mounted) setState(() {});
                                    } else if (i != 0) {
                                      showToast('${getString().jqqd}');
                                      return;
                                    }
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
                                    Tab(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(alignment: Alignment.center, width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), child: LoadAssetImage(getTabIcon(3), height: getSize(3), width: getSize(3))),
                                          Gaps.vGap4,
                                          Text(_titles[3], style: TextStyle(color: getColor(3), fontSize: ScreenUtil().setSp(18))),
                                        ],
                                      ),
                                    ),
                                    // Tab(
                                    //   child: Column(
                                    //     mainAxisAlignment: MainAxisAlignment.center,
                                    //     children: <Widget>[
                                    //       Container(alignment: Alignment.center, width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), child: LoadAssetImage(getTabIcon(4), height: getSize(4), width: getSize(4))),
                                    //       Gaps.vGap4,
                                    //       Text(_titles[4], style: TextStyle(color: getColor(4), fontSize: ScreenUtil().setSp(18))),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ))
                          ],
                        ))),
                  )));
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

    Net().post(ApiTransaction.GET_VALUE, {'key': 'imurl'}, success: (data) async {
      SpUtil.putString('imUrl', data['value']);
    });

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
