import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/dateUtil.dart';
import '../../common/utils/pagingLoadNow.dart';
import '../../common/whiteBase/base_state.dart';
import '../../models/fund_assets_log_entity.dart';
import '../../models/swap_order_list_entity.dart';

class OrderLedgerSwapPage extends StatefulWidget {
  final Bundle bundle;

  OrderLedgerSwapPage(this.bundle);

  @override
  _OrderLedgerSwapPageState createState() => _OrderLedgerSwapPageState();
}

class _OrderLedgerSwapPageState extends BaseState<OrderLedgerSwapPage> {
  RefreshController refreshController = RefreshController();
  List<SwapOrderListEntity> _allList = [];
  PagingLoadNew pagingLoad = PagingLoadNew();
  int type;
  String coin = 'USDT';

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null) {
      coin = widget.bundle.getString('coin');
    }
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget get appBar => getAppBar('${s.text78}', actions: <Widget>[
        inkButton(
          onPressed: () {
            showSelect();
          },
          child: Text('$coin', style: TextStyles.textBlack14),
        ),
        Gaps.hGap15,
      ]);

  @override
  Widget buildContent(BuildContext context) {
    return !pagingLoad.errorNullData
        ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
        : SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: () {
              getData(isFirstPage: true);
            },
            onLoading: () {
              getData();
            },
            child: !pagingLoad.errorNullData
                ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                : _allList.length == 0
                    ? buildLoadingShadeCustom()
                    : Column(children: [
                        Gaps.vGap12,
                        Row(children: [
                          Expanded(child: Container(alignment: Alignment.center, child: Text('${s.text50}', style: TextStyles.textGrey12))),
                          Expanded(child: Container(alignment: Alignment.center, child: Text('${s.text51}', style: TextStyles.textGrey12))),
                          Expanded(child: Container(alignment: Alignment.center, child: Text('${s.text52}', style: TextStyles.textGrey12))),
                        ]),
                        Expanded(child: listViewBuilder(itemCount: _allList.length, itemBuilder: (context, index) => _itemView(index))),
                      ]));
  }

  _itemView(int index) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(12)),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFFFFFFFF)),
          padding: EdgeInsets.only(bottom: dp(12), top: dp(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(child: Container(alignment: Alignment.center, child: Text('${_allList[index].payAmount}', style: TextStyles.textBlack15))),
                Expanded(child: Container(alignment: Alignment.center, child: Text('${_allList[index].productCurrPrice ?? 0}', style: TextStyles.textBlack15))),
                Expanded(child: Container(alignment: Alignment.center, child: Text('${_allList[index].exAmount}', style: TextStyles.textBlack15))),
              ]),
              Container(width: double.infinity, height: 0.5, color: Colours.textGrey, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
              Row(children: [
                Gaps.hGap12,
                Text('${_allList[index].createTime}', style: TextStyles.textGrey12),
                Expanded(child: Container()),
                _allList[index].status == '0'
                    ? inkButton(
                        child: Text('${s.text75}', style: TextStyles.textGrey12.copyWith(color: Color(0xFFF7B500))),
                        onPressed: () {
                          orderCancel(index);
                        })
                    : Container(),
                Gaps.hGap30,
                Text('${_allList[index].logStr}', style: TextStyles.textGrey12.copyWith(color: _allList[index].status == '0' ? Color(0xFFE74561) : Color(0xFF999999))),
                Gaps.hGap12,
              ]),
            ],
          ),
        ),
      ],
    );
  }

  showSelect() {
    List<String> list = [];
    for (int i = 0; i < GlobalTransaction.swapProductListData.downCurrencyArr.length; i++) list.add(GlobalTransaction.swapProductListData.downCurrencyArr[i]);
    for (int i = 0; i < GlobalTransaction.swapProductListData.upCurrencyArr.length; i++) list.add(GlobalTransaction.swapProductListData.upCurrencyArr[i]);

    Pickers.showSinglePicker(context, data: list, selectData: coin, onConfirm: (p) {
      coin = p;
      setState(() {});
      getData(isFirstPage: true);
    });
  }

  orderCancel(index) {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.swap_order_cancel, {'order_id': _allList[index].orderId}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      getData(isFirstPage: true);
      GlobalTransaction.refreshWalletAssets();
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    map['pay_currency'] = coin;
    pagingLoad.request(
        url: ApiTransaction.swap_order_list,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          _allList.clear();
          data.forEach((itemJson) {
            _allList.add(SwapOrderListEntity().fromJson(itemJson));
          });
        },
        nextPage: (data) {
          data.forEach((itemJson) {
            _allList.add(SwapOrderListEntity().fromJson(itemJson));
          });
        });
  }
}
