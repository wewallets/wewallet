import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/http/api.dart';
import 'package:mars/common/http/net.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:mars/models/index.dart';
import 'package:mars/models/poolinfo_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//矿池数据
class OreDataPage extends StatefulWidget {
  @override
  _OreDataPageState createState() => _OreDataPageState();
}

class _OreDataPageState extends State<OreDataPage> with TickerProviderStateMixin {
  RefreshController refreshController = RefreshController();

  String currency = 'THC';

  PoolinfoEntity profit;
  PagingLoad pagingLoad = PagingLoad();
  List<UserLedger> _allList = [];

  @override
  void initState() {
    super.initState();
    getData();
    getLedger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutUtil.getAppBar(context, '矿池数据'),
      backgroundColor: Colours.background,
      body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: true,
          onRefresh: () {
            pagingLoad.reset();
            getData();
            getLedger();
          },
          onLoading: () {
            getLedger();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: ScreenUtil().setWidth(200),
                          margin: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(16), top: adaptationDp(10)),
                          decoration: BoxDecoration(color: Color(0xFF05C0B5), boxShadow: [BoxShadow(color: Color(0x0D000000), offset: Offset(0.1, 0.1), blurRadius: 3, spreadRadius: 3)], borderRadius: BorderRadius.all(Radius.circular(8))),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Text('${profit?.totalAward ?? 0.0}', style: TextStyles.textWhite18),
                                  Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                                  Text('矿工总挖出(THC)', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: ScreenUtil().setSp(22))),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              )),
                              Container(color: Color(0x4dF5F5F5), height: adaptationDp(50), width: adaptationDp(0.5)),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text('${profit?.totalDestroy ?? 0.0}', style: TextStyles.textWhite18),
                                  Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(14))),
                                  Text('总销毁', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: ScreenUtil().setSp(22))),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              )),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                              child: Row(
                                children: [
                                  LoadImage('ore_ztcc', width: ScreenUtil().setWidth(76)),
                                  Gaps.hGap10,
                                  Container(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('昨日挖出(THC)', style: TextStyles.textBlack16),
                                    ],
                                  )),
                                  Expanded(child: Container()),
                                  Text('${profit?.yesterdayAward ?? 0.0}', style: TextStyles.textGrey12),
                                  Gaps.hGap5,
                                ],
                              ),
                            )),
                        Container(margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)), color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                              child: Row(
                                children: [
                                  LoadImage('ore_ztxh', width: ScreenUtil().setWidth(76)),
                                  Gaps.hGap10,
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('昨日销毁(THC)', style: TextStyles.textBlack16),
                                    ],
                                  )),
                                  Text('${profit?.yesterdayDestroy ?? 0.0}', style: TextStyles.textGrey12),
                                  Gaps.hGap5,
                                ],
                              ),
                            )),
                        Container(margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)), color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                              child: Row(
                                children: [
                                  LoadImage('ore_kjlx', width: ScreenUtil().setWidth(76)),
                                  Gaps.hGap10,
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('矿机类型', style: TextStyles.textBlack16),
                                    ],
                                  )),
                                  Text('THC矿机', style: TextStyles.textGrey12),
                                  Gaps.hGap5,
                                ],
                              ),
                            )),
                        Container(margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)), color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                              child: Row(
                                children: [
                                  LoadImage('ore_dqgd', width: ScreenUtil().setWidth(76)),
                                  Gaps.hGap10,
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('当前区块链高度', style: TextStyles.textBlack16),
                                    ],
                                  )),
                                  Text('${profit?.ledgerIndex ?? 0.0}', style: TextStyles.textGrey12),
                                  Gaps.hGap5,
                                ],
                              ),
                            )),
                        Container(color: Colours.colorEE, height: ScreenUtil().setWidth(16)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(29), vertical: ScreenUtil().setWidth(34)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('矿池收益记录', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        _allList.length == 0 || pagingLoad.loading
                            ? pagingLoad.loading
                                ? LayoutUtil.getLoadingShadeCustom()
                                : LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                            : listViewBuilder(
                                itemCount: _allList.length,
                                isSlide: true,
                                padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(15)),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: adaptationDp(15)),
                                        child: Row(
                                          children: [
                                            Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                              Text('${_allList[index].reward_type_str}', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                                              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(16))),
                                              Text(_allList[index].tx_time == null ? '' : DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(_allList[index].tx_time) * 1000).toString(), format: 'yyyy-MM-dd HH:mm:ss'),
                                                  style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24)))
                                            ]),
                                            Expanded(child: Container()),
                                            Text('${_allList[index].amount} THC', style: TextStyles.textTheme14),
                                          ],
                                        ),
                                      ),
                                      Gaps.vGap15,
                                      Divider(height: 0, color: Colours.colorEE),
                                    ],
                                  );
                                })
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  getData({isLoading = false}) {
    if (SpUtil.hasKey('poolinfo$currency')) {
      profit = SpUtil.getObj('poolinfo$currency', (v) => PoolinfoEntity().fromJson(v));
      if (mounted) setState(() {});
    }
    if (isLoading) showLoadingContextDialog(context);

    Net().post(ApiTransaction.MPOOL_POOLINFO, {'currency': currency}, success: (data) {
      profit = PoolinfoEntity().fromJson(data);
      SpUtil.putObject('poolinfo$currency', profit);

      if (mounted) setState(() {});
    });
  }

  getLedger() {
    var map = pagingLoad.getMapPagingLoad();
    map['type'] = '1';

    Net().post(ApiTransaction.USDER_LEDGER, map, success: (data) {
      pagingLoad.loading = false;
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        _allList.clear();
        data['list'].forEach((element) {
          _allList.add(UserLedger.fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          _allList.add(UserLedger.fromJson(element));
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
