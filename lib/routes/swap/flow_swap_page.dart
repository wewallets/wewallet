import 'package:mars/common/transaction_component_index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/dateUtil.dart';
import '../../common/utils/pagingLoadNow.dart';
import '../../common/whiteBase/base_state.dart';
import '../../models/fund_assets_log_entity.dart';
import '../../models/swap_product_list_entity.dart';

class FlowSwapPage extends StatefulWidget {
  @override
  _FlowSwapPageState createState() => _FlowSwapPageState();
}

class _FlowSwapPageState extends BaseState<FlowSwapPage> {
  RefreshController refreshController = RefreshController();
  List<SwapProductListProductList> _allList = [];
  PagingLoadNew pagingLoad = PagingLoadNew();
  int type;
  String coin = 'USDT';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget get appBar => getAppBar('${s.text34}');

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
                    : listViewBuilder(
                        itemCount: _allList.length,
                        itemBuilder: (context, index) => inkButton(
                            onPressed: () {
                              navigateTo(PageTransactionRouter.independent_swap_page, bundle: Bundle()..putObject('swapProductListEntity', _allList[index]));
                            },
                            child: _itemView(index))));
  }

  _itemView(int index) {
    return Container(
        margin: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(12)),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFFFFFFFF)),
        padding: EdgeInsets.only(top: dp(12)),
        child: Column(
          children: [
            Row(children: [
              Gaps.hGap12,
              LoadImage('${_allList[index].icon}', width: dp(25), height: dp(25)),
              Gaps.hGap5,
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('${_allList[index].currency.toUpperCase()}', style: TextStyles.textBlack14),
                Text('${s.text35}${_allList[index].tradeAmount}', style: TextStyles.textGrey12),
              ]),
              Expanded(child: Container()),
              Text('', style: TextStyles.textBlack14),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: ''.contains('-') ? Colours.colorButton1 : Color(0xFF16A47A), borderRadius: BorderRadius.circular(2)),
                height: ScreenUtil().setWidth(66),
                width: ScreenUtil().setWidth(150),
                child: Text('${_allList[index].riceFall}%', style: TextStyles.textWhite14),
              ),
              Gaps.hGap12,
            ]),
            Container(width: double.infinity, height: 0.5, color: Colours.colorEE, margin: EdgeInsets.only(top: dp(12))),
            Row(children: [
              Gaps.hGap12,
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${s.text36}${_allList[index].toCurrency}${s.sl}', style: TextStyles.textGrey12),
                    Gaps.vGap5,
                    Text('${_allList[index].totalPool}', style: TextStyles.textBlack16.copyWith(color: Color(0xFFF7B500))),
                  ],
                ),
              )),
              Container(width: 0.5, height: dp(76), color: Colours.colorEE),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${s.text36}${_allList[index].toCurrency}${s.sl}', style: TextStyles.textGrey12),
                    Gaps.vGap5,
                    Text('${_allList[index].toTotalPool}', style: TextStyles.textBlack16.copyWith(color: Color(0xFFF7B500))),
                  ],
                ),
              )),
            ]),
          ],
        ));
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    map['currency'] = coin;
    pagingLoad.request(
        url: ApiTransaction.swap_product_list,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          GlobalTransaction.swapProductListData = SwapProductListEntity().fromJson(data);

          _allList.clear();
          _allList.addAll(GlobalTransaction.swapProductListData.productList);
        },
        nextPage: (data) {
          data['product_list'].forEach((itemJson) {
            _allList.add(SwapProductListProductList().fromJson(itemJson));
          });
        });
  }
}
