import 'package:mars/common/transaction_component_index.dart';

import '../../common/whiteBase/base_state.dart';
import '../../models/collection_balance_entity.dart';

class AssetsSwapPage extends StatefulWidget {
  @override
  _AssetsSwapPageState createState() => _AssetsSwapPageState();
}

class _AssetsSwapPageState extends BaseState<AssetsSwapPage> {
  @override
  Widget get appBar => getAppBar('${s.zc}', actions: [
        Row(children: [
          inkButton(
              onPressed: () {
                navigateTo(PageTransactionRouter.swap_list_of_miners_page);
              },
              child: Text('${s.kuanggonglieb}', style: TextStyles.textBlack14))
        ]),
        Gaps.hGap15,
      ]);
  CollectionBalanceEntity collectionBalanceEntity;
  bool isData = true;

//swap_list_of_miners_page
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        LoadImage('swap_zcbg', height: dp(210), width: double.infinity),
        Column(
          children: [
            Container(
                width: double.infinity,
                height: dp(82),
                padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$${collectionBalanceEntity != null ? collectionBalanceEntity.total.totalUsd : ''}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50), color: Color(0xFFEF5353))),
                    Gaps.vGap5,
                    Text('${s.text1}', style: TextStyles.textBlack13),
                  ],
                )),
            Gaps.vGap20,
            Expanded(
                child: isData == false
                    ? buildErrorWidget(topHeight: dp(200))
                    : GlobalTransaction.swapAssetsList.length == 0
                        ? buildLoadingShadeCustom(top: dp(200))
                        : listViewBuilder(
                            itemCount: GlobalTransaction.swapAssetsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(left: dp(12), right: dp(12), bottom: dp(12)),
                                  width: double.infinity,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFFFFFFFF)),
                                  padding: EdgeInsets.only(bottom: dp(12), top: dp(12)),
                                  height: dp(168),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Gaps.hGap12,
                                        LoadImage('${GlobalTransaction.swapAssetsList[index].icon}', width: dp(25), height: dp(25)),
                                        Gaps.hGap5,
                                        Text('${GlobalTransaction.swapAssetsList[index].netCurrencyName}', style: TextStyles.textBlack14),
                                      ]),
                                      Container(width: double.infinity, height: 0.5, color: Colours.textGrey, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
                                      Row(children: [
                                        Gaps.hGap12,
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('${s.ky}', style: TextStyles.textBlack12),
                                              Gaps.vGap3,
                                              Text('${GlobalTransaction.swapAssetsList[index].value}', style: TextStyles.textBlack17),
                                            ],
                                          ),
                                        )),
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('${s.dongjie}', style: TextStyles.textBlack12),
                                              Gaps.vGap3,
                                              Text('${GlobalTransaction.swapAssetsList[index].freeze}', style: TextStyles.textBlack17),
                                            ],
                                          ),
                                        )),
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text('${s.text3}', style: TextStyles.textBlack12),
                                              Gaps.vGap3,
                                              Text('${GlobalTransaction.swapAssetsList[index].usdValue}', style: TextStyles.textBlack17),
                                            ],
                                          ),
                                        )),
                                        Gaps.hGap12,
                                      ]),
                                      Gaps.vGap20,
                                      Row(children: [
                                        Gaps.hGap12,
                                        Expanded(
                                            child: inkButton(
                                                onPressed: GlobalTransaction.swapAssetsList[index].isOpenTransfer != '1'
                                                    ? null
                                                    : () {
                                                        if (GlobalTransaction.swapAssetsList[index].isOpenTransfer == '1')
                                                          navigateTo(PageTransactionRouter.transfer_digital_storage_page,
                                                                  bundle: Bundle()
                                                                    ..putBool('type', true)
                                                                    ..putInt('transferType', 3)
                                                                    ..putString('coin', GlobalTransaction.swapAssetsList[index].netCurrencyName))
                                                              .then((value) => getData());
                                                      },
                                                child: Container(
                                                  decoration: BoxDecoration(border: Border.all(color: GlobalTransaction.swapAssetsList[index].isOpenTransfer == '1' ? Colours.textBlack : Colours.textGrey, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                                                  alignment: Alignment.center,
                                                  child: Text('${s.zr}', style: GlobalTransaction.swapAssetsList[index].isOpenTransfer == '1' ? TextStyles.textBlack12 : TextStyles.textGrey12),
                                                  padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(7), bottom: dp(7)),
                                                ))),
                                        Gaps.hGap12,
                                        Expanded(
                                            child: inkButton(
                                                onPressed: GlobalTransaction.swapAssetsList[index].isOpenTransfer != '1'
                                                    ? null
                                                    : () {
                                                        if (GlobalTransaction.swapAssetsList[index].isOpenTransfer == '1')
                                                          navigateTo(PageTransactionRouter.transfer_digital_storage_page,
                                                                  bundle: Bundle()
                                                                    ..putBool('type', false)
                                                                    ..putInt('transferType', 3)
                                                                    ..putString('coin', GlobalTransaction.swapAssetsList[index].netCurrencyName))
                                                              .then((value) => getData());
                                                      },
                                                child: Container(
                                                  decoration: BoxDecoration(border: Border.all(color: GlobalTransaction.swapAssetsList[index].isOpenTransfer == '1' ? Colours.textBlack : Colours.textGrey, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                                                  alignment: Alignment.center,
                                                  child: Text('${s.zhaunchu}', style: GlobalTransaction.swapAssetsList[index].isOpenTransfer == '1' ? TextStyles.textBlack12 : TextStyles.textGrey12),
                                                  padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(7), bottom: dp(7)),
                                                ))),
                                        Gaps.hGap12,
                                        Expanded(
                                            child: inkButton(
                                                onPressed: () {
                                                  navigateTo(PageTransactionRouter.ledger_swap_page, bundle: Bundle()..putString('coin', GlobalTransaction.swapAssetsList[index].netCurrencyName));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colours.textBlack, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                                                  alignment: Alignment.center,
                                                  child: Text('${s.zbb}', style: TextStyles.textBlack12),
                                                  padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(7), bottom: dp(7)),
                                                ))),
                                        Gaps.hGap12,
                                      ]),
                                    ],
                                  ));
                            })),
          ],
        )
      ],
    );
  }

  getData() {
    Net().post(ApiTransaction.swap_balance, null, success: (data) {
      collectionBalanceEntity = CollectionBalanceEntity().fromJson(data);
      GlobalTransaction.swapAssetsList = collectionBalanceEntity.currencyList;
      if (collectionBalanceEntity.currencyList.length == 0) isData = false;
      setState(() {});
    }, failure: (error) {
      isData = false;
      setState(() {});
    });
  }
}
