import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/http/api.dart';
import 'package:mars/common/http/net.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:mars/models/trustHistory.dart';
import 'package:mars/models/trust_bean.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/empty_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrustListPage extends StatefulWidget {
  final String type;

  TrustListPage(this.type);

  @override
  _TrustListPageState createState() => _TrustListPageState();
}

class _TrustListPageState extends State<TrustListPage> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool loading = true;
  List<dynamic> trustDatas = [];
  PagingLoad pagingLoad = PagingLoad();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    pagingLoad.reset();
    getData();
  }

  void _onLoading() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? LayoutUtil.getLoadingShadeCustom()
        : SmartRefresher(
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: _buildList(),
          );
  }

  _buildList() {
    if (trustDatas.length == 0) {
      return EmptyView('${getString().zwsj}');
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(36), horizontal: ScreenUtil().setWidth(30)),
      itemBuilder: widget.type == '${getString().qbwt}' ? _buildTruRow : _buildHisRow,
      itemCount: trustDatas.length,
    );
  }

  Widget _buildTruRow(BuildContext context, int index) {
    TrustData trustData = trustDatas[index];
    return Column(
      children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${trustData.direction == null || trustData.direction.contains('sell') ? '${getString().mc}' : '${getString().mr}'}${trustData.takerpaysCurrency}/${trustData.takergetsCurrency}',
                    style: TextStyle(color: trustData.direction == null || trustData.direction.contains('sell') ? Colours.colorFFFFEDF0 : Colours.colorFFDAFFF5, fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(28))),
                Text(DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(trustData.orderOrigTime ?? '0') * 1000).toString()), style: TextStyles.textGrey12)
              ],
            ),
            Row(
              children: [
                Text('${trustData.orderStatusStr}', style: TextStyles.textGrey11),
                Gaps.hGap5,
                InkResponse(
                    onTap: () {
                      offerDel(trustData.tid);
                    },
                    child: trustData.orderStatus == 'chainFail' || trustData.orderStatus == 'validateFail'
                        ? Container(
                      decoration: BoxDecoration(color: ColorsUtil.hexColor(0xcB98E40, alpha: 0.09), borderRadius: BorderRadius.all(Radius.circular(4))),
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setWidth(50),
                      alignment: Alignment.center,
                      child: Text('${getString().scc}', style: TextStyle(color: Colours.colorFFC939F3, fontSize: ScreenUtil().setSp(24))),
                    )
                        : Container()),
                InkResponse(
                    onTap: () {
                      offerCancel(trustData.hash);
                    },
                    child: trustData.hash == null
                        ? Container()
                        : Container(
                      decoration: BoxDecoration(color: ColorsUtil.hexColor(0xcB98E40, alpha: 0.09), borderRadius: BorderRadius.all(Radius.circular(4))),
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setWidth(50),
                      alignment: Alignment.center,
                      child: Text('${getString().cxx}', style: TextStyle(color: Colours.colorFFC939F3, fontSize: ScreenUtil().setSp(24))),
                    ))
              ],
            )
          ],
        ),
        SizedBox(height: ScreenUtil().setWidth(34)),
        Row(
          children: [
            Expanded(
              child: Text('${getString().wtjg}(${trustData.direction.contains('sell') ? trustData.takerpaysCurrency:trustData.takergetsCurrency})', style: TextStyles.textB4B4B424),
            ),
            Expanded(
                child: Text(
                  '${getString().wtsl}(${trustData.direction.contains('sell') ? trustData.takergetsCurrency:trustData.takerpaysCurrency})',
                  style: TextStyles.textB4B4B424,
                  textAlign: TextAlign.center,
                )),
            Expanded(
              child: Text('${getString().sjcg}(${trustData.direction.contains('sell') ? trustData.takergetsCurrency:trustData.takerpaysCurrency})', style: TextStyles.textB4B4B424, textAlign: TextAlign.right),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setWidth(24)),
        Row(
          children: [
            Expanded(
              child: Text(trustData.price, style: TextStyles.textBlack14),
            ),
            Expanded(
                child: Text(
                  trustData.amount,
                  style: TextStyles.textBlack14,
                  textAlign: TextAlign.center,
                )),
            Expanded(
              child: Text(trustData.amountSuc, style: TextStyles.textBlack14, textAlign: TextAlign.right),
            ),
          ],
        ),
        Gaps.vGap10,
        Container(
          color: Colours.colorEE,
          height: ScreenUtil().setWidth(1),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        ),
      ],
    );
  }

  Widget _buildHisRow(BuildContext context, int index) {
    bool isType = widget.type.contains('${getString().lsjl}');
    var trustData = trustDatas[index];

    String statusTip = '${getString().bfcgrhqx}';
    if (trustData == null) return Container();
    if (isType) {
      if (trustData.order_status == '0') {
        statusTip = '${getString().bfcj}';
      } else {
        statusTip = '${getString().wqcj}';
      }
    } else if (trustData.orderStatus == null) {
      statusTip = '';
    } else if (trustData.orderStatus.contains('triggered')) {
      statusTip = '${getString().guadan}';
    } else if (trustData.orderStatus.contains('partDeal')) {
      statusTip = '${getString().bfcj}';
    } else if (trustData.orderStatus.contains('deal')) {
      statusTip = '${getString().wqcj}';
    } else if (trustData.orderStatus.contains('canceled')) {
      statusTip = '${getString().qx}';
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text('${trustData.direction.contains('sell') ? '${getString().mc}' : '${getString().mr}'} ${trustData.direction.contains('sell') ? (trustData.market1 + '/' + trustData.market2) : (trustData.market2 + '/' + trustData.market1)}',

            Text(
                isType
                    ? '${trustData.direction.contains('sell') ? '${getString().mc}' : '${getString().mr}'}${trustData.market1}/${trustData.market2}'
                    : '${trustData.direction.contains('sell') ? '${getString().mc}' : '${getString().mr}'}${trustData.takergetsCurrency}/${trustData.takerpaysCurrency}',
                style: TextStyle(color: trustData.direction.contains('sell') ? Colours.colorFFFFEDF0 : Colours.colorFFDAFFF5, fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.bold)),
            Text(statusTip, style: TextStyles.textBlack13)
          ],
        ),
        SizedBox(height: ScreenUtil().setWidth(37)),
        Row(
          children: [
            Expanded(
              child: Text('${getString().sj}', style: TextStyles.textB4B4B424),
            ),
            Expanded(
                child: Text(
                  '${getString().wtjg}(${trustData.market2})',
                  style: TextStyles.textB4B4B424,
                  textAlign: TextAlign.center,
                )),
            Expanded(
              child: Text('${getString().wtsl}(${trustData.market1})', style: TextStyles.textB4B4B424, textAlign: TextAlign.right),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setWidth(24)),
        Row(
          children: [
            Expanded(
              child: Text(
                  isType
                      ? DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(trustData.ts) * 1000).toString(), format: 'MM/dd HH:mm')
                      : trustData.orderOrigTime == null
                      ? ''
                      : DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(trustData.orderOrigTime) * 1000).toString(), format: 'MM/dd HH:mm'),
                  style: TextStyles.textBlack14),
            ),
            Expanded(
                child: Text(
                  '${isType ? trustData.prev_unit_price : trustData.price ?? 0.0}',
                  style: TextStyles.textBlack14,
                  textAlign: TextAlign.center,
                )),
            Expanded(
              child: Text(isType ? trustData.prev_amount_sum : trustData.amount, style: TextStyles.textBlack14, textAlign: TextAlign.right),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setWidth(34)),
        Row(
          children: [
            Expanded(
              child: Text('${getString().cjze}(${isType ? trustData.market2 : trustData.takerpaysCurrency})', style: TextStyles.textB4B4B424),
            ),
            Expanded(
                child: Text(
                  '${getString().cjjj}(${isType ? trustData.market2 : trustData.takerpaysCurrency})',
                  style: TextStyles.textB4B4B424,
                  textAlign: TextAlign.center,
                )),
            Expanded(
              child: Text('${getString().cjl}(${isType ? trustData.market1 : trustData.takerpaysCurrency})', style: TextStyles.textB4B4B424, textAlign: TextAlign.right),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setWidth(24)),
        Row(
          children: [
            Expanded(
              child: Text('${isType ? trustData.total_amount : trustData.priceSuc ?? 0.0}', style: TextStyles.textBlack14),
            ),
            Expanded(
                child: Text(
                  '${isType ? trustData.unitPrice : trustData.sucUnitPrice ?? 0.0}',
                  style: TextStyles.textBlack14,
                  textAlign: TextAlign.center,
                )),
            Expanded(
              child: Text('${isType ? trustData.amount_sum : trustData.amountSuc ?? 0.0}', style: TextStyles.textBlack14, textAlign: TextAlign.right),
            ),
          ],
        ),
        Gaps.vGap10,
        Container(
          color: Colours.colorEE,
          height: ScreenUtil().setWidth(1),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        ),
      ],
    );
  }

  String lsOfferSequence = '';

//取消挂单
  offerCancel(transaction) {
    LayoutUtil.showLoadingDialog(context, msg: '${getString().cdz}');
    Net().post(ApiTransaction.CHAIN_OFFER_CANCEL, {'hash': transaction}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      _onRefresh();
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().cdcg}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }

  //删除挂单
  offerDel(transaction) {
    LayoutUtil.showLoadingDialog(context, msg: '${getString().scz}');
    Net().post(ApiTransaction.ORDER_HIDE, {'tid': transaction}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      _onRefresh();
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().sccg}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }

  void getData() {
    Map<String, String> mapTmp = pagingLoad.getMapPagingLoad();
    mapTmp['account'] = GlobalTransaction.walletInfo.account_id;
    if (widget.type.contains('${getString().qbwt}')) {
      mapTmp['orderStatus'] = 'triggered';
    }
    Net().post(widget.type.contains('${getString().qbwt}') ? ApiTransaction.TRUST_LIST : ApiTransaction.ORDER_HISTORY, mapTmp, success: (data) {
      List listTmp;
      if (widget.type.contains('${getString().qbwt}'))
        listTmp = data['list'];
      else
        listTmp = data;
      if (listTmp != null) {
        if (pagingLoad.isCurrPage() && listTmp.length > 0) {
          trustDatas.clear();
          listTmp?.forEach((v) {
            if (widget.type.contains('${getString().qbwt}'))
              trustDatas.add(new TrustData.fromJson(v));
            else
              trustDatas.add(new TrustHistory.fromJson(v));
          });
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        } else if (listTmp.length > 0) {
          listTmp?.forEach((v) {
            if (widget.type.contains('${getString().qbwt}'))
              trustDatas.add(new TrustData.fromJson(v));
            else
              trustDatas.add(new TrustHistory.fromJson(v));
          });
          _refreshController.loadComplete();
        } else {
          pagingLoad.reduce();
          _refreshController.loadNoData();
        }
      } else {
        pagingLoad.reduce();
      }
      if (mounted)
        setState(() {
          loading = false;
        });
    }, failure: (e) {
      if (mounted)
        setState(() {
          loading = false;
        });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
