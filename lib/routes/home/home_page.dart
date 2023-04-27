import 'dart:async';
import 'dart:io';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/global.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/banner_list_entity.dart';
import 'package:mars/models/index.dart';
import 'package:mars/models/pool_details_entity.dart';
import 'package:mars/models/poolyesterday_entity.dart';
import 'package:mars/routes/drawer/user_drawer.dart';
import 'package:mars/socket/market_home_socket.dart';
import 'package:mars/widgets/dialog/scan_view_sheet_dialog.dart';
import 'package:mars/widgets/font_marquee.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//主页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController refreshController = RefreshController();

  //公告
  List<NoticeList> noticeList = [];
  TabController controller;
  List<String> tabList = ['市场'];
  int tabIndex = 1;
  bool isTabLoading = true;

  // List<MarketList> marketList = [];
  int lsTabIndex = 0;
  List<BannerList> _listBanner = [];
  List quotationList = [];
  PoolyesterdayEntity poolYesterdayEntity;
  List<MarketList> marketList = [];

  List<BannerListEntity> bannerList = [];

  //公告
  String noteId;
  String noteTitle;

  Timer newsTimer;
  String isRaiseActive;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool requestType = true;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3, initialIndex: tabIndex);
    initEvent();

    timeNews();
    if (GlobalTransaction.isWsOnHttp) {
      startWs();
    }
    getData();
  }

  timeNews() async {
    newsTimer = Timer.periodic(Duration(milliseconds: GlobalTransaction.isWsOnHttp ? 1000 : 2000), (timer) {
      if (GlobalTransaction.isWsOnHttp) {
        MarketHomeSocket().sinkSend('{"method":"pull_heart"}', isConnect: false);

        MarketHomeSocket().sinkSend('{"method":"pull_market_list"}');
      } else {
        if (requestType) getQuotation();
      }
    });
  }

  initEvent() async {
    EventBus().on('refreshHome', ({arg}) {
      newsTimer.cancel();
      newsTimer = null;
      timeNews();

      getData();
    });
  }

  @override
  void dispose() {
    newsTimer.cancel();
    EventBus().off('refreshHome');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: Drawer(child: UserDrawer()),
      key: _scaffoldKey,
      backgroundColor: Colours.white,
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: false,
        onRefresh: () async {},
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                buildSliverPersistentHeader,
                SliverList(
                    delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
                      children: [
                        buildModular,
                        buildBannerHead,

                        // Padding(padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), top: adaptationDp(10), bottom: adaptationDp(10)), child: LoadImage(getLq1(), height: adaptationDp(100))),

                        // Container(color: Colours.colorF5, height: ScreenUtil().setWidth(20), width: double.infinity),
                        // buildRealTimeMarket,
                        // Container(color: Colours.colorF5, height: ScreenUtil().setWidth(20), width: double.infinity),
                        buildQuotation,
                      ],
                    );
                  },
                  childCount: 1,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  get buildSliverPersistentHeader {
    double expandedHeight = ScreenUtil().setWidth(200) + ScreenUtil().statusBarHeight + kToolbarHeight;
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverCustomCommonHeaderDelegate(
            expandedHeight: expandedHeight,
            collapsedHeight: kToolbarHeight - ScreenUtil().setWidth(20),
            paddingTop: ScreenUtil().statusBarHeight,
            widget: (double shrinkOffset, bool overlapsContent) {
              return Container(
                  height: expandedHeight,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      LoadImage('home_head_bg', fit: BoxFit.fill, width: double.infinity, height: expandedHeight),
                      (ScreenUtil().setWidth(150) - shrinkOffset) > 0
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(100)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${getString().ztkcsy}（RISE）', style: TextStyles.textGrey14.copyWith(color: Color(0xFFD1C8EA))),
                                    Gaps.vGap5,
                                    Row(
                                      children: [
                                        Text('${detailData?.totalAwardYesterday ?? '0.0'}', style: TextStyles.textWhite25.copyWith(fontWeight: FontWeight.bold)),
                                        Gaps.hGap5,
                                        Text('≈ \$${detailData?.totalAwardYesterdayUsdt ?? '0.0'}', style: TextStyles.textWhite12),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                          : Container(),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            color: makeStickyHeaderWhite(expandedHeight, kToolbarHeight, shrinkOffset),
                            padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight + ScreenUtil().setWidth(20), left: adaptationDp(15), bottom: ScreenUtil().setWidth(20)),
                            height: kToolbarHeight + ScreenUtil().statusBarHeight,
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                              inkButton(
                                  child: Padding(padding: EdgeInsets.only(top: adaptationDp(5)), child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(40), color: makeStickyHeaderIconColor(shrinkOffset))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              Gaps.hGap15,
                              // inkButton(
                              //     child: LoadAssetImage('touxiang', width: ScreenUtil().setWidth(60), color: makeStickyHeaderIconColor(shrinkOffset)),
                              //     onPressed: () {
                              //       _scaffoldKey.currentState.openDrawer();
                              //     }),
                              Expanded(child: Container()),
                              inkButton(
                                  child: LoadAssetImage('home_sys', width: ScreenUtil().setWidth(40), color: makeStickyHeaderIconColor(shrinkOffset)),
                                  onPressed: () async {
                                    if (LayoutUtil.isLogin(context, isShowLogin: true)) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (Platform.isAndroid) {
                                        await Permission.camera.request().then((value) {
                                          if ( value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
                                            Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().kqxjqxsb}');
                                            return;
                                          }
                                        });
                                      }
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colours.transparent,
                                          context: context,
                                          builder: (builder) {
                                            return ScanViewSheetDialog((data) {
                                              if (data != null) Navigator.pushNamed(context, PageTransactionRouter.transfer_accounts_page, arguments: Bundle()..putString('address', data.toString()));
                                            });
                                          });
                                    }
                                  }),
                              Gaps.hGap20,
                              // inkButton(
                              //     child: LoadAssetImage('home_skm', width: ScreenUtil().setWidth(30), color: makeStickyHeaderIconColor(shrinkOffset)),
                              //     onPressed: () {
                              //       if (LayoutUtil.isLogin(context, isShowLogin: true)) navigatorContextPush(context, PageRouter.select_currency_page, bundle: Bundle()..putInt('type', 1));
                              //     }),
                              // Gaps.hGap20,
                            ]),
                          )),
                    ],
                  ));
            }));
  }

  Color makeStickyHeaderWhite(maxExtent, minExtent, shrinkOffset) {
    final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderIconColor(shrinkOffset) {
    if (shrinkOffset <= 60)
      return Colours.white;
    else
      return Colors.black;
  }

  get buildNotice {
    return Container(
      height: ScreenUtil().setWidth(80),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: adaptationDp(20), right: adaptationDp(20)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        LoadImage('home_tz', width: ScreenUtil().setWidth(28)),
        Gaps.hGap8,
        Expanded(
            child: noticeList == null || noticeList.length == 0
                ? Container()
                : FontMarquee(noticeList.length, (BuildContext context, int index) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageTransactionRouter.webview_page,
                                arguments: Bundle()
                                  ..putString('titleName', '${getString().ggxq}')
                                  ..putString('url', '${ApiTransaction.BASE_URL}explorer/notice_detail/${noticeList[index].id}.html'));
                          },
                          child: Text('${noticeList[index].title}', style: TextStyles.textGrey612.copyWith(color: Color(0xFF333A42)), overflow: TextOverflow.ellipsis, maxLines: 1),
                        ));
                  })),
        InkWell(
          child: Padding(child: LoadImage('home_gengduo', fit: BoxFit.contain, width: ScreenUtil().setWidth(30), height: ScreenUtil().setWidth(60)), padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10))),
          onTap: () {
            Navigator.pushNamed(context, PageTransactionRouter.webview_page,
                arguments: Bundle()
                  ..putString('titleName', '${getString().gglb}')
                  ..putString('url', '${ApiTransaction.BASE_URL}explorer/notice.html'));
          },
        ),
      ]),
    );
  }

  get buildModular {
    return Container(
        decoration: BoxDecoration(color: Colours.white),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), bottom: adaptationDp(20), top: adaptationDp(20)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.transfer_accounts_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_zz', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().zz}', style: TextStyles.textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.ore_main_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_kc', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().kc}', style: TextStyles.textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.account_book_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_zb', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().zbb}', style: TextStyles.textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.activation_miner_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_jhyh', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().jihuoyonghu}', style: TextStyles.textBlack12),
                            ])))),
              ])),
          Padding(
              padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), bottom: adaptationDp(20)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              // showToast('${getString().jqqd}');
                              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.crowdfunding_home_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_zc', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().zf79}', style: TextStyles.textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.share_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_hbyq', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().hongbaoyaoqing}', style: TextStyles.textBlack12),
                            ])))),
                // Expanded(
                //     child: Container(
                //         child: inkButton(
                //             onPressed: () {
                //               showToast('${getString().jqqd}');
                //               // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.activation_miner_page);
                //             },
                //             child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                //               LoadImage('home_shop', width: adaptationDp(35), height: adaptationDp(35)),
                //               Gaps.vGap8,
                //               Text('${getString().shangdian}', style: TextStyles.textBlack12),
                //             ])))),
                // Expanded(
                //     child: Container(
                //         child: inkButton(
                //             onPressed: () {
                //               showToast('${getString().jqqd}');
                //               // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.ore_contribution_page);
                //             },
                //             child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                //               LoadImage('home_jyu', width: adaptationDp(35), height: adaptationDp(35)),
                //               Gaps.vGap8,
                //               Text('${getString().jiaoyu}', style: TextStyles.textBlack12),
                //             ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (LayoutUtil.isLogin(context, isShowLogin: true))
                                showSm();
                              else
                                showToast('${getString().jqqd}');
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('h_zc', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().zhongchou}', style: TextStyles.textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              showToast('${getString().jqqd}');

                              // Navigator.pushNamed(context, PageRouter.main_digital_storage_page);
                              // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.crowdfunding_home_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('shandui', width: adaptationDp(35), height: adaptationDp(35)),
                              Gaps.vGap8,
                              Text('${getString().sd}', style: TextStyles.textBlack12),
                            ])))),
              ])),
          // Padding(padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10)), child: LoadImage(getLq2())),
          // Gaps.vGap10,
          // Container(color: Colours.colorF5, height: ScreenUtil().setWidth(2), width: double.infinity),
          // buildNotice,
          // Container(color: Colours.colorF5, height: ScreenUtil().setWidth(2), width: double.infinity),
        ]));
  }

  // get buildQuotation {
  //   // double titleBarWidth = (ScreenUtil().screenWidth - ScreenUtil().setWidth(120)) / 3;
  //   return marketList.length == 0
  //       ? Container()
  //       : Container(
  //           decoration: BoxDecoration(color: Colours.colorF5, borderRadius: BorderRadius.circular(adaptationDp(25))),
  //           padding: EdgeInsets.only(top: adaptationDp(6.5), bottom: adaptationDp(6.5)),
  //           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //             // Padding(
  //             //     padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
  //             //     child: TabBar(
  //             //       unselectedLabelColor: Colours.textGrey,
  //             //       unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(26)),
  //             //       labelColor: Colours.colorFFC939F3,
  //             //       labelStyle: TextStyle(fontSize: ScreenUtil().setSp(28)),
  //             //       controller: controller,
  //             //       isScrollable: true,
  //             //       indicatorSize: TabBarIndicatorSize.label,
  //             //       labelPadding: EdgeInsets.only(bottom: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(28)),
  //             //       indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: ScreenUtil().setWidth(4), color: Colours.colorFFC939F3), index: tabIndex),
  //             //       tabs: <Widget>[Container(child: Text(tabList[0])),
  //             //         // Container(child: Text(tabList[1]), alignment: Alignment.center), Container(child: Text(tabList[2]), alignment: Alignment.centerRight)
  //             //       ],
  //             //       onTap: (index) {
  //             //         tabIndex = index;
  //             //         getData();
  //             //         setState(() {});
  //             //       },
  //             //     )),
  //             Align(
  //                 alignment: Alignment.center,
  //                 child: Container(
  //                     alignment: Alignment.center,
  //                     decoration: BoxDecoration(color: Color(0xFFDBD6EA), borderRadius: BorderRadius.circular(adaptationDp(12.5))),
  //                     height: adaptationDp(25),
  //                     width: adaptationDp(75),
  //                     child: Text('市场', style: TextStyles.textTheme15.copyWith(fontWeight: FontWeight.bold)))),
  //             Gaps.vGap6,
  //             Container(color: Color(0xFFE6E6E6), height: ScreenUtil().setWidth(1)),
  //             Gaps.vGap10,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(child: Text('币种', style: TextStyles.textGrey10), alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: ScreenUtil().setWidth(40))),
  //                 Center(child: Text('最新价（RMB）', style: TextStyles.textGrey10)),
  //                 Container(child: Text('涨跌（24H）', style: TextStyles.textGrey10), alignment: Alignment.centerRight, padding: EdgeInsets.only(right: ScreenUtil().setWidth(40))),
  //               ],
  //             ),
  //             marketList.length == 0
  //                 ? Container(height: ScreenUtil().setWidth(30))
  //                 : ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: NeverScrollableScrollPhysics(),
  //                     padding: EdgeInsets.zero,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return InkWell(
  //                         onTap: () {
  //                           Navigator.pushNamed(context, PageRouter.k_line_page, arguments: Bundle()..putString('market1', getListItemData(index).trad_currency_name)..putString('market2', getListItemData(index).base_currency_name));
  //                         },
  //                         child: Container(
  //                           height: ScreenUtil().setWidth(110),
  //                           child: Column(
  //                             children: [
  //                               Expanded(
  //                                   child: Container(
  //                                       padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
  //                                       child: Row(
  //                                         children: [
  //                                           Expanded(
  //                                               child: Container(
  //                                                   child: Row(mainAxisSize: MainAxisSize.min, children: [
  //                                             Text('${getListItemData(index).trad_currency_name}', style: TextStyles.textBlack15.copyWith(fontWeight: FontWeight.bold)),
  //                                             Text(' /${getListItemData(index).base_currency_name}', style: TextStyles.textGrey10),
  //                                           ]))),
  //                                           Expanded(
  //                                               child: Container(
  //                                                   child: Column(
  //                                                     children: [
  //                                                       Text('${getListItemData(index).unit_price ?? 0.0}',
  //                                                           style: TextStyle(color: getListItemData(index).rice_fall == null || !getListItemData(index).rice_fall.contains('-') ? Colours.colorFF00C58F : Colours.colorFFFE3B58, fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(30))),
  //                                                       // Text(
  //                                                       //   '',
  //                                                       // ),
  //                                                     ],
  //                                                     crossAxisAlignment: CrossAxisAlignment.center,
  //                                                     mainAxisAlignment: MainAxisAlignment.center,
  //                                                   ),
  //                                                   alignment: Alignment.center)),
  //                                           Expanded(
  //                                               child: Container(
  //                                                   child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end, children: [
  //                                             Container(
  //                                               decoration: BoxDecoration(color: getListItemData(index).rice_fall == null || !getListItemData(index).rice_fall.contains('-') ? Colours.colorFFDAFFF5 : Colours.colorFFFFEDF0, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
  //                                               padding: EdgeInsets.only(top: ScreenUtil().setWidth(16), bottom: ScreenUtil().setWidth(16), left: ScreenUtil().setWidth(22), right: ScreenUtil().setWidth(22)),
  //                                               child: Text('${getListItemData(index).rice_fall ?? 0.0}%', style: TextStyle(color: Colours.white, fontSize: ScreenUtil().setSp(26))),
  //                                             )
  //                                           ]))),
  //                                         ],
  //                                       ))),
  //                               Container(color: Colours.colorF2, height: ScreenUtil().setWidth(1)),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                     itemCount: marketList.length),
  //           ]));
  // }

  get buildRealTimeMarket {
    return Container(
        padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(10), right: adaptationDp(10)),
        child: Row(children: [
          Text('${getString().shishi}', style: TextStyles.textTheme15),
          Text('·${getString().hqq}', style: TextStyles.textBlack15),
          Gaps.hGap50,
          Text('BTC', style: TextStyles.textGrey615),
          Gaps.hGap10,
          Text('${quotationList.length != 0 ? quotationList[0]['price_usd'] : '0.0'}', style: TextStyles.textGrey615),
          Expanded(child: Container()),
          Text('${quotationList.length != 0 ? quotationList[0]['percent_change_24h'] : 0} %', style: TextStyles.textGrey615.copyWith(color: quotationList.length != 0 && !quotationList[0]['percent_change_24h'].toString().contains('-') ? Colours.colorFFDAFFF5 : Colours.colorFFFFEDF0)),
        ]));
  }

  get buildQuotation {
    // double titleBarWidth = (ScreenUtil().screenWidth - ScreenUtil().setWidth(120)) / 3;
    return Container(
        padding: EdgeInsets.only(top: adaptationDp(6.5), bottom: adaptationDp(6.5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Container(color: Color(0xFFE6E6E6), height: ScreenUtil().setWidth(20)),

          // Padding(
          //     padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          //     child: TabBar(
          //       unselectedLabelColor: Colours.textGrey,
          //       unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(26)),
          //       labelColor: Colours.colorFFC939F3,
          //       labelStyle: TextStyle(fontSize: ScreenUtil().setSp(28)),
          //       controller: controller,
          //       isScrollable: true,
          //       indicatorSize: TabBarIndicatorSize.label,
          //       labelPadding: EdgeInsets.only(bottom: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(28)),
          //       indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: ScreenUtil().setWidth(4), color: Colours.colorFFC939F3), index: tabIndex),
          //       tabs: <Widget>[Container(child: Text(tabList[0])),
          //         // Container(child: Text(tabList[1]), alignment: Alignment.center), Container(child: Text(tabList[2]), alignment: Alignment.centerRight)
          //       ],
          //       onTap: (index) {
          //         tabIndex = index;
          //         getData();
          //         setState(() {});
          //       },
          //     )),
          // Align(
          //     alignment: Alignment.center,
          //     child: Container(
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(color: Color(0xFFDBD6EA), borderRadius: BorderRadius.circular(adaptationDp(12.5))),
          //         height: adaptationDp(25),
          //         width: adaptationDp(75),
          //         child: Text('市场', style: TextStyles.textTheme15.copyWith(fontWeight: FontWeight.bold)))),
          Gaps.vGap6,
          Gaps.vGap10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: Text('${getString().bz}', style: TextStyles.textGrey10), alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: ScreenUtil().setWidth(30))),
              Center(child: Text('${getString().zxj}', style: TextStyles.textGrey10)),
              Container(child: Text('${getString().zdf}（24H）', style: TextStyles.textGrey10), alignment: Alignment.centerRight, padding: EdgeInsets.only(right: ScreenUtil().setWidth(30))),
            ],
          ),
          marketList.length == 0
              ? Container(height: ScreenUtil().setWidth(30))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageTransactionRouter.k_line_page,
                            arguments: Bundle()
                              ..putString('market1', marketList[index].trad_currency_name)
                              ..putString('market2', marketList[index].base_currency_name));
                      },
                      child: Container(
                        height: ScreenUtil().setWidth(110),
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                          Text('${marketList[index].trad_currency_name}', style: TextStyles.textBlack15.copyWith(fontWeight: FontWeight.bold)),
                                          Text(' /${marketList[index].base_currency_name}', style: TextStyles.textGrey10),
                                        ]))),
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            children: [
                                              Text('\$${marketList[index].unit_price}',
                                                  style: TextStyle(color: marketList[index].rice_fall == null || !marketList[index].rice_fall.toString().contains('-') ? Colours.colorFF00C58F : Colours.colorFFFE3B58, fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(26))),
                                              // Gaps.vGap2,
                                              // Text('\$${marketList[index].unit_price}', style: TextStyles.textGrey12.copyWith(color: Color(0xFF9499A8))),
                                            ],
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                          ),
                                          margin: EdgeInsets.only(left: adaptationDp(20)),
                                        )),
                                        Expanded(
                                            child: Container(
                                                child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end, children: [
                                          Container(
                                            decoration: BoxDecoration(color: marketList[index].rice_fall == null || !marketList[index].rice_fall.toString().contains('-') ? Colours.colorFFDAFFF5 : Colours.colorFFFFEDF0, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
                                            child: Text('${NumUtil.formArtNum(double.parse(marketList[index].rice_fall) ?? 0.0, 2)}%', style: TextStyle(color: Colours.white, fontSize: ScreenUtil().setSp(26))),
                                            width: adaptationDp(70),
                                            height: adaptationDp(35),
                                            alignment: Alignment.center,
                                          )
                                        ]))),
                                      ],
                                    ))),
                            Container(color: Colours.colorF6, height: ScreenUtil().setWidth(1)),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: marketList.length),
        ]));
  }

  get buildBannerHead {
    if (bannerList.length != 0) {
      return Container(
          width: double.infinity,
          height: adaptationDp(90),
          child: Swiper(
            fade: 0.2,
            autoplayDelay: 6000,
            duration: 500,
            itemCount: bannerList.length,
            autoplay: false,
            itemBuilder: (context, index) {
              return Container(width: double.infinity, height: double.infinity, child: LoadImage('${bannerList[index].bannerUrl}', width: double.infinity, height: double.infinity, fit: BoxFit.fill), padding: EdgeInsets.all(adaptationDp(4)));
            },
            controller: SwiperController(),
            viewportFraction: 1,
          ));
    }
    return Container();
  }

  getLq1() {
    if (getLocale() == 'zh') {
      return 'banner_1';
    } else if (getLocale() == 'ms') {
      return 'banner_1ms';
    } else if (getLocale() == 'th') {
      return 'banner_1th';
    } else {
      return 'banner_1en';
    }
  }

  getLq2() {
    if (getLocale() == 'zh') {
      return 'home_yjgm';
    } else if (getLocale() == 'ms') {
      return 'https://11-1305767227.cos.ap-singapore.myqcloud.com/image/bianzu.png';
    } else if (getLocale() == 'th') {
      return 'https://11-1305767227.cos.ap-singapore.myqcloud.com/image/bianzu2.png';
    } else {
      return 'banner_11';
    }
  }

  // MarketList getListItemData(index) {
  //   return marketList[index];
  // }

  startWs() {
    MarketHomeSocket.on(({arg}) {
      if (arg['method'] == 'pull_heart' || arg['data'] == null) return;
      switch (arg['method']) {
        case 'pull_market_list':
          if (marketList != null && marketList.length != 0)
            marketList.clear();
          else
            marketList = [];

          arg['data'].forEach((element) {
            marketList.add(MarketList.fromJson(element));
          });

          if (mounted) setState(() {});
          break;
      }

      if (mounted) setState(() {});
    });

    MarketHomeSocket().sinkSend('{"method":"pull_market_list"}');
  }

  showSm() {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.product_detail, {}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      Navigator.pushNamed(context, PageTransactionRouter.public_offering_page);
    }, failure: (error) {
      showToast('$error');
      LayoutUtil.closeLoadingDialog(context);
    });
  }

  getQuotation() async {
    requestType = false;
    Net().post(ApiTransaction.pull_order_market, null, success: (data) {
      requestType = true;
      if (marketList != null && marketList.length != 0)
        marketList.clear();
      else
        marketList = [];

      data.forEach((element) {
        marketList.add(MarketList.fromJson(element));
      });
      if (mounted) setState(() {});
    }, failure: (error) {
      requestType = true;
      if (mounted) setState(() {});
      showToast('$error');
    });
  }

  PoolDetailsEntity detailData;

  active(data) {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.active, {'invite_code': data}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      isRaiseActive = '1';
      showToast('${getString().jhcg}');
      if (mounted) setState(() {});
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }

  isActive() {
    Net().post(ApiTransaction.is_active, null, success: (data) {
      isRaiseActive = data['is_raise_active'];
      if (mounted) setState(() {});
    });
  }

  getData() {
    if (!GlobalTransaction.isWsOnHttp) getQuotation();
    isActive();
    // if (SpUtil.hasKey('homeListType$tabIndex')) {
    //   marketList = SpUtil.getObjList('homeListType$tabIndex', (v) => MarketList.fromJson(v));
    //   if (mounted) setState(() {});
    // }
    if (SpUtil.hasKey('poolYesterdayEntity')) {
      poolYesterdayEntity = SpUtil.getObj('poolYesterdayEntity', (v) => PoolyesterdayEntity().fromJson(v));
      if (mounted) setState(() {});
    }
    // if (SpUtil.hasKey('noticeList')) {
    //   noticeList = SpUtil.getObjList('noticeList', (v) => NoticeList.fromJson(v));
    //   if (mounted) setState(() {});
    // }

    Net().post(ApiTransaction.banner_list, null, success: (data) {
      bannerList.clear();
      data.forEach((v) {
        bannerList.add(BannerListEntity().fromJson(v));
      });
      setState(() {});
    });

    Net().post(ApiTransaction.ORE_DETAIL, {"currency": 'YISE'}, success: (data) {
      detailData = PoolDetailsEntity().fromJson(data);
      setState(() {});
    });

    Net().post(ApiTransaction.GONGGAO_LIET, null, success: (data) {
      noticeList.clear();
      data['list'].forEach((element) {
        noticeList.add(NoticeList.fromJson(element));
      });

      SpUtil.putObjectList('noticeList', noticeList);
      if (mounted) setState(() {});
    });
  }
}
