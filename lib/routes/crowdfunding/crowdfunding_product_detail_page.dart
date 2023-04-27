import 'dart:async';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/wheel_detail_entity.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/num_util.dart';
import '../../models/product_detail_entity.dart';

//众筹分期详情
class CrowdFundingProductDetailPage extends StatefulWidget {
  final Bundle bundle;

  CrowdFundingProductDetailPage(this.bundle);

  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<CrowdFundingProductDetailPage> {
  RefreshController refreshController = RefreshController();
  int type = 0; //0即将开始 1火爆进行中 2圆满收官 3失败项目
  WheelDetailProductList wheelDetailProductList;
  List<ProductDetailEntity> productList = [];
  String now;
  String flashEndTime;
  Timer countDownTimer;
  String countDownSky = '00';
  String countDownHour = '00';
  String countDownHourMinute = '00';
  String countDownHourSecond = '00';

  // ignore: close_sinks
  StreamController<String> streamController = StreamController();

  @override
  void initState() {
    super.initState();
    wheelDetailProductList = widget.bundle.getObject('wheelDetailProductList');

    getData();
    EventBus().on('CrowdFundingDetail', ({arg}) {
      getData();
    });
  }
@override
  void dispose() {
  EventBus().off('CrowdFundingDetail');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, '${getString().zf23}'),
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: false,
          enablePullDown: true,
          onRefresh: () {
            getData();
          },
          onLoading: () {
            getData();
          },
          child: wheelDetailProductList == null
              ? LayoutUtil.getLoadingShadeCustom()
              : ListView(children: [
                  Container(
                      padding: EdgeInsets.all(adaptationDp(15)),
                      child: Row(
                        children: [
                          LoadImage('${wheelDetailProductList.icon}', width: adaptationDp(50)),
                          Gaps.hGap10,
                          Text('${getTitleCrowdFunding(wheelDetailProductList)}', style: TextStyles.textBlack18),
                          Expanded(child: Container()),
                          buildTypeStatus(),
                        ],
                      )),
                  Container(width: double.infinity, height: adaptationDp(10), color: Color(0xFFF3F3F3)),
                  Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().zf24}', style: TextStyles.textBlack15)),
                  Gaps.vGap5,
                  Padding(
                      padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(10)),
                      child: Row(
                        children: [
                          Text('${getString().xtj4}：', style: TextStyles.textGrey612),
                          Text('${wheelDetailProductList.total} ${wheelDetailProductList.currency.toUpperCase()}', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(10)),
                      child: Row(
                        children: [
                          Text('${getString().xtj5}：', style: TextStyles.textGrey612),
                          Text('${wheelDetailProductList.startTime}-${wheelDetailProductList.endTime}', style: TextStyles.textBlack12),
                        ],
                      )),
                  Container(width: double.infinity, height: adaptationDp(10), color: Color(0xFFF3F3F3)),
                  Gaps.vGap5,
                  Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().xtj34 + getString().xtj3}', style: TextStyles.textBlack15)),
                  listViewBuilder(
                      isSlide: true,
                      itemBuilder: (context, index) {
                        return buildList(index);
                      },
                      itemCount: productList.length),
                  Gaps.vGap30,
                ]),
        ));
  }

  buildList(index) {
    var indexData = productList[index];
    if (indexData.status == '0')
      return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
        inkButton(
          child: Container(
              margin: EdgeInsets.fromLTRB(adaptationDp(8), adaptationDp(4), adaptationDp(8), adaptationDp(4)),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('kuanciitem_bg')), fit: BoxFit.fill)),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(26), bottom: ScreenUtil().setWidth(18)),
              child: Column(
                children: [
                  Row(
                    children: [Gaps.hGap15, Text('${getString().zf55}${indexData.number}${getString().xtj34 + getString().zf56}', style: TextStyles.textBlack12)],
                  ),
                  Gaps.vGap5,
                  Container(
                      padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), top: adaptationDp(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LoadImage('${indexData.icon}', width: adaptationDp(25)),
                          Gaps.hGap10,
                          Text('${indexData.title.toUpperCase()}', style: TextStyles.textBlack15),
                          Expanded(child: Container()),
                          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end, children: [
                            Padding(
                                padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(5)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('${getString().zf37} ', style: TextStyles.textBlack12),
                                    Text('${indexData.total} ${indexData.currency.toUpperCase()}', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(10)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('${getString().zf38} ', style: TextStyles.textBlack12),
                                    Text('${indexData.totaled} ${indexData.currency.toUpperCase()}', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
                                  ],
                                )),
                          ]),
                        ],
                      )),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: adaptationDp(5), bottom: adaptationDp(15), left: adaptationDp(10), right: adaptationDp(10)),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - adaptationDp(50),
                      animation: true,
                      lineHeight: adaptationDp(8),
                      backgroundColor: Color(0xFFEAEAEA),
                      animationDuration: 1000,
                      padding: EdgeInsets.only(left: adaptationDp(4), right: adaptationDp(4)),
                      percent: double.parse((double.parse(indexData.totaled) / double.parse(indexData.total)).toString()),
                      barRadius: Radius.circular(adaptationDp(5)),
                      progressColor: Color(0xFF3250D4),
                    ),
                  ),
                  Row(children: [
                    Gaps.hGap15,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${getString().zf39} ', style: TextStyles.textBlack12),
                        Text('${NumUtil.formatNum((double.parse(indexData.totaled) / double.parse(indexData.total) * 100).toString(), 4)}%', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
                      ],
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${getString().zf40} ', style: TextStyles.textBlack12),
                        Text('${indexData.payMin}～${indexData.payMax}', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
                      ],
                    ),
                    Gaps.hGap15,
                  ]),
                  Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Lines.line),
                  Row(
                    children: [
                      Gaps.hGap10,
                      Expanded(
                          child: inkButton(
                              onPressed: () {
                                navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_detail_buy_page, bundle: Bundle()..putObject('productDetailEntity', indexData));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: Color(0xFF999999), width: 0.5)),
                                padding: EdgeInsets.only(left: adaptationDp(50), top: adaptationDp(5), bottom: adaptationDp(5), right: adaptationDp(50)),
                                alignment: Alignment.center,
                                child: Text('${getString().zf13}', style: TextStyles.textBlack12.copyWith(color: Color(0xFF999999))),
                              ))),
                      Gaps.hGap15,
                      Expanded(
                          child: indexData.status != '0'
                              ? Container()
                              : inkButton(
                                  onPressed: () {
                                    if (indexData.isBuy != '1')
                                      navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_detail_buy_page, bundle: Bundle()..putObject('productDetailEntity', indexData), onValue: (data) {
                                        getData();
                                      });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(color: indexData.isBuy == '1' ? Color(0xFF666666) : Color(0xFF3250D4), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: Color(0xFF3250D4), width: 0.5)),
                                    padding: EdgeInsets.only(left: adaptationDp(50), top: adaptationDp(5), bottom: adaptationDp(5), right: adaptationDp(50)),
                                    alignment: Alignment.center,
                                    child: Text(indexData.isBuy == '1' ? '${getString().xtj16}' : '${getString().zf12}', style: TextStyles.textWhite12),
                                  ))),
                      Gaps.hGap10,
                    ],
                  ),
                  Gaps.vGap15,
                ],
              )),
        )
      ]);
    else
      return inkButton(
          onPressed: () {
            navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_detail_buy_page, bundle: Bundle()..putObject('productDetailEntity', indexData));

            // navigatorContextPush(context, PageRouter.crowdfunding_record_page,
            //     bundle: Bundle()
            //       ..putString('product_id', indexData.productId)
            //       ..putString('title', getTitleCrowdFunding(indexData) + '【${getString().zf55}${indexData.number}${getString().zf56}】')
            //       ..putString('icon', indexData.icon));
          },
          child: Container(
            padding: EdgeInsets.only(top: adaptationDp(15), left: adaptationDp(15), right: adaptationDp(15)),
            child: Column(children: [
              Row(
                children: [
                  Text('${getString().zf55}${indexData.number}${getString().xtj34 + getString().zf56}', style: TextStyles.textBlack12),
                  Gaps.hGap5,
                  Text('${double.parse(indexData.totaled) / double.parse(indexData.total) * 100}%', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
                  Expanded(child: Container()),
                  LoadImage('y_break', width: adaptationDp(10)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: adaptationDp(5), bottom: adaptationDp(10)),
                alignment: Alignment.centerLeft,
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - adaptationDp(30),
                  animation: true,
                  lineHeight: adaptationDp(8),
                  backgroundColor: Color(0xFFEAEAEA),
                  animationDuration: 1000,
                  padding: EdgeInsets.zero,
                  percent: (double.parse(indexData.totaled) / double.parse(indexData.total)),
                  barRadius: Radius.circular(adaptationDp(5)),
                  progressColor: Color(0xFF3250D4),
                ),
              ),
              Lines.line,
              Gaps.vGap5,
            ]),
          ));
  }

  buildTypeStatus() {
    switch (wheelDetailProductList.raiseStatus) {
      case '-1':
        return Container(
          decoration: BoxDecoration(color: Color(0x1AF3A42F), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: Color(0xFFF3A42F), width: 0.5)),
          padding: EdgeInsets.only(left: adaptationDp(13), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(13)),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text('${getString().zf29}：', style: TextStyles.textBlack12), Text('${getString().zf30}', style: TextStyles.textBlack12.copyWith(color: Color(0xFFF3A42F)))],
          ),
        );
      case '0':
        return Container(
          decoration: BoxDecoration(color: Color(0x1AFE3937), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: Color(0xFFFE3937), width: 0.5)),
          padding: EdgeInsets.only(left: adaptationDp(13), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(13)),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text('${getString().zf31}：', style: TextStyles.textBlack12), Text('${getString().zf32}', style: TextStyles.textBlack12.copyWith(color: Color(0xFFFE3937)))],
          ),
        );
      case '1':
        return Container(
          decoration: BoxDecoration(color: Color(0x1A3250D4), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: Color(0xFF3250D4), width: 0.5)),
          padding: EdgeInsets.only(left: adaptationDp(13), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(13)),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text('${getString().zf33}：', style: TextStyles.textBlack12), Text('${getString().zf34}', style: TextStyles.textBlack12.copyWith(color: Color(0xFF3250D4)))],
          ),
        );
      case '2':
        return Container(
          decoration: BoxDecoration(color: Color(0x1A666666), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: Color(0xFF666666), width: 0.5)),
          padding: EdgeInsets.only(left: adaptationDp(13), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(13)),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text('${getString().zf35}：', style: TextStyles.textBlack12), Text('${getString().zf36}', style: TextStyles.textBlack12.copyWith(color: Color(0xFF666666)))],
          ),
        );
    }
  }

  getTitleCrowdFunding(data) {
    if (SpUtil.getString('locale') == 'zh') {
      return data.title;
    } else if (SpUtil.getString('locale') == 'en') {
      return data.titleEn;
    } else if (SpUtil.getString('locale') == 'ms') {
      return data.titleMs;
    } else if (SpUtil.getString('locale') == 'th') {
      return data.titleTh;
    } else
      return data.title;
  }

  buildPeriodList() {
    return;
  }

  buildCrowdFundingStatus() {
    switch (wheelDetailProductList.raiseStatus) {
      case '-1':
        return '${getString().zf46}';
      case '0':
        return '${getString().zf43}';
      case '1':
        return '${getString().zf44}';
      case '2':
        return '${getString().zf45}';
    }
  }

  void reverseTimeFunc(time) {
    if (time == null) return;
    if (countDownTimer != null) {
      countDownTimer.cancel();
      countDownTimer = null;
      countDownHour = "00";
      countDownHourMinute = "00";
      countDownHourSecond = "00";
    }
    var _newDate = DateTime.now();
    const period = const Duration(seconds: 1);
    var _diffDate = DateTime.parse(time);
    countDownTimer = Timer.periodic(period, (timer) {
      _diffDate = _diffDate.subtract(Duration(seconds: 1));
      if (_diffDate.difference(_newDate).inSeconds <= 0) {
        timer.cancel();
        timer = null;
        countDownHour = "00";
        countDownHourMinute = "00";
        countDownHourSecond = "00";
        streamController.sink.add(null);
        return;
      }
      var _surplus = _diffDate.difference(_newDate);
      int sky = (_surplus.inSeconds ~/ 86400);
      int hour;
      if (sky == 0)
        hour = (_surplus.inSeconds ~/ 3600);
      else
        hour = (_surplus.inSeconds ~/ 3600 ~/ 24);
      int minute = _surplus.inSeconds % 3600 ~/ 60;
      int second = _surplus.inSeconds % 60;
      countDownSky = sky.toString().length > 1 ? sky.toString() : '0' + hour.toString();
      countDownHour = hour.toString().length > 1 ? hour.toString() : '0' + hour.toString();
      countDownHourMinute = minute.toString().length > 1 ? minute.toString() : '0' + minute.toString();
      countDownHourSecond = second.toString().length > 1 ? second.toString() : '0' + second.toString();

      streamController.sink.add(null);
    });
  }

  getData({isShow = false}) {
    if (isShow) showLoadingContextDialog(context);
    Net().post(ApiTransaction.fund_product_detail, {'product_id': wheelDetailProductList.productId}, success: (data) {
      refreshController.refreshCompleted();
      if (isShow) closeLoadingContextDialog(context);
      productList.clear();

      data['zoom_list'].forEach((v) {
        productList.add(ProductDetailEntity().fromJson(v));
      });
      // reverseTimeFunc(wheelDetailProductList.endTime);
      if (mounted) setState(() {});
    }, failure: (error) {
      refreshController.refreshCompleted();
      if (isShow) closeLoadingContextDialog(context);
    });
  }
}
