import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/num_util.dart';
import '../../models/banner_list_entity.dart';
import '../../models/collection_product_list_entity.dart';
import '../../models/marketList.dart';
import '../../models/noticeList.dart';
import '../../socket/market_home_socket.dart';
import '../../widgets/font_marquee.dart';

//新主页
class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController refreshController = RefreshController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime lastPopTime;
  List<NoticeList> noticeList = [];
  List<BannerListEntity> bannerList = [];
  List<MarketList> marketList = [];
  Timer newsTimer;
  bool requestType = true;
  CollectionProductListEntity collectionProductListEntity;

  @override
  void initState() {
    super.initState();
    getHomeData();

    timeNews();

    if (GlobalTransaction.isWsOnHttp) {
      startWs();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF100F1A),
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
                        // buildPopularPicks,
                        buildNotice,
                        buildDigitalStorage,
                        buildQuotation,
                        // buildXs,
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
    double expandedHeight = ScreenUtil().setWidth(150) + ScreenUtil().statusBarHeight + kToolbarHeight;
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
                      inkButton(
                          child: LoadAssetImage(getLq2(), fit: BoxFit.fitWidth, width: double.infinity, height: expandedHeight),
                          onPressed: () {
                            navigatorTransactionContextPush(context, PageTransactionRouter.about_us_page);
                          }),
                      // Positioned(
                      //     left: 0,
                      //     right: 0,
                      //     top: 0,
                      //     child: Container(
                      //       color: makeStickyHeaderWhite(expandedHeight, kToolbarHeight, shrinkOffset),
                      //       padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight + ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                      //       height: kToolbarHeight + ScreenUtil().statusBarHeight,
                      //       child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      //         inkButton(child: LoadAssetImage('logo', width: ScreenUtil().setWidth(150), color: makeStickyHeaderIconColor(shrinkOffset)), onPressed: () {}),
                      //       ]),
                      //     )),
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
      return Colours.transparent;
    else
      return null;
  }

  get buildModular {
    return Container(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), bottom: adaptationDp(20), top: adaptationDp(20)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () async {
                          if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.crowdfunding_home_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('h_sc', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('${getString().zf79}', style: TextStyles.textWhite12),
                        ])))),
            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PageTransactionRouter.main_page); // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.activation_miner_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('h_jys', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('${getString().jiaoyisuo}', style: TextStyles.textWhite12),
                        ])))),
            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () {
                          if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.main_digital_storage_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('h_szcp', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('${s.text2}', style: TextStyles.textWhite12),
                        ])))),
            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PageTransactionRouter.main_swap_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('home_swap', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('SWAP', style: TextStyles.textWhite12),
                        ])))),
          ])),
      // Padding(
      //     padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), bottom: adaptationDp(20)),
      //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //       Expanded(
      //           child: Container(
      //               child: inkButton(
      //                   onPressed: () {
      //                     navigatorContextPush(context, PageRouter.ecology_detail11_page);
      //
      //                     // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.share_page);
      //                   },
      //                   child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
      //                     LoadImage('h_hd', width: adaptationDp(45), height: adaptationDp(45)),
      //                     Gaps.vGap3,
      //                     Text('${getString().huidui}', style: TextStyles.textWhite12),
      //                   ])))),
      //       Expanded(
      //           child: Container(
      //               child: inkButton(
      //                   onPressed: () {
      //                     navigatorContextPush(context, PageRouter.ecology_detail1_page);
      //
      //                     // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.activation_miner_page);
      //                   },
      //                   child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
      //                     LoadImage('h_cj', width: adaptationDp(45), height: adaptationDp(45)),
      //                     Gaps.vGap3,
      //                     Text('${getString().caijing}', style: TextStyles.textWhite12),
      //                   ])))),
      //       Expanded(
      //           child: Container(
      //               child: inkButton(
      //                   onPressed: () {
      //                     navigatorContextPush(context, PageRouter.ecology_detail5_page);
      //
      //                     // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.ore_contribution_page);
      //                   },
      //                   child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
      //                     LoadImage('h_dc', width: adaptationDp(45), height: adaptationDp(45)),
      //                     Gaps.vGap3,
      //                     Text('${getString().dichang}', style: TextStyles.textWhite12),
      //                   ])))),
      //       Expanded(
      //           child: Container(
      //               child: inkButton(
      //                   onPressed: () {
      //                     navigatorContextPush(context, PageRouter.ecology_detail6_page);
      //
      //                     // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.account_book_page);
      //                   },
      //                   child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
      //                     LoadImage('h_ly', width: adaptationDp(45), height: adaptationDp(45)),
      //                     Gaps.vGap3,
      //                     Text('${getString().luyou}', style: TextStyles.textWhite12),
      //                   ])))),
      //     ])),
      Padding(
          padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), bottom: adaptationDp(20)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Expanded(
            //     child: Container(
            //         child: inkButton(
            //             onPressed: () {
            //               navigatorContextPush(context, PageRouter.ecology_detail3_page);
            //
            //               // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.share_page);
            //             },
            //             child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
            //               LoadImage('h_gy', width: adaptationDp(45), height: adaptationDp(45)),
            //               Gaps.vGap3,
            //               Text('${getString().gongyi}', style: TextStyles.textWhite12),
            //             ])))),
            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, PageRouter.main_swap_page);
                          // navigatorContextPush(context, PageRouter.ecology_detail10_page);

                          // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.activation_miner_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('h_wdb', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('${s.text33}', style: TextStyles.textWhite12),
                        ])))),

            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () {
                          navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail4_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('h_lc', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('RISE EARN', style: TextStyles.textWhite12),
                        ])))),
            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () {
                          navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail2_page);
                          // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.account_book_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('shangc_new', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('${getString().sc}', style: TextStyles.textWhite12),
                        ])))),
            Expanded(
                child: Container(
                    child: inkButton(
                        onPressed: () {
                          navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail7_page);
                          // if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.ore_contribution_page);
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          LoadImage('h_nft', width: adaptationDp(45), height: adaptationDp(45)),
                          Gaps.vGap3,
                          Text('NFT', style: TextStyles.textWhite12),
                        ])))),
          ])),
      Container(color: Colours.colorF5, height: ScreenUtil().setWidth(2), width: double.infinity),
    ]));
  }

  get buildPopularPicks {
    return Container(
      margin: EdgeInsets.all(adaptationDp(10)),
      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(10))),
      padding: EdgeInsets.all(adaptationDp(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: adaptationDp(5),
                height: adaptationDp(20),
                decoration: BoxDecoration(color: Color(0xFF1B308F), borderRadius: BorderRadius.circular(adaptationDp(5))),
              ),
              Gaps.hGap5,
              Text('${getString().remengshousuo}', style: TextStyles.textBlack15),
            ],
          ),
          Gaps.vGap15,
          Row(children: [
            Expanded(
                child: Row(children: [
              Column(
                children: [
                  Text('${getString().sc}', style: TextStyles.textBlack15),
                  Text('${getString().sxszsh}', style: TextStyles.textGrey12),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Expanded(child: Container()),
              LoadAssetImage('re_sc', width: adaptationDp(30)),
            ])),
            Gaps.hGap20,
            Container(width: adaptationDp(1), color: Color(0xFFF3F3F3), height: adaptationDp(30)),
            Gaps.hGap20,
            Expanded(
                child: Row(children: [
              Column(
                children: [
                  Text('DEFI', style: TextStyles.textBlack15),
                  Text('${getString().wzzncf}', style: TextStyles.textGrey12),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Expanded(child: Container()),
              LoadAssetImage('wzdifi', width: adaptationDp(30)),
            ])),
          ]),
        ],
      ),
    );
  }

  get buildXs {
    return Container(
      margin: EdgeInsets.all(adaptationDp(10)),
      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(10))),
      padding: EdgeInsets.all(adaptationDp(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: adaptationDp(5),
                height: adaptationDp(20),
                decoration: BoxDecoration(color: Color(0xFF1B308F), borderRadius: BorderRadius.circular(adaptationDp(5))),
              ),
              Gaps.hGap5,
              Text('${getString().xinrenjinjie}', style: TextStyles.textBlack15),
            ],
          ),
          Gaps.vGap15,
          Row(children: [
            // Expanded(
            //     child: Container(
            //         child: Stack(children: [
            //           LoadAssetImage('h_jrqzbg', width: double.infinity),
            //           Align(
            //               alignment: Alignment.topCenter,
            //               child: Padding(
            //                 padding: EdgeInsets.only(top: adaptationDp(10)),
            //                 child: Text('${getString().jiaruquanz}', style: TextStyles.textBlack15),
            //               )),
            //           Align(
            //               alignment: Alignment.bottomCenter,
            //               child: Padding(
            //                 padding: EdgeInsets.only(bottom: adaptationDp(10)),
            //                 child: LoadAssetImage('h_jrqz', width: adaptationDp(70)),
            //               )),
            //         ]),
            //         height: adaptationDp(140))),
            // Gaps.hGap10,
            Expanded(
                child: inkButton(
                    onPressed: () {
                      navigatorTransactionContextPush(context, PageTransactionRouter.help_page, bundle: Bundle()..putString('type', '3'));
                    },
                    child: Container(
                        child: Stack(children: [
                          LoadAssetImage('h_xsrmbg', width: double.infinity),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: adaptationDp(10)),
                                child: Text('${getString().xinshourum}', style: TextStyles.textBlack15),
                              )),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: adaptationDp(10)),
                                child: LoadAssetImage('h_xsrm', width: adaptationDp(94)),
                              )),
                        ]),
                        height: adaptationDp(140)))),
            Gaps.hGap10,
            Expanded(
                child: inkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PageTransactionRouter.big_coffee_said_page);
                    },
                    child: Container(
                        child: Stack(children: [
                          LoadAssetImage('h_dksbg', width: double.infinity),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: adaptationDp(10)),
                                child: Text('${getString().dakas}', style: TextStyles.textBlack15),
                              )),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: adaptationDp(10)),
                                child: LoadAssetImage('h_dks', width: adaptationDp(75)),
                              )),
                        ]),
                        height: adaptationDp(140)))),
          ]),
        ],
      ),
    );
  }

  get buildNotice {
    return Container(
      height: ScreenUtil().setWidth(80),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Color(0x660D183D), borderRadius: BorderRadius.circular(adaptationDp(10))),
      margin: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10)),
      padding: EdgeInsets.only(left: adaptationDp(20), right: adaptationDp(20)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        LoadImage('xgognggs', width: ScreenUtil().setWidth(44)),
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
                          child: Text('${noticeList[index].title}', style: TextStyles.textWhite12, overflow: TextOverflow.ellipsis, maxLines: 1),
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

  get buildQuotation {
    return Container(
        margin: EdgeInsets.only(top: dp(10)),
        decoration: BoxDecoration(color: Color(0x660D183D), borderRadius: BorderRadius.circular(adaptationDp(10))),
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
                                          Text('${marketList[index].trad_currency_name}', style: TextStyles.textWhite15.copyWith(fontWeight: FontWeight.bold)),
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
                            Container(color: Color(0x1AFFFFFF), height: ScreenUtil().setWidth(1)),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: marketList.length),
        ]));
  }

  get buildDigitalStorage {
    return collectionProductListEntity == null
        ? Container()
        : inkButton(
            onPressed: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.main_digital_storage_page);
            },
            child: Container(
                decoration: BoxDecoration(color: Color(0x660D183D), borderRadius: BorderRadius.circular(adaptationDp(10))),
                padding: EdgeInsets.all(dp(10)),
                margin: EdgeInsets.only(left: dp(10), right: dp(10), top: dp(10)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                  Row(children: [
                    Text('${s.text63}', style: TextStyles.textWhite15.copyWith(fontWeight: FontWeight.bold)),
                    Expanded(child: Container()),
                    LoadAssetImage('icon_goto', width: dp(22), color: Colours.white),
                  ]),
                  Gaps.vGap10,
                  LoadImage('mor_shuc', width: double.infinity, height: dp(194)),
                  Gaps.vGap10,
                  // Text('${collectionProductListEntity.referCurrency}', style: TextStyles.textWhite15),
                  // Gaps.vGap10,
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Color(0xFFCC3C8D), width: 1)),
                      padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(3), bottom: dp(5)),
                      alignment: Alignment.center,
                      child: Text('${s.text64}', style: TextStyles.textWhite12.copyWith(color: Color(0xFFCC3C8D))),
                    ),
                    Gaps.hGap10,
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Color(0xFFCC3C8D), width: 1)),
                      padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(3), bottom: dp(5)),
                      alignment: Alignment.center,
                      child: Text('${s.text65}', style: TextStyles.textWhite12.copyWith(color: Color(0xFFCC3C8D))),
                    ),
                    Gaps.hGap10,
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Color(0xFFCC3C8D), width: 1)),
                      padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(3), bottom: dp(5)),
                      alignment: Alignment.center,
                      child: Text('${s.text66}', style: TextStyles.textWhite12.copyWith(color: Color(0xFFCC3C8D))),
                    ),
                    Gaps.hGap10,
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Color(0xFFCC3C8D), width: 1)),
                      padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(3), bottom: dp(5)),
                      alignment: Alignment.center,
                      child: Text('${s.text67}', style: TextStyles.textWhite12.copyWith(color: Color(0xFFCC3C8D))),
                    ),
                  ]),
                  Gaps.vGap10,
                  Text('${s.text68}', style: TextStyles.textWhite13.copyWith(color: Color(0xFF3859ED))),
                ])));
  }

  get buildBannerHead {
    if (bannerList.length != 0) {
      return Container(
          width: double.infinity,
          height: adaptationDp(100),
          child: Swiper(
            fade: 0.2,
            autoplayDelay: 5000,
            duration: 500,
            itemCount: bannerList.length,
            autoplay: true,
            itemBuilder: (context, index) {
              return Container(width: double.infinity, height: double.infinity, child: LoadImage('${bannerList[index].bannerUrl}', width: double.infinity, height: double.infinity, fit: BoxFit.fill), padding: EdgeInsets.all(adaptationDp(10)));
            },
            controller: SwiperController(),
            viewportFraction: 1,
          ));
    }
    return Container();
  }

  getLq1() {
    if (getLocale() == 'zh') {
      return 'h_sybn';
    } else if (getLocale() == 'ms') {
      return 'h_sybn6';
    } else if (getLocale() == 'th') {
      return 'h_sybn5';
    } else {
      return 'h_sybn2';
    }
  }

  getLq2() {
    if (getLocale() == 'zh') {
      return 'h_tb';
    } else if (getLocale() == 'ms') {
      return 'h_syb4';
    } else if (getLocale() == 'th') {
      return 'h_sybn3';
    } else {
      return 'h_tb2';
    }
  }

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

  getHomeData() {
    Net().post(ApiTransaction.GONGGAO_LIET, null, success: (data) {
      noticeList.clear();
      data['list'].forEach((element) {
        noticeList.add(NoticeList.fromJson(element));
      });
      if (mounted) setState(() {});
    });

    Net().post(ApiTransaction.banner_list, {'type': '0'}, success: (data) {
      bannerList.clear();
      data.forEach((v) {
        bannerList.add(BannerListEntity().fromJson(v));
      });
      setState(() {});
    });
    Net().post(ApiTransaction.collection_product_list, null, success: (data) {
      if (data.length != 0) {
        collectionProductListEntity = CollectionProductListEntity().fromJson(data[0]);
      }
      setState(() {});
    });
  }
}
