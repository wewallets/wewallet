import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/http/api.dart';
import 'package:mars/common/http/net.dart';
import 'package:mars/common/router/bundle.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/models/index.dart';
import 'package:mars/models/oredetail_bean.dart';
import 'package:mars/models/pool_detail_entity.dart';
import 'package:mars/models/pooldetail_entity.dart';
import 'package:mars/models/ranking_list_entity.dart';
import 'package:mars/models/ranking_minmax_entity.dart';
import 'package:mars/widgets/ore_progress_bar_widget.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';

//矿池
class OrePoolPage extends StatefulWidget {
  @override
  _OrePoolPageState createState() => _OrePoolPageState();
}

class _OrePoolPageState extends State<OrePoolPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  String currency = 'THC';

  PooldetailEntity detailData;

  Profit profit;
  List<PooldetailLogList> logList = [];
  double logMax;

  String best_keep;
  String min_keep;

  @override
  void initState() {
    super.initState();
    getData();
    EventBus().on('switch_pool', ({arg}) {
      Future.delayed(Duration(milliseconds: 0), () {
        getData();
      });
    });
  }

  @override
  void dispose() {
    EventBus().off('switch_pool');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverPersistentHeader,
          SliverToBoxAdapter(
            child: Stack(
              children: [
                LoadImage('kuangcixq_di_bg', fit: BoxFit.fill, width: double.infinity, height: ScreenUtil().setWidth(120)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenUtil().setWidth(200),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(16)),
                      decoration: BoxDecoration(color: ColorsUtil.hexColor(0xffffff), boxShadow: [BoxShadow(color: Color(0x0D000000), offset: Offset(0.1, 0.1), blurRadius: 3, spreadRadius: 3)], borderRadius: BorderRadius.all(Radius.circular(8))),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Text('${GlobalTransaction.getAssetsWalletInfo('THC')?.order_value ?? 0.0}', style: TextStyles.textBlack14),
                              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                              Text('可用余额(THC)', style: TextStyle(color: Colours.textGrey, fontSize: ScreenUtil().setSp(24))),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Text('${profit?.yesterday_profit ?? 0.0}', style: TextStyles.textBlack14),
                              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                              Text('昨日挖矿(THC)', style: TextStyle(color: Colours.textGrey, fontSize: ScreenUtil().setSp(22))),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Text('${profit?.total_award ?? 0.0}', style: TextStyles.textBlack14),
                              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                              Text('矿池总挖矿(THC)', style: TextStyle(color: Colours.textGrey, fontSize: ScreenUtil().setSp(24))),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.activation_miner_page).then((value) => getData());
                        },
                        child: Container(
                          margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                          child: Row(
                            children: [
                              LoadImage('ore_zr', width: ScreenUtil().setWidth(76)),
                              Gaps.hGap10,
                              Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('激活矿工', style: TextStyles.textBlack16),
                                ],
                              )),
                              Expanded(child: Container()),
                              Text('提前实现财富自由', style: TextStyles.textGrey12),
                              Gaps.hGap5,
                              LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                            ],
                          ),
                        )),
                    Container(margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)), color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                    InkWell(
                        onTap: () {
                          if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.ore_contribution_page).then((value) => getData());
                        },
                        child: Container(
                          margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                          child: Row(
                            children: [
                              LoadImage('ore_zc', width: ScreenUtil().setWidth(76)),
                              Gaps.hGap10,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('贡献展示', style: TextStyles.textBlack16),
                                ],
                              )),
                              Text('团队算力叠加', style: TextStyles.textGrey12),
                              Gaps.hGap5,
                              LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                            ],
                          ),
                        )),
                    Container(margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)), color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                    InkWell(
                        onTap: () {
                          if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.ore_data_page);
                        },
                        child: Container(
                          margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                          child: Row(
                            children: [
                              LoadImage('ore_zd', width: ScreenUtil().setWidth(76)),
                              Gaps.hGap10,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('矿池数据', style: TextStyles.textBlack16),
                                ],
                              )),
                              Text('时刻关注矿池数据变化', style: TextStyles.textGrey12),
                              Gaps.hGap5,
                              LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                            ],
                          ),
                        )),
                    Container(color: Colours.colorEE, height: ScreenUtil().setWidth(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(29), vertical: ScreenUtil().setWidth(34)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('最近一周收益(THC)', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                          Gaps.vGap15,
                          Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                            LoadImage('ore_zjsy', width: adaptationDp(30)),
                            Gaps.hGap5,
                            Text('最佳持币:', style: TextStyles.textBlack14.copyWith(color: Color(0xFF0B97E4))),
                            Text('${best_keep ?? 0.0}（TH+THC）', style: TextStyles.textWhite14.copyWith(color: Color(0xFF0B97E4))),
                          ]),
                          Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: [
                            Gaps.hGap30,
                            Gaps.hGap5,
                            Text('最低持币:', style: TextStyles.textBlack14.copyWith(color: Color(0xFF05C0B5))),
                            Text('${min_keep ?? 0.0}（TH+THC）', style: TextStyles.textWhite14.copyWith(color: Color(0xFF05C0B5))),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setWidth(500),
                      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      width: double.infinity,
                      child: logList.length == 0 ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220)) : LineChart(mainData()),
                    )
                  ],
                ),
                // detailData == null ? LayoutUtil.getLoadingShadeCustom(top: 200) : Container()
              ],
            ),
          )
        ],
      ),
    );
  }

  get buildSliverPersistentHeader {
    double expandedHeight = ScreenUtil().setWidth(230);
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
                      LoadImage('kuangcixq_bg', fit: BoxFit.fill, width: double.infinity, height: expandedHeight),
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
                                Center(child: Text('${GlobalTransaction.coin}矿池', style: TextStyle(color: makeStickyHeaderIconColor(shrinkOffset), fontSize: ScreenUtil().setSp(36)))),
                                // GestureDetector(
                                //   child: Container(
                                //     child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44), color: makeStickyHeaderIconColor(shrinkOffset)),
                                //     height: kToolbarHeight,
                                //     alignment: Alignment.centerLeft,
                                //   ),
                                //   onTap: () {
                                //     Navigator.of(context).pop();
                                //   },
                                //   behavior: HitTestBehavior.opaque,
                                // ),
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

  Color gradientColors = const Color(0xFF0B97E4);

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Color(0x1A000000), strokeWidth: 0.5);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.white, strokeWidth: 0.5);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (double value, TitleMeta meta) {
            return Text('${DateUtil.getDateStrByTimeStr(logList[value.toInt()].date, format: DateFormat.MONTH_DAY) + '\t\t\t\t'}', style: TextStyle(color: Color(0xFF97A2AF), fontSize: ScreenUtil().setSp(18)));
          },
        )),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (double value, TitleMeta meta) {
            return Text('${value.toInt().toString()}', style: TextStyle(color: Color(0xFF97A2AF), fontSize: ScreenUtil().setSp(10)));
          },
        )),
      ),
      borderData: FlBorderData(show: false, border: Border.all(color: Colors.white, width: 1)),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: logMax,
      lineBarsData: [
        LineChartBarData(
          spots: _buildData(),
          isCurved: false,
          color: gradientColors,
          barWidth: 1,
          isStrokeCapRound: false,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: true, color: gradientColors),
        ),
      ],
    );
  }

  List<FlSpot> _buildData() {
    List<FlSpot> data = [];
    if (logList == null) return data;
    if (logList.length != 0) for (int i = 0; i < logList.length; i++) data.add(FlSpot(i.toDouble(), double.parse(logList[i].award ?? '0.0')));
    return data;
  }

  getData({isLoading = false}) {
    if (SpUtil.hasKey('pool_detail_logList$currency')) {
      logList = SpUtil.getObjList('pool_detail_logList$currency', (v) => PooldetailLogList().fromJson(v));
      if (mounted) setState(() {});
    }
    if (SpUtil.hasKey('pool_detail_profit$currency')) {
      profit = SpUtil.getObj('pool_detail_profit$currency', (v) => Profit.fromJson(v));
      if (mounted) setState(() {});
    }
    if (isLoading) showLoadingContextDialog(context);
    Net().post(ApiTransaction.ORE_DETAIL, {'currency': currency}, success: (data) {
      if (isLoading) closeLoadingContextDialog(context);
      detailData = PooldetailEntity().fromJson(data);
      best_keep = data['best_keep'];
      min_keep = data['min_keep'];
      logList.clear();
      logList = detailData.logList;
      logList.forEach((element) {
        if (logMax == null)
          logMax = double.parse(element.award);
        else if (double.parse(element.award) > logMax) logMax = double.parse(element.award);
      });
      if (logMax != null && logMax != 0.0) logMax = logMax + (logMax * 0.1);
      SpUtil.putObjectList('pool_detail_logList$currency', logList);
      if (mounted) setState(() {});
    }, failure: (error) {
      showToast('$error');
      if (isLoading) closeLoadingContextDialog(context);
    });

    Net().post(ApiTransaction.PROFIT, {'currency': currency}, success: (data) {
      profit = Profit.fromJson(data);
      SpUtil.putObject('pool_detail_profit$currency', profit);

      if (mounted) setState(() {});
    });
  }
}
