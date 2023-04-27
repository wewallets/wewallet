import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/ore_bean.dart';
import 'package:mars/models/pool_list_entity.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OreMainPage extends StatefulWidget {
  OreMainPage({Key key}) : super(key: key);

  @override
  _OreMainPageState createState() => _OreMainPageState();
}

class _OreMainPageState extends State<OreMainPage> {
  RefreshController refreshController = RefreshController();
  PoolListEntity poolListEntity;
  String cName; // 币名称
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: false,
          enablePullDown: false,
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: <Widget>[
              buildSliverPersistentHeader,
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    LoadImage('ic_ore_title_bg_qt', fit: BoxFit.fill, width: double.infinity, height: ScreenUtil().setWidth(65)),
                    Container(
                      decoration: BoxDecoration(color: Colours.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _loading
                              ? LayoutUtil.getLoadingShadeCustom(text: '')
                              : ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: _buildOreRow,
                                  itemCount: 2,
                                )
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
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top:  ScreenUtil().setWidth(30)),
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

  getTp() {
    if (getLocale() == 'zh') {
      return 'ic_ore_top_bg_qt2';
    } else if (getLocale() == 'ms') {
      return 'ic_ore_top_bg_qt4';
    } else if (getLocale() == 'th') {
      return 'ic_ore_top_bg_qt3';
    } else {
      return 'ic_ore_top_bg_qt';
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

  @override
  void initState() {
    super.initState();
    getPoolList();
  }

  // 获取矿池列表
  getPoolList() {
    Net().post(ApiTransaction.ORE_LIST, {'account': GlobalTransaction.walletInfo.account_id}, success: (data) {
      poolListEntity = PoolListEntity().fromJson(data);

      setState(() {
        _loading = false;
      });
    }, failure: (error) {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
