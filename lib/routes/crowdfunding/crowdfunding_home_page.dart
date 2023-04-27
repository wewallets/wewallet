import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/noticeList.dart';
import 'package:mars/models/ore_bean.dart';
import 'package:mars/models/pool_list_entity.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_class_page.dart';
import 'package:mars/widgets/font_marquee.dart';
import 'package:mars/widgets/my_underline_tab_indicator.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/banner_list_entity.dart';
import 'crowdfunding_my_page.dart';

//众筹首页
class CrowdFundingHomePage extends StatefulWidget {
  CrowdFundingHomePage({Key key}) : super(key: key);

  @override
  _CrowdFundingHomePageState createState() => _CrowdFundingHomePageState();
}

class _CrowdFundingHomePageState extends State<CrowdFundingHomePage> with TickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  PoolListEntity poolListEntity;
  String cName; // 币名称
  bool _loading = true;
  List<NoticeList> noticeList = [];
  TabController _controller;
  List<String> tabList = [];
  List<BannerListEntity> bannerList = [];

  @override
  void initState() {
    super.initState();
    tabList = ['${getString().xtj12}', '${getString().zf47}', '${getString().zf50}'];
    _controller = TabController(vsync: this, length: tabList.length);
    getPoolList();
  }

  getTab(data) {
    if (tabList[0] == data) return 0;
    if (tabList[1] == data) return 1;
    if (tabList[2] == data) return 2;
    // if (tabList[3] == data) return 3;
  }

  @override
  Widget build(BuildContext context) {
    double expandedHeight = ScreenUtil().setWidth(324);
    return Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: false,
          enablePullDown: false,
          onRefresh: () async {},
          child: Column(
            children: [
              Container(
                  height: expandedHeight,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      LoadImage(getTp(), fit: BoxFit.fill, width: double.infinity, height: expandedHeight),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            color: makeStickyHeaderWhite(ScreenUtil().setWidth(300), kToolbarHeight, 0),
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(30)),
                            child: GestureDetector(
                              child: Container(
                                child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), color: makeStickyHeaderIconColor(0)),
                                height: kToolbarHeight,
                                alignment: Alignment.centerLeft,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              behavior: HitTestBehavior.opaque,
                            ),
                          )),
                    ],
                  )),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colours.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildType(),

                          Container(color: Colours.colorF5, height: ScreenUtil().setWidth(2), width: double.infinity),
                          // buildNotice,
                          // Container(color: Colours.colorF5, height: ScreenUtil().setWidth(2), width: double.infinity),
                          buildBannerHead,
                          Container(
                            height: adaptationDp(40),
                            width: double.infinity,
                            child: TabBar(
                              unselectedLabelColor: Colours.colorFFB0A8C8,
                              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
                              labelColor: Colours.colorFF7854D5,
                              labelStyle: TextStyle(fontSize: ScreenUtil().setSp(26)),
                              controller: _controller,
                              isScrollable: false,
                              onTap: (index) {
                                setState(() {});
                              },
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: tabList.map((String name) {
                                if (getTab(name) == _controller.index)
                                  return Tab(
                                      child: Container(
                                    margin: EdgeInsets.only(bottom: adaptationDp(8)),
                                    decoration: BoxDecoration(color: getTypeTabBarViewBgColor(), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: getTypeTabBarViewColor(), width: 0.5)),
                                    alignment: Alignment.center,
                                    child: Text(name, style: TextStyles.textBlack12.copyWith(color: getTypeTabBarViewColor())),
                                  ));
                                else
                                  return Tab(
                                      child: Container(
                                    height: adaptationDp(25),
                                    margin: EdgeInsets.only(bottom: adaptationDp(8)),
                                    decoration: BoxDecoration(color: Colours.transparent, borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: Colours.transparent, width: 0.5)),
                                    alignment: Alignment.center,
                                    child: Text(name, style: TextStyles.textBlack12.copyWith(color: Color(0xFFC2C2C2))),
                                  ));
                              }).toList(),
                              indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: ScreenUtil().setWidth(2), color: getTypeTabBarViewColor())),
                            ),
                          ),
                          Expanded(
                              child: TabBarView(
                            children: tabList.map((e) => getTab(e) == 2 ? CrowdFundingMyPage() : CrowdFundingClassPage(getTab(e))).toList(),
                            controller: _controller,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  getTypeTabBarViewColor() {
    if (_controller == null) return Color(0xFFF6AF46);

    switch (_controller.index) {
      case 0:
        return Color(0xFFF6AF46);
      case 1:
        return Color(0xFFFE3937);
      case 2:
        return Color(0xFF3250D4);
      default:
        return Color(0xFFF6AF46);
    }
  }

  getTypeTabBarViewBgColor() {
    if (_controller == null) return Color(0x1AF6AF46);

    switch (_controller.index) {
      case 0:
        return Color(0x1AF6AF46);
      case 1:
        return Color(0x1AFE3937);
      case 2:
        return Color(0x1A3250D4);
      default:
        return Color(0x1AF6AF46);
    }
  }

  get buildSliverPersistentHeader {
    double expandedHeight = ScreenUtil().setWidth(324);
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverCustomCommonHeaderDelegate(
            expandedHeight: expandedHeight,
            collapsedHeight: kToolbarHeight,
            paddingTop: ScreenUtil().statusBarHeight,
            widget: (double shrinkOffset, bool overlapsContent) {
              return Container(
                  height: expandedHeight,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      LoadImage(getTp(), fit: BoxFit.fill, width: double.infinity, height: expandedHeight),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            color: makeStickyHeaderWhite(ScreenUtil().setWidth(300), kToolbarHeight, shrinkOffset),
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(30)),
                            child: GestureDetector(
                              child: Container(
                                child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), color: makeStickyHeaderIconColor(shrinkOffset)),
                                height: kToolbarHeight,
                                alignment: Alignment.centerLeft,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              behavior: HitTestBehavior.opaque,
                            ),
                          )),
                    ],
                  ));
            }));
  }

  getLq2() {
    if (getLocale() == 'zh') {
      return 'zongchouchaoshi';
    } else if (getLocale() == 'ms') {
      return 'zongchouchaoshi';
    } else if (getLocale() == 'th') {
      return 'zongchouchaoshi';
    } else {
      return 'zongchouchaoshi';
    }
  }

  getTp() {
    if (getLocale() == 'zh') {
      return 'zcbl4';
    } else if (getLocale() == 'ms') {
      return 'zcbl1';
    } else if (getLocale() == 'th') {
      return 'zcbl2';
    } else {
      return 'zcbl3';
    }
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

  Widget _buildOreRow(BuildContext context, int index) {
    return index == 0
        ? GestureDetector(
            child: Container(
                margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('kuanciitem_bg')), fit: BoxFit.fill)),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(26), bottom: ScreenUtil().setWidth(18)),
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(child: LoadImage('logo_x', width: ScreenUtil().setWidth(60), height: ScreenUtil().setWidth(60))),
                                Padding(padding: EdgeInsets.only(right: ScreenUtil().setWidth(20))),
                                Text('YISE', style: TextStyles.textBlack16),
                                Expanded(child: Container()),
                                Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(text: '${getString().pooltxt1}  ', style: TextStyles.textGrey11),
                                    TextSpan(text: '${poolListEntity.rISE.yesterdayAward}', style: TextStyle(color: Color(0xFF1635BB), fontSize: ScreenUtil().setSp(22))),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(text: '≈ ', style: TextStyles.textGrey11),
                                    TextSpan(text: '${poolListEntity.rISE.yesterdayAwardUsdt}', style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setSp(22))),
                                  ]))
                                ]),
                                Gaps.hGap10,
                              ],
                            ),
                          ),
                        ],
                      ),
                      height: ScreenUtil().setWidth(130),
                    ),
                    Container(
                      color: Colours.color0D000000,
                      height: ScreenUtil().setWidth(1),
                      width: double.infinity,
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text('${getString().pooltxt2}', style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24))),
                              ),
                              Expanded(child: Text('${getString().pooltxt3}', style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24)), textAlign: TextAlign.center)),
                              Expanded(
                                child: Text('${getString().pooltxt4}', style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24)), textAlign: TextAlign.right),
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setWidth(14)),
                          Row(
                            children: [
                              Expanded(child: Text(poolListEntity.rISE.allAward ?? '0.0', style: TextStyles.textBlack11)),
                              Expanded(child: Text(poolListEntity.rISE.processAward ?? '0.0', style: TextStyles.textBlack11, textAlign: TextAlign.center)),
                              Expanded(child: Text('${poolListEntity.rISE.populAward ?? '0.0'}', style: TextStyles.textBlack11, textAlign: TextAlign.right)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setWidth(30)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      color: ColorsUtil.hexColor(0x7854D5, alpha: 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(text: '${getString().pooltxt5}  ', style: TextStyles.textGrey11),
                            TextSpan(text: '${poolListEntity.rISE.risePoolBestLimit ?? 0.0}    ', style: TextStyle(color: Color(0xFF1635BB), fontSize: ScreenUtil().setSp(24))),
                            TextSpan(text: '${getString().pooltxt6}  ', style: TextStyles.textGrey11),
                            TextSpan(text: '${poolListEntity.rISE.risePoolMinKeep ?? 0.0}', style: TextStyle(color: Color(0xFF1635BB), fontSize: ScreenUtil().setSp(24))),
                          ])),
                          LoadImage('ic_dot_more', width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(10))
                        ],
                      ),
                      height: ScreenUtil().setWidth(72),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pushNamed(context, PageTransactionRouter.ore_detail_page, arguments: Bundle()..putString('currenCy', 'YISE'));
            },
          )
        : GestureDetector(
            child: Container(
                margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('kuanciitem_bg')), fit: BoxFit.fill)),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(26), bottom: ScreenUtil().setWidth(18)),
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(child: LoadImage('fil', width: ScreenUtil().setWidth(60), height: ScreenUtil().setWidth(60))),
                                Padding(padding: EdgeInsets.only(right: ScreenUtil().setWidth(20))),
                                Text('FIL', style: TextStyles.textBlack16),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      height: ScreenUtil().setWidth(130),
                    ),
                    Container(
                      color: Colours.color0D000000,
                      height: ScreenUtil().setWidth(1),
                      width: double.infinity,
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text('${getString().pooltxt7}', style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24))),
                              ),
                              Expanded(child: Text('${getString().pooltxt8}', style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24)), textAlign: TextAlign.center)),
                              Expanded(
                                child: Text('${getString().pooltxt11}', style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24)), textAlign: TextAlign.right),
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setWidth(14)),
                          Row(
                            children: [
                              Expanded(child: Text(poolListEntity.fIL.assetsFil ?? '0.0', style: TextStyles.textBlack11)),
                              Expanded(child: Text(poolListEntity.fIL.useFil ?? '0.0', style: TextStyles.textBlack11, textAlign: TextAlign.center)),
                              Expanded(child: Text('${poolListEntity.fIL.x7daysAward ?? '0.0'}', style: TextStyles.textBlack11, textAlign: TextAlign.right)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setWidth(30)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      color: ColorsUtil.hexColor(0x7854D5, alpha: 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(text: '${getString().pooltxt9}  ', style: TextStyles.textGrey11),
                            TextSpan(text: '${poolListEntity.fIL.filPoolReleaseTotal ?? 0.0}    ', style: TextStyle(color: Color(0xFF1635BB), fontSize: ScreenUtil().setSp(24))),
                            TextSpan(text: '${getString().pooltxt10}  ', style: TextStyles.textGrey11),
                            TextSpan(text: '${poolListEntity.fIL.filPoolReleasePercen ?? 0.0}%', style: TextStyle(color: Color(0xFF1635BB), fontSize: ScreenUtil().setSp(24))),
                          ])),
                          LoadImage('ic_dot_more', width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(10))
                        ],
                      ),
                      height: ScreenUtil().setWidth(72),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pushNamed(context, PageTransactionRouter.ore_fil_detail_page, arguments: Bundle()..putString('currenCy', 'FIL'));
            },
          );
  }

  buildType() {
    return Padding(
        padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), bottom: adaptationDp(20), top: adaptationDp(20)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // Expanded(
          //     child: Container(
          //         child: inkButton(
          //             onPressed: () {
          //               navigatorContextPush(context, PageRouter.crowdfunding_my_page);
          //             },
          //             child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
          //               LoadImage('wodezhongchou', width: adaptationDp(35), height: adaptationDp(35)),
          //               Gaps.vGap8,
          //               Text('${getString().zf50}', style: TextStyles.textBlack12),
          //             ])))),
          Expanded(
              child: Container(
                  child: inkButton(
                      onPressed: () {
                        navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_promote_page);
                      },
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                        LoadImage('wodetuig', width: adaptationDp(35), height: adaptationDp(35)),
                        Gaps.vGap8,
                        Text('${getString().zf51}', style: TextStyles.textBlack12),
                      ])))),
          Expanded(
              child: Container(
                  child: inkButton(
                      onPressed: () {
                        navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_award_page);
                      },
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                        LoadImage('zhongchoujiangli', width: adaptationDp(35), height: adaptationDp(35)),
                        Gaps.vGap8,
                        Text('${getString().zf52}', style: TextStyles.textBlack12),
                      ])))),
          Expanded(
              child: Container(
                  child: inkButton(
                      onPressed: () {
                        navigatorTransactionContextPush(context, PageTransactionRouter.help_center_page);
                      },
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                        LoadImage('bangzhuzhongx', width: adaptationDp(35), height: adaptationDp(35)),
                        Gaps.vGap8,
                        Text('${getString().zf53}', style: TextStyles.textBlack12),
                      ])))),
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
              return Container(width: double.infinity, height: double.infinity, child: LoadImage('${bannerList[index].bannerUrl}', width: double.infinity, height: double.infinity, fit: BoxFit.fill), padding: EdgeInsets.all(adaptationDp(9)));
            },
            controller: SwiperController(),
            viewportFraction: 1,
            onTap: (index) {
              navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_illustrate_page);
            },
          ));
    }
    return Container();
  }

  get buildNotice {
    return Container(
      height: ScreenUtil().setWidth(80),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: adaptationDp(20), right: adaptationDp(20)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        LoadImage('gonggaoqb', width: ScreenUtil().setWidth(44)),
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
                                  ..putString('titleName', '${getString().zf53}')
                                  ..putString('url', '${ApiTransaction.BASE_URL}explorer/notice_detail/${noticeList[index].id}.html'));
                          },
                          child: Text('${noticeList[index].title}', style: TextStyles.textGrey612.copyWith(color: Color(0xFF333A42)), overflow: TextOverflow.ellipsis, maxLines: 1),
                        ));
                  })),
        InkWell(
          child: Padding(child: LoadImage('home_gengduo', fit: BoxFit.contain, width: ScreenUtil().setWidth(30), height: ScreenUtil().setWidth(60)), padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10))),
          onTap: () {
            navigatorTransactionContextPush(context, PageTransactionRouter.help_center_page);
          },
        ),
      ]),
    );
  }

  getPoolList() {
    Net().post(ApiTransaction.fund_gonggao_list, {'flag': '0'}, success: (data) {
      noticeList.clear();
      data['list'].forEach((element) {
        noticeList.add(NoticeList.fromJson(element));
      });
      if (mounted) setState(() {});
    });
    Net().post(ApiTransaction.fund_detail, {'account': GlobalTransaction.walletInfo.account_id}, success: (data) {
      poolListEntity = PoolListEntity().fromJson(data);

      setState(() {
        _loading = false;
      });
    }, failure: (error) {});
    Net().post(ApiTransaction.agreement, {'type': '14'}, success: (data) {
      bannerList.clear();
      data.forEach((v) {
        bannerList.add(BannerListEntity().fromJson(v));
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
