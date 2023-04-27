import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:mars/models/earings_history_entity.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mars/models/my_pool_entity.dart';

class OrePoolMyPage extends StatefulWidget {
  final Bundle bundle;

  OrePoolMyPage(this.bundle);

  @override
  _OrePoolMyPageState createState() => _OrePoolMyPageState();
}

class _OrePoolMyPageState extends State<OrePoolMyPage> {
  RefreshController refreshController = RefreshController();
  PagingLoad pagingLoad = PagingLoad();
  MyPoolEntity myPoolEntity;
  List<EaringsHistoryEntity> historyList = [];
  int rankType = 1;
  int incomeType = 1;

  @override
  void initState() {
    super.initState();
    getDetail();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: false,
          onLoading: () {
            getData();
          },
          child: CustomScrollView(
            slivers: [
              buildSliverPersistentHeader,
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.vGap10,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(29)),
                          child: Row(
                            children: [
                              Text('产量明细', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Container(color: Color(0xFFEEEEEE), height: 0.5, width: double.infinity, margin: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), top: adaptationDp(15))),
                        historyList.length == 0
                            ? LayoutUtil.buildErrorWidget(topHeight: 100)
                            : listViewBuilder(
                                padding: EdgeInsets.all(adaptationDp(15)),
                                isSlide: true,
                                itemCount: historyList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: adaptationDp(17)),
                                    child: Row(
                                      children: [
                                        Expanded(child: Container(child: Row(children: [Text('${historyList[index].createTime}', style: TextStyles.textBlack14)]))),
                                        Expanded(child: Container(child: Row(children: [Text('${historyList[index].state == '1' ? '已产出' : '产出中'}', style: TextStyles.textBlack14.copyWith(color: historyList[index].state == '1' ? Color(0xFF16A47A) : Color(0xFFD94F57)))]))),
                                        Expanded(
                                            child: Container(
                                                child:
                                                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text('${NumUtil.getNumByValueDouble(double.parse(historyList[index].teamAmount) + double.parse(historyList[index].staticAmount), 4).toStringAsFixed(4)}', style: TextStyles.textBlack14)]))),
                                      ],
                                    ),
                                  );
                                }),
                        Gaps.vGap30,
                      ],
                    ),
                    // detailData == null ? LayoutUtil.getLoadingShadeCustom(top: 200) : Container()
                  ],
                ),
              )
            ],
          )),
    );
  }

  get buildSliverPersistentHeader {
    double expandedHeight = ScreenUtil().setWidth(400) + ScreenUtil().statusBarHeight + kToolbarHeight;
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
                      LoadImage('kuangchibeij', fit: BoxFit.fill, width: double.infinity, height: ScreenUtil().setWidth(400)),
                      ((ScreenUtil().statusBarHeight + kToolbarHeight) - shrinkOffset) > 0 ? Container(margin: EdgeInsets.only(top: (ScreenUtil().statusBarHeight + kToolbarHeight) - shrinkOffset), child: buildDetail()) : Container(),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            color: makeStickyHeaderWhite(ScreenUtil().setWidth(300), kToolbarHeight, shrinkOffset),
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().statusBarHeight),
                            height: kToolbarHeight + ScreenUtil().statusBarHeight,
                            child: Stack(
                              children: [
                                Center(child: Text('我的矿池', style: TextStyle(color: makeStickyHeaderIconColor(shrinkOffset), fontSize: ScreenUtil().setSp(36)))),
                                GestureDetector(
                                  child: Container(
                                    child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), color: makeStickyHeaderIconColor(shrinkOffset)),
                                    height: kToolbarHeight,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  behavior: HitTestBehavior.opaque,
                                )
                              ],
                            ),
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

  buildDetail() {
    return Container(
      height: ScreenUtil().setWidth(400),
      width: double.infinity,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('kuangcizhongbg')), fit: BoxFit.fill)),
      child: Column(
        children: [
          Gaps.vGap35,
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('当前矿池总数', style: TextStyles.textTheme16.copyWith(color: Color(0xFFA3763B))),
              Gaps.vGap5,
              Text('${myPoolEntity.investmentCurrent ?? '0.0'}', style: TextStyles.textTheme20.copyWith(color: Color(0xFF2F2517), fontSize: adaptationDpSp(31))),
            ]),
          ]),
          Gaps.vGap15,
          Container(color: Color(0xFFEBC995), height: 0.5, width: double.infinity, margin: EdgeInsets.only(left: adaptationDp(25), right: adaptationDp(25))),
          Gaps.vGap5,
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('矿池总数量', style: TextStyles.textTheme12.copyWith(color: Color(0xFFA3763B))),
              Gaps.vGap5,
              Text('${myPoolEntity.investmentTotal}', style: TextStyles.textTheme16.copyWith(color: Color(0xFF2F2517))),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('总产量', style: TextStyles.textTheme14.copyWith(color: Color(0xFFA3763B))),
              Gaps.vGap5,
              Text('${myPoolEntity.revenueTotal}', style: TextStyles.textTheme16.copyWith(color: Color(0xFF2F2517))),
            ]),
          ]),
          Text('${myPoolEntity.investmentRemind}', style: TextStyles.textTheme12.copyWith(color: Color(0xFFA3763B))),
        ],
      ),
    );
  }

  getDetail() {
    if (SpUtil.hasKey('myPoolEntity')) {
      myPoolEntity = SpUtil.getObj('myPoolEntity', (v) => MyPoolEntity().fromJson(v));
      if (mounted) setState(() {});
    }

    Net().post(ApiTransaction.POOL_MY, {'product_id': widget.bundle.getString('id')}, success: (data) {
      myPoolEntity = MyPoolEntity().fromJson(data);
      SpUtil.putObject('myPoolEntity', myPoolEntity);
      if (mounted) setState(() {});
    });
  }

  getData() {
    var map = pagingLoad.getMapPagingLoad();
    map['product_id'] = widget.bundle.getString('id');
    Net().post(ApiTransaction.EARINGS_HISTORY, map, success: (data) {
      pagingLoad.loading = false;
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        historyList.clear();
        data['list'].forEach((element) {
          historyList.add(EaringsHistoryEntity().fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          historyList.add(EaringsHistoryEntity().fromJson(element));
        });
      } else {
        pagingLoad.reduce();
        refreshController.refreshCompleted();
        refreshController.loadNoData();
      }
      if (mounted) setState(() {});
    }, failure: (error) {
      pagingLoad.reduce();
      pagingLoad.loading = false;

      if (mounted) setState(() {});
    });
  }
}
