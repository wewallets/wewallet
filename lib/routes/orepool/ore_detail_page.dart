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
import 'package:mars/models/oredetail_bean.dart';
import 'package:mars/models/pool_details_entity.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';

class OreDetailPage extends StatefulWidget {
  final Bundle bundle;

  OreDetailPage(this.bundle);

  @override
  _OreDetailPageState createState() => _OreDetailPageState();
}

class _OreDetailPageState extends State<OreDetailPage> {
  String currenCy;

  PoolDetailsEntity detailData;
  List<PoolDetailsLogList> logList = [];
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenUtil().setWidth(150),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(16)),
                      decoration: BoxDecoration(color: ColorsUtil.hexColor(0xffffff), boxShadow: [BoxShadow(color: Color(0x1A000000), offset: Offset(0.1, 0.1), blurRadius: 2.0, spreadRadius: 2.0)], borderRadius: BorderRadius.all(Radius.circular(8))),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Text('${detailData == null ? '' : detailData?.processAward ?? '0.0'}', style: TextStyles.textBlack20),
                              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                              Text('${getString().pooltxt12}', style: TextStyle(color: Colours.colorFF757CB2, fontSize: ScreenUtil().setSp(24)))
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                          Container(
                            color: ColorsUtil.hexColor(0x000000, alpha: 0.1),
                            width: ScreenUtil().setWidth(2),
                            height: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${detailData == null ? '0.0' : detailData?.populAward ?? '0.0'}', style: TextStyles.textBlack20),
                              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                              Text('${getString().pooltxt13}', style: TextStyle(color: Colours.colorFF757CB2, fontSize: ScreenUtil().setSp(24)))
                            ],
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('${getString().pooltxt5}', style: TextStyle(color: Colours.colorFF9895A0, fontSize: ScreenUtil().setSp(24))), Text('${detailData == null ? '' : detailData.risePoolBestLimit} $currenCy', style: TextStyles.textBlack14)],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      color: Colours.colorEE,
                      height: ScreenUtil().setWidth(1),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('${getString().pooltxt6}', style: TextStyle(color: Colours.colorFF9895A0, fontSize: ScreenUtil().setSp(24))), Text('${detailData == null ? '' : detailData.risePoolMinKeep} $currenCy', style: TextStyles.textBlack14)],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      color: Colours.colorEE,
                      height: ScreenUtil().setWidth(1),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('${getString().pooltxt14}', style: TextStyle(color: Colours.colorFF9895A0, fontSize: ScreenUtil().setSp(24))), Text('${detailData == null ? '' : detailData.totalAward} $currenCy', style: TextStyles.textBlack14)],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      color: Colours.colorEE,
                      height: ScreenUtil().setWidth(1),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                      height: ScreenUtil().setWidth(96),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('${getString().pooltxt15}', style: TextStyle(color: Colours.colorFF9895A0, fontSize: ScreenUtil().setSp(24))),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          LoadAssetImage('kgsff', height: adaptationDp(20)),
                        ])
                      ]),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                    //   color: Colours.colorEE,
                    //   height: ScreenUtil().setWidth(1),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                    //   height: ScreenUtil().setWidth(96),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text('收益详情', style: TextStyle(color: Colours.colorFF9895A0, fontSize: ScreenUtil().setSp(24))),
                    //       InkWell(
                    //           onTap: () {
                    //             Navigator.pushNamed(context, PageRouter.income_details_page);
                    //           },
                    //           child: Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Text('查看明细', style: TextStyle(color: Color(0xFFB4B4B4), fontSize: ScreenUtil().setSp(28))),
                    //               LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                    //             ],
                    //           ))
                    //     ],
                    //   ),
                    // ),
                    Container(color: Colours.colorEE, height: ScreenUtil().setWidth(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(29), vertical: ScreenUtil().setWidth(34)),
                      child: Text('${getString().pooltxt16}(${currenCy})', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: ScreenUtil().setWidth(500),
                      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      width: double.infinity,
                      child: logList.length == 0 ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220)) : LineChart(mainData()),
                    )
                  ],
                ),
                detailData == null ? LayoutUtil.getLoadingShadeCustom(top: 200) : Container()
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
                                padding: EdgeInsets.only(top: ScreenUtil().setWidth(120 - shrinkOffset)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${getString().pooltxt17}($currenCy)', style: TextStyle(color: ColorsUtil.hexColor(0xffffff, alpha: 0.7), fontSize: ScreenUtil().setSp(24))),
                                    Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(16))),
                                    Text('${detailData?.totalAwardYesterday ?? '0.0'}', style: TextStyle(color: Colours.white, fontSize: ScreenUtil().setSp(76))),
                                    Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                                    Text('≈ \$ ${detailData?.totalAwardYesterdayUsdt ?? '0.0'}', style: TextStyle(color: Colours.white, fontSize: ScreenUtil().setSp(28)))
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
                                  child: Text('$currenCy${getString().kc}', style: TextStyle(color: makeStickyHeaderIconColor(shrinkOffset), fontSize: ScreenUtil().setSp(36))),
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

  Color gradientColors = const Color(0xFF1635BB);

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
    if (logList.length != 0) for (int i = 0; i < logList.length; i++) data.add(FlSpot(i.toDouble(), double.parse(logList[i].award)));
    return data;
  }

  getData() {
    Net().post(ApiTransaction.ORE_DETAIL, {"currency": '$currenCy', 'account': GlobalTransaction.walletInfo.account_id}, success: (data) {
      detailData = PoolDetailsEntity().fromJson(data);
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
