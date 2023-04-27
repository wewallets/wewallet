import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/pledge_group_entity.dart';
import 'package:mars/models/pledge_list_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/dateUtil.dart';
import '../../common/utils/pagingLoadNow.dart';
import '../../common/whiteBase/base_state.dart';
import '../../models/fund_assets_log_entity.dart';
import '../../models/swap_product_list_entity.dart';

class PledgeSwapPage extends StatefulWidget {
  @override
  _PledgeSwapPageState createState() => _PledgeSwapPageState();
}

class _PledgeSwapPageState extends BaseState<PledgeSwapPage> {
  RefreshController refreshController = RefreshController();
  List<PledgeGroupEntity> allList = [];
  List<PledgeListEntity> pledgeList = [];

  PagingLoadNew pagingLoad = PagingLoadNew();
  int currentIndex = -1;
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
  Widget get appBar => getAppBar('质押', actions: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            inkButton(
                onPressed: () {
                  navigateTo(PageTransactionRouter.my_product_page);
                },
                child: LoadImage('ic_all_flag', width: dp(15), height: dp(15))),
            Gaps.hGap15,
          ],
        )
      ]);

  @override
  Widget buildContent(BuildContext context) {
    return !pagingLoad.errorNullData
        ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
        : SmartRefresher(
            controller: refreshController,
            enablePullUp: false,
            enablePullDown: false,
            onRefresh: () {
              getData(isFirstPage: true);
            },
            onLoading: () {
              getData();
            },
            child: !pagingLoad.errorNullData
                ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                : allList.length == 0
                    ? buildLoadingShadeCustom()
                    : listViewBuilder(itemCount: allList.length, itemBuilder: (context, index) => _itemView(index)));
  }

  _itemView(int index) {
    return Container(
        margin: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(12)),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFFFFFFFF)),
        padding: EdgeInsets.only(top: dp(12)),
        child: Column(
          children: [
            inkButton(
                onPressed: () {
                  if (currentIndex == index) {
                    coin = '';
                    currentIndex = -1;
                  } else {
                    coin = allList[index].payCurrency;
                    currentIndex = index;
                    pledgeList.clear();
                    getListData();
                  }
                  setState(() {});
                },
                child: Row(children: [
                  Gaps.hGap12,
                  LoadImage('${allList[index].icon}', width: dp(25), height: dp(25)),
                  Gaps.hGap5,
                  Text('${allList[index].payCurrency.toUpperCase()}', style: TextStyles.textBlack14),
                  Expanded(child: Container()),
                  LoadImage(currentIndex == index ? 'sanjiaoshang' : 'sanjiaoxia', width: dp(11)),
                  Gaps.hGap12,
                ])),
            Container(width: double.infinity, height: 0.5, color: Colours.colorEE, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
            Row(children: [
              Gaps.hGap12,
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${s.text74}', style: TextStyles.textGrey12),
                    Gaps.vGap5,
                    Text('${allList[index].minRate}% ~ ${allList[index].maxRate}%', style: TextStyles.textWhite18.copyWith(color: Color(0xFFEF5353))),
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${s.text76}', style: TextStyles.textGrey12),
                    Gaps.vGap5,
                    Text('${allList[index].minDay}${s.tian} ~ ${allList[index].maxDay}${s.tian}', style: TextStyles.textBlack18),
                  ],
                ),
              )),
              Gaps.hGap12,
            ]),
            index == currentIndex
                ? listViewBuilder(
                    isSlide: true,
                    itemCount: pledgeList.length,
                    itemBuilder: (context, index) => inkButton(
                        onPressed: () {
                          navigateTo(PageTransactionRouter.product_details_page, bundle: Bundle()..putObject('pledgeListEntity', pledgeList[index]));
                        },
                        child: _itemListView(index)))
                : Container(),
            Gaps.vGap12,
          ],
        ));
  }

  _itemListView(int index) {
    return Container(
        margin: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(12)),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFFF8F8FC)),
        padding: EdgeInsets.only(top: dp(12)),
        child: Column(
          children: [
            Row(children: [
              Gaps.hGap12,
              Text('${pledgeList[index].title}', style: TextStyles.textBlack14),
              Expanded(child: Container()),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(5)), color: Color(0xFFE74561)),
                padding: EdgeInsets.only(top: dp(5), bottom: dp(5), left: dp(12), right: dp(12)),
                child: Text('${s.text77}', style: TextStyles.textWhite12),
              ),
              Gaps.hGap12,
            ]),
            Container(width: double.infinity, height: 0.5, color: Colours.colorEE, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
            Row(children: [
              Gaps.hGap12,
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${s.text74}', style: TextStyles.textGrey12),
                    Gaps.vGap5,
                    Text('${pledgeList[index].rate}%', style: TextStyles.textWhite18.copyWith(color: Color(0xFFEF5353))),
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${s.text76}', style: TextStyles.textGrey12),
                    Gaps.vGap5,
                    Text('${pledgeList[index].day}${s.tian}', style: TextStyles.textBlack18),
                  ],
                ),
              )),
              Gaps.hGap12,
            ]),
            Gaps.vGap12,
          ],
        ));
  }

  getListData() {
    showLoadingDialog();
    Net().post(ApiTransaction.swap_pledge_list, {'pay_currency': coin}, success: (data) {
      closeLoadingDialog();
      pledgeList.clear();
      data.forEach((itemJson) {
        pledgeList.add(PledgeListEntity().fromJson(itemJson));
      });
      setState(() {});
    }, failure: (error) {
      closeLoadingDialog();
      pledgeList.clear();
    });
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    pagingLoad.request(
        url: ApiTransaction.swap_pledge_group,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          allList.clear();
          data.forEach((itemJson) {
            allList.add(PledgeGroupEntity().fromJson(itemJson));
          });
        },
        nextPage: (data) {
          data.forEach((itemJson) {
            allList.add(PledgeGroupEntity().fromJson(itemJson));
          });
        });
  }
}
