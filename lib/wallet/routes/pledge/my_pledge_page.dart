import 'package:mars/models/Wallet_pledge_order_list.dart';
import 'package:mars/models/wallet_pledge_list_entity.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:mars/wallet/common/utils/pagingLoad.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MyPledgePage extends StatefulWidget {
  @override
  _MyPledgePageState createState() => _MyPledgePageState();
}

class _MyPledgePageState extends BaseState<MyPledgePage> {
  PagingLoad pagingLoad = PagingLoad();
  RefreshController refreshController = RefreshController();
  List<WalletPledgeOrderList> list = [];

  @override
  Widget get appBar => getAppBar('我的质押', actions: []);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: true,
        onRefresh: () {
          getData(isRefresh: true);
        },
        onLoading: () {
          getData();
        },
        child: !pagingLoad.errorNullData
            ? buildErrorWidget()
            : list.length == 0
                ? buildLoadingShadeCustom()
                : listViewBuilder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return getItem(index);
                    }));
  }

  getItem(index) {
    if (list[index].pledgeType == '0') {
      return inkButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white, border: Border.all(width: 0.5, color: Color(0xFFDEDEDE))),
            padding: EdgeInsets.all(dp(15)),
            margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('活期质押', style: TextStyles().textBlack16.copyWith(fontWeight: FontWeight.bold)),
                    Expanded(child: Container()),
                    inkButton(
                        onPressed: () {
                          pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(6)), color: Colours().themeColor),
                          padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(8), bottom: dp(8)),
                          child: Text('解冻', style: TextStyles().textWhite14),
                        )),
                  ],
                ),
                Gaps.vGap20,
                Lines().line,
                Gaps.vGap15,
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: Column(
                      children: [
                        Text('参考年化', style: TextStyles().textGrey12),
                        Gaps.vGap5,
                        Text('${list[index].rate}%', style: TextStyles().textTheme16),
                      ],
                    ))),
                    Expanded(
                        child: Container(
                            child: Column(
                      children: [
                        Text('冻结数量(YISE)', style: TextStyles().textGrey12),
                        Gaps.vGap5,
                        Text('${list[index].payAmount}', style: TextStyles().textBlack16),
                      ],
                    ))),
                    Expanded(
                        child: Container(
                            child: Column(
                      children: [
                        Text('累计收益(YISE)', style: TextStyles().textGrey12),
                        Gaps.vGap5,
                        Text('${list[index].toAmount}', style: TextStyles().textBlack16),
                      ],
                    ))),
                  ],
                ),
              ],
            ),
          ));
    } else {
      if (list[index].status == '0') {
        return inkButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white, border: Border.all(width: 0.5, color: Color(0xFFDEDEDE))),
              padding: EdgeInsets.all(dp(15)),
              margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('${list[index].title}', style: TextStyles().textBlack16.copyWith(fontWeight: FontWeight.bold)),
                      Expanded(child: Container()),
                      inkButton(
                          onPressed: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(dp(6)),
                                color: list[index].status == '0'
                                    ? Color(0xFFEA4B4B)
                                    : list[index].status == '1'
                                        ? Color(0xFF2FB93B)
                                        : Colours().textGrey),
                            padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(8), bottom: dp(8)),
                            child: Text('${list[index].statusStr}', style: TextStyles().textWhite14),
                          )),
                    ],
                  ),
                  Gaps.vGap20,
                  Lines().line,
                  Gaps.vGap15,
                  Row(
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Text('参考年化', style: TextStyles().textGrey12),
                          Gaps.vGap5,
                          Text('${list[index].rate}%', style: TextStyles().textTheme16),
                        ],
                      )),
                      Expanded(child: Container()),
                      Container(
                          child: Column(
                        children: [
                          Text('质押数量(YISE)', style: TextStyles().textGrey12),
                          Gaps.vGap5,
                          Text('${list[index].payAmount}', style: TextStyles().textBlack16),
                        ],
                      )),
                    ],
                  ),
                  Gaps.vGap15,
                  Row(
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Text('质押周期', style: TextStyles().textGrey12),
                          Gaps.vGap5,
                          Text('${list[index].day}天', style: TextStyles().textBlack16),
                        ],
                      )),
                      Expanded(child: Container()),
                      Container(
                          child: Column(
                        children: [
                          Text('累计收益(YISE)', style: TextStyles().textGrey12),
                          Gaps.vGap5,
                          Text('${list[index].toAmount}', style: TextStyles().textBlack16),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ));
      }
    }
    return Container();
  }

  getData({isRefresh = false}) {
    Map<String, dynamic> map = Map();


  }
}
