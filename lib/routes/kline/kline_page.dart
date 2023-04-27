import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/http/api.dart';
import 'package:mars/common/http/net.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/models/btc_bean.dart';
import 'package:mars/models/cy_intro_bean.dart';
import 'package:mars/models/cy_translog_bean.dart';
import 'package:mars/models/market_detail_bean.dart';
import 'package:mars/routes/drawer/currency_drawer.dart';
import 'package:mars/socket/kline_web_socket.dart';
import 'package:mars/widgets/kline/chart_style.dart';
import 'package:mars/widgets/kline/depth_chart.dart';
import 'package:mars/widgets/kline/entity/depth_entity.dart';
import 'package:mars/widgets/kline/entity/k_line_entity.dart';
import 'package:mars/widgets/kline/k_chart_widget.dart';
import 'package:mars/widgets/kline/utils/data_util.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:mars/widgets/title_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KLinePage extends StatefulWidget {
  final Bundle bundle;

  KLinePage(this.bundle);

  @override
  _KLinePageState createState() => _KLinePageState();
}

class _KLinePageState extends State<KLinePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController typeController;
  List<String> typeList = ['深度', '成交', '简介'];
  List<KLineEntity> datas = [];
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = false;
  bool isChinese = true;
  List<DepthEntity> _bids = [], _asks = [];
  List<DepthEntity> cyDepthSells = []; // 卖单
  List<DepthEntity> cyDepthBys = []; // 买单
  MarketDetailBean marketDetailBean;
  String selectType = '';
  CyIntroData cyIntroData;
  List<CyTransLogData> transList = [];
  String market1 = 'DSP';
  String market2 = 'USDT';
  double gearWidth = 0.0; //单条档位百分比宽度
  int popup = 0; //0:全隐藏 1:更多 2:指标
  String period = '15'; //1:1分或分时 5:5分 15:15分 60:1小时 240:4小时 1440:日线 10080:周线

  @override
  void initState() {
    super.initState();
    typeList = [getString().sdd, getString().cjj, getString().jjj];
    if (widget.bundle != null) {
      market1 = widget.bundle.getString('market1');
      market2 = widget.bundle.getString('market2');
    }
    gearWidth = ScreenUtil().screenWidth / 2 / 100;
    selectType = typeList[0];
    typeController = TabController(length: typeList.length, vsync: this);
    EventBus().on('kLineSwitchCurrency', ({arg}) {
      BTCBean btcBean = arg;
      if (market1 != btcBean.tradName || market2 != btcBean.baseName) {
        market1 = btcBean.tradName;
        market2 = btcBean.baseName;
        getData();
        if (!GlobalTransaction.isWsOnHttp)
          setState(() {
            showLoading = true;
          });
      }
    });
    getIntroData();
    getData();
    timeNews();
  }

  getData() {
    marketDetailBean = null;
    cyIntroData = null;
    transList.clear();
    getMarketDetail();
    getDepthData();
    getCyTransLog();
    getKLineData();
  }

  @override
  void dispose() {
    typeController.dispose();
    newsTimer.cancel();
    KlineWebSocket.off();
    newsTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: Color(0xFF141F31),
          key: _scaffoldKey,
          appBar: TitleBar(
            leftBackWhite: true,
            leftText: '$market1/$market2',
            leftIconShow: true,
            leftCallbackState: true,
            showMenu: true,
            mHeight: kToolbarHeight + ScreenUtil().statusBarHeight,
            menuCallBack: () {
              _scaffoldKey.currentState.openDrawer();
            },
            leftCallback: () {
              Navigator.of(context).pop();
            },
            rightShow: false,
            rightIc: Padding(
              child: LoadImage('icon_full_screen', width: ScreenUtil().setWidth(34), height: ScreenUtil().setWidth(34)),
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
            ),
          ),
          drawer: Drawer(
            child: CurrencyDrawer(
              intoPage: 1,
            ),
          ),
          body: Stack(
            children: [
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(140)),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      // SliverToBoxAdapter(
                      //   child: Column(
                      //     children: [
                      //       Text('http://go6789.kline87.com/',style: TextStyles.textWhite12),
                      //       Container(
                      //         child: InAppWebView(initialUrl: 'http://go6789.kline87.com/'),
                      //         height: adaptationDp(50),
                      //         width: double.infinity,
                      //       ),
                      //       Text('https://kline.kline87.com/',style: TextStyles.textWhite12),
                      //       Container(
                      //         child: InAppWebView(initialUrl: 'https://kline.kline87.com/'),
                      //         height: adaptationDp(50),
                      //         width: double.infinity,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SliverToBoxAdapter(
                        child: _buildHead(),
                      ),
                      SliverToBoxAdapter(
                        child: Container(color: Color(0xFF0A1626), width: double.infinity, height: ScreenUtil().setWidth(20)),
                      ),
                      marketDetailBean == null || marketDetailBean.is_other == '1'
                          ? SliverToBoxAdapter(
                              child: Container(),
                            )
                          : SliverPersistentHeader(
                              pinned: true,
                              delegate: SliverCustomCommonHeaderDelegate(
                                  expandedHeight: ScreenUtil().setWidth(90),
                                  collapsedHeight: ScreenUtil().setWidth(90),
                                  paddingTop: 0,
                                  widget: (double shrinkOffset, bool overlapsContent) {
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              width: double.infinity,
                                              alignment: Alignment.bottomCenter,
                                              height: ScreenUtil().setWidth(88),
                                              child: TabBar(
                                                controller: typeController,
                                                isScrollable: false,
                                                indicatorColor: Color(0xFF0055FF),
                                                unselectedLabelColor: Colors.transparent,
                                                indicatorSize: TabBarIndicatorSize.label,
                                                onTap: (index) {
                                                  selectType = typeList[index];
                                                  if (mounted) setState(() {});
                                                },
                                                tabs: _buildTypes(),
                                              )),
                                          Container(color: Color(0xFF283547), width: double.infinity, height: ScreenUtil().setWidth(2))
                                        ],
                                      ),
                                      color: Color(0xFF141F31),
                                    );
                                  })),
                      marketDetailBean == null || marketDetailBean.is_other == '1'
                          ? SliverToBoxAdapter(
                              child: Container(),
                            )
                          : SliverToBoxAdapter(
                              child: Stack(
                                children: [
                                  Offstage(
                                    child: _buildDepth(),
                                    offstage: !selectType.startsWith('${getString().sdd}'),
                                  ),
                                  Offstage(
                                    child: _buildDeal(),
                                    offstage: !selectType.startsWith('${getString().cjj}'),
                                  ),
                                  Offstage(
                                    child: _buildBriefInfo(),
                                    offstage: !selectType.startsWith('${getString().jjj}'),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                onTap: () {
                  if (popup != 0)
                    setState(() {
                      popup = 0;
                    });
                },
              ),
              marketDetailBean == null || marketDetailBean.is_other == '1'
                  ? Container()
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _bottomOperation(),
                    )
            ],
          ),
        ));
  }

  _buildHead() {
    String newPrice = '--';
    Color newColor = Colours.colorFFDAFFF5;
    if (marketDetailBean != null && marketDetailBean.rice_fall != null && marketDetailBean.rice_fall.length > 0) {
      if (!marketDetailBean.rice_fall.contains('0.00')) {
        newPrice = marketDetailBean.rice_fall + '%';
        if (!marketDetailBean.rice_fall.startsWith('-')) {
          newPrice = '+' + marketDetailBean.rice_fall + '%';
        } else {
          newColor = Colours.colorFFFE3B58;
        }
      } else {
        newPrice = '0.00%';
      }
    }

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(252)),
          height: ScreenUtil().setWidth(900),
          width: double.infinity,
          child: KChartWidget(
            datas,
            // bgColor: [Colours.white,Colours.white],
            bgColor: [Color(0xFF141F31), Color(0xFF141F31)],
            isLine: isLine,
            mainState: _mainState,
            volHidden: _volHidden,
            secondaryState: _secondaryState,
            fixedLength: 2,
            timeFormat: TimeFormat.YEAR_MONTH_DAY,
            isChinese: isChinese,
          ),
        ),
        Container(
          color: Color(0xFF141F31),
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    child: Text(
                      marketDetailBean?.close ?? '--',
                      style: TextStyle(color: newColor, fontSize: ScreenUtil().setSp(60)),
                    ),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(17)),
                    child: Row(
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(text: '≈¥${marketDetailBean?.amount_cny ?? '--'} ', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(28))),
                          TextSpan(text: newPrice, style: TextStyle(color: newColor, fontSize: ScreenUtil().setSp(28))),
                        ]))
                      ],
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: ScreenUtil().setWidth(200)),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(31)),
                    child: Row(
                      children: [Text('${getString().g}', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(24))), Text(marketDetailBean?.high ?? '--', style: TextStyles.textWhite12)],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: ScreenUtil().setWidth(200)),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(31)),
                    child: Row(
                      children: [Text('${getString().d}', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(24))), Text(marketDetailBean?.low ?? '--', style: TextStyles.textWhite12)],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: ScreenUtil().setWidth(200)),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(31)),
                    child: Row(
                      children: [Text('${getString().jinkai}', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(24))), Text(marketDetailBean?.open ?? '--', style: TextStyles.textWhite12)],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: ScreenUtil().setWidth(200)),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(31)),
                    child: Row(
                      children: [Text('${getString().zuoshou}', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(24))), Text(marketDetailBean?.close_yesterday ?? '--', style: TextStyles.textWhite12)],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: ScreenUtil().setWidth(200)),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(31)),
                    child: Row(
                      children: [Text('24h', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(24))), Text(marketDetailBean?.amount ?? '--', style: TextStyles.textWhite12)],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: Color(0xFF141F31),
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(200)),
          child: Column(
            children: [
              Container(
                color: Color(0x0DFFFFFF),
                height: ScreenUtil().setWidth(1),
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                height: ScreenUtil().setWidth(72),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '${getString().fs}',
                            style: TextStyle(color: period == '1' ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                          ),
                          Align(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isLine
                                      ? period == '1'
                                          ? Color(0xFF0055FF)
                                          : Color(0xFF687D9C)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(2)),
                              height: ScreenUtil().setWidth(4),
                              width: ScreenUtil().setWidth(49),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
                      onTap: () {
                        if (!isLine) {
                          isLine = true;
                          period = '1';
                          popup = 0;
                          getKLineData();
                          if (!GlobalTransaction.isWsOnHttp)
                            setState(() {
                              showLoading = true;
                            });
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                    ),
                    GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '15${getString().f}',
                            style: TextStyle(color: period == '15' ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                          ),
                          Align(
                            child: Container(
                              decoration: BoxDecoration(color: period == '15' ? Color(0xFF0055FF) : Colors.transparent, borderRadius: BorderRadius.circular(2)),
                              height: ScreenUtil().setWidth(4),
                              width: ScreenUtil().setWidth(49),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
                      onTap: () {
                        if (period != '15') {
                          isLine = false;
                          period = '15';
                          popup = 0;
                          getKLineData();
                          if (!GlobalTransaction.isWsOnHttp)
                            setState(() {
                              showLoading = true;
                            });
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                    ),
                    GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '1${getString().xss}',
                            style: TextStyle(color: period == '60' ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                          ),
                          Align(
                            child: Container(
                              decoration: BoxDecoration(color: period == '60' ? Color(0xFF0055FF) : Colors.transparent, borderRadius: BorderRadius.circular(2)),
                              height: ScreenUtil().setWidth(4),
                              width: ScreenUtil().setWidth(49),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
                      onTap: () {
                        if (period != '60') {
                          isLine = false;
                          period = '60';
                          popup = 0;
                          getKLineData();
                          if (!GlobalTransaction.isWsOnHttp)
                            setState(() {
                              showLoading = true;
                            });
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                    ),
                    GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '4${getString().xss}',
                            style: TextStyle(color: period == '240' ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                          ),
                          Align(
                            child: Container(
                              decoration: BoxDecoration(color: period == '240' ? Color(0xFF0055FF) : Colors.transparent, borderRadius: BorderRadius.circular(2)),
                              height: ScreenUtil().setWidth(4),
                              width: ScreenUtil().setWidth(49),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
                      onTap: () {
                        if (period != '240') {
                          isLine = false;
                          period = '240';
                          popup = 0;
                          getKLineData();
                          if (!GlobalTransaction.isWsOnHttp)
                            setState(() {
                              showLoading = true;
                            });
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                    ),
                    GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '${getString().rx}',
                            style: TextStyle(color: period == '1440' ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                          ),
                          Align(
                            child: Container(
                              decoration: BoxDecoration(color: period == '1440' ? Color(0xFF0055FF) : Colors.transparent, borderRadius: BorderRadius.circular(2)),
                              height: ScreenUtil().setWidth(4),
                              width: ScreenUtil().setWidth(49),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
                      onTap: () {
                        if (period != '1440') {
                          isLine = false;
                          period = '1440';
                          popup = 0;
                          getKLineData();
                          if (!GlobalTransaction.isWsOnHttp)
                            setState(() {
                              showLoading = true;
                            });
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                    ),
                    GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                (period == '1' && !isLine)
                                    ? '1${getString().f}'
                                    : period == '5'
                                        ? '5${getString().f}'
                                        : period == '10080'
                                            ? '${getString().zx}'
                                            : '${getString().gd}',
                                style: TextStyle(
                                    color: (period == '1' && !isLine)
                                        ? Color(0xFF0055FF)
                                        : period == '5'
                                            ? Color(0xFF0055FF)
                                            : period == '10080'
                                                ? Color(0xFF0055FF)
                                                : Color(0xFF687D9C),
                                    fontSize: ScreenUtil().setWidth(24)),
                              ),
                              LoadImage(
                                'horn',
                                width: ScreenUtil().setWidth(10),
                                height: ScreenUtil().setWidth(10),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                          Align(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: (period == '1' && !isLine)
                                      ? Color(0xFF0055FF)
                                      : period == '5'
                                          ? Color(0xFF0055FF)
                                          : period == '10080'
                                              ? Color(0xFF0055FF)
                                              : Colors.transparent,
                                  borderRadius: BorderRadius.circular(2)),
                              height: ScreenUtil().setWidth(4),
                              width: ScreenUtil().setWidth(49),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
                      onTap: () {
                        if (popup != 1)
                          setState(() {
                            popup = 1;
                          });
                      },
                      behavior: HitTestBehavior.opaque,
                    ),
                    GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${getString().zbbs}',
                                style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                              ),
                              LoadImage(
                                'horn',
                                width: ScreenUtil().setWidth(10),
                                height: ScreenUtil().setWidth(10),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.end,
                          )
                        ],
                      ),
                      onTap: () {
                        if (popup != 2)
                          setState(() {
                            popup = 2;
                          });
                      },
                      behavior: HitTestBehavior.opaque,
                    )
                  ],
                ),
              ),
              Container(
                color: Colours.color0D000000,
                height: ScreenUtil().setWidth(2),
                width: double.infinity,
              ),
            ],
          ),
        ),
        if (popup == 1)
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(262), right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            decoration: BoxDecoration(color: Color(0xFF141F31), border: Border.all(color: Color(0xFF3E4858), width: ScreenUtil().setWidth(2)), borderRadius: BorderRadius.all(Radius.circular(6))),
            height: ScreenUtil().setWidth(72),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                    child: Text(
                      '1${getString().f}',
                      style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                    ),
                  ),
                  onTap: () {
                    if (period != '1') {
                      period = '1';
                      isLine = false;
                      popup = 0;
                      getKLineData();
                      if (!GlobalTransaction.isWsOnHttp)
                        setState(() {
                          showLoading = true;
                        });
                    } else {
                      setState(() {
                        popup = 0;
                      });
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                    child: Text(
                      '5${getString().f}',
                      style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                    ),
                  ),
                  onTap: () {
                    if (period != '5') {
                      period = '5';
                      isLine = false;
                      popup = 0;
                      getKLineData();
                      if (!GlobalTransaction.isWsOnHttp)
                        setState(() {
                          showLoading = true;
                        });
                    } else {
                      setState(() {
                        popup = 0;
                      });
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                    child: Text(
                      '${getString().zx}',
                      style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(24)),
                    ),
                  ),
                  onTap: () {
                    if (period != '10080') {
                      period = '10080';
                      isLine = false;
                      popup = 0;
                      getKLineData();
                      if (!GlobalTransaction.isWsOnHttp)
                        setState(() {
                          showLoading = true;
                        });
                    } else {
                      setState(() {
                        popup = 0;
                      });
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                )
              ],
            ),
          ),
        if (popup == 2)
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(262), right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            decoration: BoxDecoration(color: Colours.background, border: Border.all(color: Colours.color0D000000, width: ScreenUtil().setWidth(2))),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        child: Text(
                          '${getString().zt}',
                          style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(28)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        height: ScreenUtil().setWidth(30),
                        width: ScreenUtil().setWidth(2),
                        color: Color(0xFF687D9C),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                          child: Text(
                            'MA',
                            style: TextStyle(color: _mainState == MainState.MA ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(28)),
                          ),
                        ),
                        onTap: () {
                          if (_mainState != MainState.MA)
                            setState(() {
                              _mainState = MainState.MA;
                            });
                        },
                        behavior: HitTestBehavior.opaque,
                      ),
                      GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                            child: Text(
                              'BOLL',
                              style: TextStyle(color: _mainState == MainState.BOLL ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(28)),
                            ),
                          ),
                          onTap: () {
                            if (_mainState != MainState.BOLL)
                              setState(() {
                                _mainState = MainState.BOLL;
                              });
                          },
                          behavior: HitTestBehavior.opaque)
                    ],
                  ),
                  height: ScreenUtil().setWidth(72),
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        child: Text(
                          '${getString().ft}',
                          style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(28)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                        height: ScreenUtil().setWidth(30),
                        width: ScreenUtil().setWidth(2),
                        color: Color(0xFF687D9C),
                      ),
                      GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                            child: Text(
                              'MACD',
                              style: TextStyle(color: _secondaryState == SecondaryState.MACD ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(28)),
                            ),
                          ),
                          onTap: () {
                            if (_secondaryState != SecondaryState.MACD)
                              setState(() {
                                _secondaryState = SecondaryState.MACD;
                              });
                          },
                          behavior: HitTestBehavior.opaque),
                      GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                            child: Text(
                              'KDJ',
                              style: TextStyle(color: _secondaryState == SecondaryState.KDJ ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(28)),
                            ),
                          ),
                          onTap: () {
                            if (_secondaryState != SecondaryState.KDJ)
                              setState(() {
                                _secondaryState = SecondaryState.KDJ;
                              });
                          },
                          behavior: HitTestBehavior.opaque),
                      GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                            child: Text(
                              'RSI',
                              style: TextStyle(color: _secondaryState == SecondaryState.RSI ? Color(0xFF0055FF) : Color(0xFF687D9C), fontSize: ScreenUtil().setWidth(28)),
                            ),
                          ),
                          onTap: () {
                            if (_secondaryState != SecondaryState.RSI)
                              setState(() {
                                _secondaryState = SecondaryState.RSI;
                              });
                          },
                          behavior: HitTestBehavior.opaque)
                    ],
                  ),
                  height: ScreenUtil().setWidth(72),
                )
              ],
            ),
          ),
        if (showLoading) Container(width: double.infinity, height: ScreenUtil().setWidth(980), alignment: Alignment.center, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colours.themeColor))),
      ],
    );
  }

  _buildTypes() {
    return typeList.map((item) {
      return Tab(child: Text(item.toString(), style: selectType == item ? TextStyle(color: Color(0xFF0055FF), fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.bold) : TextStyle(color: Colours.colorB4, fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.bold)));
    }).toList();
  }

  _bottomOperation() {
    return Container(
      height: ScreenUtil().setWidth(128),
      child: Row(
        children: <Widget>[
          Expanded(
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    EventBus().send('main_switch', {'mainType': 'transaction', 'type': 'purchase', 'market1': market1, 'market2': market2});
                    // EventBus().send('switch_transaction', {'type': 'purchase', 'market1': market1, 'market2': market2});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(10), left: ScreenUtil().setWidth(30)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: ChartColors.upColor, borderRadius: BorderRadius.all(Radius.circular(6))),
                    height: ScreenUtil().setWidth(88),
                    child: Text('${getString().mr}', style: TextStyle(fontSize: ScreenUtil().setSp(32), color: ColorsUtil.hexColor(0xffffff), fontWeight: FontWeight.bold)),
                  ))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    EventBus().send('main_switch', {'mainType': 'transaction', 'type': 'sellOut', 'market1': market1, 'market2': market2});
                    // EventBus().send('switch_transaction', {'type': 'sellOut', 'market1': market1, 'market2': market2});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(10)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: ChartColors.dnColor, borderRadius: BorderRadius.all(Radius.circular(6))),
                    height: ScreenUtil().setWidth(88),
                    child: Text('${getString().mc}', style: TextStyle(fontSize: ScreenUtil().setSp(32), color: ColorsUtil.hexColor(0xffffff), fontWeight: FontWeight.bold)),
                  ))),
        ],
      ),
    );
  }

  _buildDepth() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: ScreenUtil().setWidth(461),
              width: double.infinity,
              child: DepthChart(cyDepthBys, cyDepthSells, buyPathColor: ColorsUtil.hexColor(0x16a47a, alpha: 0.2), sellPathColor: ColorsUtil.hexColor(0xd94f57, alpha: 0.2)),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(29)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                    width: ScreenUtil().setWidth(12),
                    height: ScreenUtil().setWidth(12),
                    color: ChartColors.upColor,
                  ),
                  Text('${getString().mmp}', style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(20))),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(32), right: ScreenUtil().setWidth(10)),
                    width: ScreenUtil().setWidth(12),
                    height: ScreenUtil().setWidth(12),
                    color: ChartColors.dnColor,
                  ),
                  Text('${getString().mmmp}', style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(20)))
                ],
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(10), bottom: ScreenUtil().setWidth(5)),
          color: Colours.color0D000000,
          width: double.infinity,
          height: ScreenUtil().setWidth(1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30), vertical: ScreenUtil().setWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${getString().mmp}', style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(20))),
              Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(20))),
              Text('${getString().sl}($market1)', style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(20))),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text('${getString().jg}($market2)', style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(20))),
              )),
              Text('${getString().sl}($market1)', style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(20))),
              Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(20))),
              Text('${getString().mmmp}', style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(20))),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _depthLeftItem(index);
              },
              itemCount: _bids.length,
            )),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _depthRightItem(index);
              },
              itemCount: _asks.length,
            ))
          ],
        )
      ],
    );
  }

  _depthLeftItem(index) {
    DepthEntity depthEntity = _bids[index];
    double percentage = (depthEntity.sucSize / depthEntity.fullSize) * 100;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            child: Container(
              height: double.infinity,
              width: gearWidth * percentage,
              color: ColorsUtil.hexColor(0x16a47a, alpha: 0.05),
            ),
            alignment: Alignment.centerRight,
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(15)),
            child: Row(
              children: [
                Container(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(24)),
                  ),
                  width: ScreenUtil().setWidth(60),
                ),
                Text(
                  depthEntity.vol.toString(),
                  style: TextStyles.textWhite12,
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    depthEntity.price.toString(),
                    style: TextStyle(color: ChartColors.upColor, fontSize: ScreenUtil().setSp(24)),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
      height: ScreenUtil().setWidth(64),
    );
  }

  _depthRightItem(index) {
    DepthEntity depthEntity = _asks[index];
    double percentage = (depthEntity.sucSize / depthEntity.fullSize) * 100;
    percentage.isNaN ? percentage = 0.0 : percentage = percentage;
    return Container(
      height: ScreenUtil().setWidth(64),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: double.infinity,
            width: gearWidth * percentage,
            color: ColorsUtil.hexColor(0xd94f57, alpha: 0.05),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(30)),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    depthEntity.price.toString(),
                    style: TextStyle(color: ChartColors.dnColor, fontSize: ScreenUtil().setSp(24)),
                  ),
                )),
                Text(depthEntity.vol.toString(), style: TextStyles.textWhite12),
                Container(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: ChartColors.defaultTextColor, fontSize: ScreenUtil().setSp(24)),
                    ),
                    alignment: Alignment.centerRight,
                    width: ScreenUtil().setWidth(60)),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildDeal() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(38), bottom: ScreenUtil().setWidth(20)),
          child: Row(
            children: [
              Expanded(child: Text('${getString().sj}', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(20)))),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text('', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(20))),
              )),
              Expanded(flex: 2, child: Text('${getString().jg}(${market2.toUpperCase()})', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(20)))),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text('${getString().sl}(${market1.toUpperCase()})', style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(20))),
                  ))
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _dealItem(index);
          },
          itemCount: transList.length,
        ),
      ],
    );
  }

  _dealItem(index) {
    CyTransLogData cyTransLogData = transList[index];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30), vertical: ScreenUtil().setWidth(20)),
      child: Row(
        children: [
          Expanded(
              child: Text(
            DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(cyTransLogData.ts) * 1000).toString(), format: 'HH:mm:ss'),
            style: TextStyles.textWhite12,
          )),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              cyTransLogData.direction.contains('buy') ? '${getString().mr}' : '${getString().mc}',
              style: TextStyle(color: cyTransLogData.direction.contains('buy') ? Colours.colorFF00C58F : Colours.colorFFFE3B58, fontSize: ScreenUtil().setSp(24)),
            ),
          )),
          Expanded(flex: 2, child: Text(cyTransLogData.price, style: TextStyles.textWhite12)),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: Text(cyTransLogData.amount, style: TextStyles.textWhite12),
          ))
        ],
      ),
    );
  }

  _buildBriefInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(34), left: ScreenUtil().setWidth(30)),
          child: Text(
            market1,
            style: TextStyle(color: Color(0xFF687D9C), fontSize: ScreenUtil().setSp(36)),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          width: double.infinity,
          height: ScreenUtil().setWidth(99),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('${getString().fxsj}', style: TextStyles.textGrey15), Text(cyIntroData?.time ?? '', style: TextStyles.textWhite15)],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          color: Colours.color0D000000,
          width: double.infinity,
          height: ScreenUtil().setWidth(1),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        //   width: double.infinity,
        //   height: ScreenUtil().setWidth(99),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [Text('发行总量', style: TextStyles.textGrey15), Text(cyIntroData?.circulateCount ?? '', style: TextStyles.textWhite15)],
        //   ),
        // ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          color: Colours.color0D000000,
          width: double.infinity,
          height: ScreenUtil().setWidth(1),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          width: double.infinity,
          height: ScreenUtil().setWidth(99),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('${getString().liutongzhongl}', style: TextStyles.textGrey15), Text(cyIntroData?.issueCount ?? '', style: TextStyles.textWhite15)],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          color: Colours.color0D000000,
          width: double.infinity,
          height: ScreenUtil().setWidth(1),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          width: double.infinity,
          height: ScreenUtil().setWidth(99),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${getString().bps}', style: TextStyles.textGrey15),
              Gaps.hGap10,
              Expanded(
                  child: inkButton(
                      child: Text(cyIntroData?.whiteBook ?? '', style: TextStyles.textWhite10),
                      onPressed: () async {
                        await launch('${cyIntroData?.whiteBook}');
                        // Navigator.pushNamed(context, PageRouter.webview_page, arguments: Bundle()..putString('titleName', '${getString().bps}')..putString('url', '${cyIntroData?.whiteBook}'));
                      }))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          color: Colours.color0D000000,
          width: double.infinity,
          height: ScreenUtil().setWidth(1),
        ),
        inkButton(
            onPressed: () async {
              await launch('${cyIntroData?.webside}');
              // Navigator.pushNamed(context, PageRouter.webview_page, arguments: Bundle()..putString('titleName', '${getString().bps}')..putString('url', '${cyIntroData?.whiteBook}'));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              width: double.infinity,
              height: ScreenUtil().setWidth(99),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('${getString().gw}', style: TextStyles.textGrey15), Text(cyIntroData?.webside ?? '', style: TextStyles.textWhite15)],
              ),
            )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          color: Colours.color0D000000,
          width: double.infinity,
          height: ScreenUtil().setWidth(1),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        //   width: double.infinity,
        //   height: ScreenUtil().setWidth(99),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text('${getString().qkss}', style: TextStyles.textGrey15),
        //       Text(
        //         cyIntroData?.blockSearch ?? '',
        //         style: TextStyles.textWhite15,
        //       )
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        //   color: Colours.color0D000000,
        //   width: double.infinity,
        //   height: ScreenUtil().setWidth(1),
        // ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(73), bottom: ScreenUtil().setWidth(34), left: ScreenUtil().setWidth(30)),
          child: Text('${getString().jjj}', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)),
        ),
        Html(
          data: cyIntroData?.intro ?? '',
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          defaultTextStyle: TextStyles.textWhite15,
        )
      ],
    );
  }

  Timer newsTimer;
  bool requestType = true;

  //定时器
  timeNews() {
    if (newsTimer != null) {
      return;
    }

    newsTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (GlobalTransaction.isWsOnHttp) {
        showLoading = false;
        KlineWebSocket().sinkSend('{"method":"pull_heart"}');
      } else {
        if (requestType) getKLineData(isR: false);
      }
      if (requestType) {
        getMarketDetail();
        getCyTransLog();
        getDepthData();
      }
    });
  }

  //K线数据
  getKLineData({isR = true}) {
    if (GlobalTransaction.isWsOnHttp) {
      setState(() {
        showLoading = false;
      });

      KlineWebSocket.on(({arg}) {
        if (arg['method'] == 'pull_heart' || arg['data'] == null) return;
        List<KLineEntity> lsList = (arg['data'].map((item) => KLineEntity.fromJson(item)).toList().reversed.toList().cast<KLineEntity>());

        for (int i = 0; i < lsList.length; i++) {
          if (period == lsList[i].kline_type && (market1 + '_' + market2).contains(lsList[i].currency_name)) {
            int index = datas.indexWhere((item) => item.id == lsList[i].id);
            if (index != -1) {
              datas.setAll(index, [lsList[i]]);
            } else {
              datas.add(lsList[i]);
            }
          }
        }
        DataUtil.calculate(datas);
        print('Kline:${datas.length}');
        if (mounted) setState(() {});
      });
      datas.clear();
      KlineWebSocket().sinkSend('{"method":"pull_kline_graph","data":{"market":"${market1}_$market2","k_line_type":"$period","k_line_count":"500"}}');
    } else {
      if (isR) {
        datas.clear();
        setState(() {
          showLoading = true;
        });
      }
      Net().post(ApiTransaction.push_kline_graph, {"symbol": market1.toUpperCase() + '_' + market2.toUpperCase(), 'type': period, 'limit': datas.length == 0 ? 1000 : 10}, success: (data) {
        setState(() {
          showLoading = false;
        });
        List<KLineEntity> lsList = (data.map((item) => KLineEntity.fromJson(item)).toList().reversed.toList().cast<KLineEntity>());

        for (int i = 0; i < lsList.length; i++) {
          if (period == lsList[i].kline_type && (market1 + '_' + market2).contains(lsList[i].currency_name)) {
            int index = datas.indexWhere((item) => item.id == lsList[i].id);
            if (index != -1) {
              datas.setAll(index, [lsList[i]]);
            } else {
              datas.add(lsList[i]);
            }
          }
        }
        DataUtil.calculate(datas);
        print('Kline:${datas.length},lsList:${lsList.length}');
        if (mounted) setState(() {});
      }, failure: (error) {
        // showToast('$error');
        setState(() {
          showLoading = false;
        });
      });
      if (isR) {
        datas.clear();
        setState(() {
          showLoading = true;
        });
      }
    }
  }

  //交易对行情
  getMarketDetail() {
    requestType = false;
    Net().post(ApiTransaction.market_detail, {"symbol": market1.toUpperCase() + '_' + market2.toUpperCase()}, success: (data) {
      requestType = true;
      marketDetailBean = MarketDetailBean.fromJson(data);
      if (mounted) setState(() {});
    }, failure: (error) {
      requestType = true;
    });
  }

  // 简介
  getIntroData() {
    Net().post(ApiTransaction.CY_INTRO, {"currency": market1.toUpperCase()}, success: (data) {
      cyIntroData = CyIntroData.fromJson(data);
      if (mounted) setState(() {});
    }, failure: (error) {
      // Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }

  // 成交记录
  getCyTransLog() {
    Net().post(ApiTransaction.pull_order_deal, {"symbol": market1.toUpperCase() + '_' + market2.toUpperCase()}, success: (data) {
      transList.clear();
      data.forEach((v) {
        transList.add(CyTransLogData.fromJson(v));
      });
      print('transList:${transList.length}');
      if (mounted) setState(() {});
    });
  }

  // 深度
  getDepthData() {
    Net().post(ApiTransaction.pull_order_depth, {'symbol': market1.toUpperCase() + '_' + market2.toUpperCase()}, success: (data) {
      _bids.clear();
      _asks.clear();
      cyDepthBys.clear();
      cyDepthSells.clear();
      List<DepthEntity> cyDepthBysTmp = [];
      List bidsTmp = data['bids'];
      bidsTmp?.forEach((element) {
        _bids.add(DepthEntity.fromJson(element));
        cyDepthBysTmp.add(DepthEntity.fromJson(element));
      });

      if (_bids.length != 0) {
        // _bids.sort((DepthEntity left, DepthEntity right) => left.price.compareTo(right.price));
        cyDepthBysTmp.sort((DepthEntity left, DepthEntity right) => left.price.compareTo(right.price));
      }

      double amount = 0.0;
      cyDepthBysTmp.reversed.forEach((item) {
        amount += item.vol;
        item.vol = amount;
        cyDepthBys.insert(0, item);
      });

      List<DepthEntity> cyDepthSellsTmp = [];
      List asksTmp = data['asks'];
      asksTmp?.forEach((element) {
        _asks.add(DepthEntity.fromJson(element));
        cyDepthSellsTmp.add(DepthEntity.fromJson(element));
      });

      amount = 0.0;
      cyDepthSellsTmp?.forEach((item) {
        amount += item.vol;
        item.vol = amount;
        cyDepthSells.add(item);
      });
      if (mounted) setState(() {});
    });
  }
}
