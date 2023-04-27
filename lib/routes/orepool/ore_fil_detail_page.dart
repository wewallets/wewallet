import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/http/api.dart';
import 'package:mars/common/http/net.dart';
import 'package:mars/common/router/bundle.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/pool_details_entity.dart';
import 'package:mars/models/pool_fil_detail_entity.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OreFilDetailPage extends StatefulWidget {
  final Bundle bundle;

  OreFilDetailPage(this.bundle);

  @override
  _OreFilDetailPageState createState() => _OreFilDetailPageState();
}

class _OreFilDetailPageState extends State<OreFilDetailPage> {
  String currenCy;

  PoolFilDetailEntity detailData;
  List<PoolFilDetailLogList> logList = [];
  double logMax;

  @override
  void initState() {
    super.initState();
    currenCy = widget.bundle.getString('currenCy');
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverPersistentHeader,
          SliverToBoxAdapter(
            child: Stack(
              children: [
                LoadImage('kuangcixq_di_bg', fit: BoxFit.fill, width: double.infinity, height: ScreenUtil().setWidth(100)),
                detailData == null
                    ? LayoutUtil.getLoadingShadeCustom(top: 200)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: ScreenUtil().setWidth(150),
                            margin: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(16)),
                            decoration: BoxDecoration(color: ColorsUtil.hexColor(0xffffff), boxShadow: [BoxShadow(color: Color(0x1A000000), offset: Offset(0.1, 0.1), blurRadius: 2.0, spreadRadius: 2.0)], borderRadius: BorderRadius.all(Radius.circular(8))),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Container(
                              height: ScreenUtil().setWidth(84),
                              width: adaptationDp(280),
                              child: logList.length == 0 ? Container() : LineChart(mainData()),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(adaptationDp(15)),
                            margin: EdgeInsets.all(adaptationDp(15)),
                            decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Column(children: [
                              Row(children: [
                                CircularPercentIndicator(
                                  progressColor: Color(0xFFFAC10B),
                                  backgroundColor: Color(0xFFFFFBEE),
                                  radius: 64.0,
                                  animationDuration: 1000,
                                  lineWidth: 7.5,
                                  animation: true,
                                  percent: (double.parse(detailData.filPoolTlevelPercen) / 100),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text('${getString().pooltxt18}', style: TextStyles.textGrey10),
                                    Text('${detailData.filPoolTlevelPercen}%', style: TextStyle(fontSize: adaptationDpSp(15), color: Color(0xFFFAC10B))),
                                  ]),
                                ),
                                Gaps.hGap30,
                                Expanded(
                                    child: Container(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text('${getString().pooltxt19}', style: TextStyles.textGrey12),
                                  Text('${detailData.filPoolRealTlevel}T', style: TextStyles.textBlack15),
                                ]))),
                                Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [Container(height: adaptationDp(25), width: 0.5, color: Color(0xFFDFDFDF))])),
                                Expanded(
                                    child: Container(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                  Text('${getString().pooltxt20}', style: TextStyles.textGrey12),
                                  Text('${detailData.filPoolTlevel}T', style: TextStyles.textBlack15),
                                ]))),
                                Gaps.hGap30,
                              ]),
                              Gaps.vGap15,
                              Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                              Gaps.vGap15,
                              Row(children: [
                                CircularPercentIndicator(
                                  progressColor: Color(0xFF4A5BC9),
                                  backgroundColor: Color(0xFFECEFFF),
                                  radius: 64.0,
                                  animationDuration: 1000,
                                  lineWidth: 7.5,
                                  animation: true,
                                  percent: (double.parse(detailData.filPoolReleasePercen) / 100),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text('${getString().pooltxt18}', style: TextStyles.textGrey10),
                                    Text('${detailData.filPoolReleasePercen}%', style: TextStyle(fontSize: adaptationDpSp(15), color: Color(0xFF4A5BC9))),
                                  ]),
                                ),
                                Gaps.hGap30,
                                Expanded(
                                    child: Container(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text('${getString().pooltxt21}', style: TextStyles.textGrey12),
                                  Text('${NumUtil.formatNum(detailData.filPoolReleaseTotal, 2).toString()}', style: TextStyles.textBlack12),
                                ]))),
                                Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [Container(height: adaptationDp(25), width: 0.5, color: Color(0xFFDFDFDF))])),
                                Expanded(
                                    child: Container(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                  Text('${getString().pooltxt22}', style: TextStyles.textGrey12),
                                  Text('${NumUtil.formatNum(detailData.filPoolTotal, 2).toString()}', style: TextStyles.textBlack12),
                                ]))),
                                Gaps.hGap30,
                              ]),
                            ]),
                          ),
                        ],
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  get buildSliverPersistentHeader {
    double expandedHeight = ScreenUtil().setWidth(400);
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
                      (ScreenUtil().setWidth(210) - shrinkOffset) > 0
                          ? Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil().setWidth(120 - shrinkOffset), left: adaptationDp(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${getString().pooltxt23}($currenCy)', style: TextStyle(color: ColorsUtil.hexColor(0xffffff, alpha: 0.7), fontSize: ScreenUtil().setSp(24))),
                                    Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(16))),
                                    Text('${detailData?.filPoolTotal ?? '0.0'}', style: TextStyle(color: Colours.white, fontSize: ScreenUtil().setSp(76))),
                                    Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                      Text('${getString().pooltxt24}($currenCy)', style: TextStyle(color: ColorsUtil.hexColor(0xffffff, alpha: 0.7), fontSize: ScreenUtil().setSp(24))),
                                      Gaps.hGap5,
                                      Text('${detailData?.assetsFil ?? '0.0'}', style: TextStyle(color: Colours.white, fontSize: ScreenUtil().setSp(24))),
                                      Gaps.hGap30,
                                      Text('${getString().pooltxt25}', style: TextStyle(color: ColorsUtil.hexColor(0xffffff, alpha: 0.7), fontSize: ScreenUtil().setSp(24))),
                                      Gaps.hGap5,
                                      Text('${detailData?.x7daysAward ?? '0.0'}', style: TextStyle(color: Colours.white, fontSize: ScreenUtil().setSp(24))),
                                    ]),
                                  ],
                                ),
                              ))
                          : Container(),
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
                                Center(
                                  child: Text('${getString().pooltxt26}', style: TextStyle(color: makeStickyHeaderIconColor(shrinkOffset), fontSize: ScreenUtil().setSp(36))),
                                ),
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

  Color  gradientColors = const Color(0xFF1635BB);

  LineChartData mainData() {
    return LineChartData(
      minX: 0,
      maxX: 0,
      minY: 0,
      maxY: logMax,
      borderData: FlBorderData(show: false, border: Border.all(color: Colors.white, width: 1)),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles:  AxisTitles(
    sideTitles: SideTitles(showTitles: false)),
        rightTitles:  AxisTitles(
    sideTitles: SideTitles(showTitles: false)),
      ),
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
    if (logList.length != 0) for (int i = 0; i < logList.length; i++) data.add(FlSpot(i.toDouble(), double.parse(logList[i].award)));
    return data;
  }

  getData() {
    Net().post(ApiTransaction.ORE_DETAIL, {"currency": '$currenCy', 'account': GlobalTransaction.walletInfo.account_id}, success: (data) {
      detailData = PoolFilDetailEntity().fromJson(data);
      logList.clear();
      logList = detailData.logList;
      logList.forEach((element) {
        if (logMax == null)
          logMax = double.parse(element.award);
        else if (double.parse(element.award) > logMax) logMax = double.parse(element.award);
      });
      if (logMax != null && logMax != 0.0) logMax = logMax + (logMax * 0.1);
      setState(() {});
    });
  }
}
