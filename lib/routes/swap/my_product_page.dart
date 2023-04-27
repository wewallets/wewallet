import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/dateUtil.dart';
import '../../common/utils/pagingLoadNow.dart';
import '../../common/whiteBase/base_state.dart';
import '../../models/fund_assets_log_entity.dart';
import '../../models/pledge_order_list_entity.dart';

class MyProductPage extends StatefulWidget {
  final Bundle bundle;

  MyProductPage(this.bundle);

  @override
  _MyProductPageState createState() => _MyProductPageState();
}

class _MyProductPageState extends BaseState<MyProductPage> {
  RefreshController refreshController = RefreshController();
  List<PledgeOrderListEntity> _allList = [];
  PagingLoadNew pagingLoad = PagingLoadNew();

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
  Widget get appBar => getAppBar('${s.text70}');

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
            : listViewBuilder(itemCount: _allList.length, itemBuilder: (context, index) => _itemView(index)));
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
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('${_allList[index].title}', style: TextStyles.textBlack14),
              ]),
              Expanded(child: Container()),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(5)), color: Color(0xFFE74561)),
                padding: EdgeInsets.only(top: dp(5), bottom: dp(5), left: dp(12), right: dp(12)),
                child: Text('${_allList[index].statusStr}', style: TextStyles.textWhite12),
              ),
              Gaps.hGap12,
            ]),
            Container(width: double.infinity, height: 0.5, color: Colours.colorEE, margin: EdgeInsets.only(top: dp(12))),
            Gaps.vGap12,
            Row(children: [
              Gaps.hGap12,
              Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${s.text71} (${_allList[index].payCurrency})', style: TextStyles.textGrey612),
                        Gaps.vGap5,
                        Text('${_allList[index].payAmount}', style: TextStyles.textBlack16),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${s.text72}', style: TextStyles.textGrey612),
                        Gaps.vGap5,
                        Text('${_allList[index].day}${s.tian}', style: TextStyles.textBlack16),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${s.text73}(${_allList[index].toCurrency})', style: TextStyles.textGrey612),
                        Gaps.vGap5,
                        Text('${_allList[index].toAmount}', style: TextStyles.textBlack16),
                      ],
                    ),
                  )),
            ]),
            Container(width: double.infinity, height: 0.5, color: Colours.colorEE, margin: EdgeInsets.only(top: dp(12))),
            Gaps.vGap12,
            Row(children: [
              Gaps.hGap12,
              Text('${s.text74}',style: TextStyles.textGrey612),
              Gaps.hGap5,
              Text('${_allList[index].rate}%', style: TextStyles.textBlack14.copyWith(color: Color(0xFFEF5353))),
              Expanded(child: Container()),
              Text('${_allList[index].expireTime}',style: TextStyles.textGrey612),
              Gaps.hGap12,
            ]),
            Gaps.vGap12,
          ],
        ));
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    pagingLoad.request(
        url: ApiTransaction.swap_pledge_order_list,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          _allList.clear();
          data.forEach((itemJson) {
            _allList.add(PledgeOrderListEntity().fromJson(itemJson));
          });
        },
        nextPage: (data) {
          data.forEach((itemJson) {
            _allList.add(PledgeOrderListEntity().fromJson(itemJson));
          });
        });
  }
}
