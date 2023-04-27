import 'package:mars/common/transaction_component_index.dart';

import '../../common/base/base_state.dart';
import '../../models/collection_balance_entity.dart';

class AssetsDigitalStoragePage extends StatefulWidget {
  @override
  _AssetsDigitalStoragePageState createState() => _AssetsDigitalStoragePageState();
}

class _AssetsDigitalStoragePageState extends BaseState<AssetsDigitalStoragePage> {
  @override
  Widget get appBar => getAppBar('${s.zc}');
  CollectionBalanceEntity collectionBalanceEntity;
  bool isData = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(dp(12)),
            width: double.infinity,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('assets_bgs')), fit: BoxFit.fill)),
            height: dp(74),
            padding: EdgeInsets.only(left: dp(12), right: dp(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${collectionBalanceEntity != null ? collectionBalanceEntity.total.totalUsd : ''}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50))),
                Gaps.vGap5,
                Text('${s.text1}', style: TextStyles.textBlack13),
              ],
            )),
        Gaps.vGap20,
        Row(
          children: [
            Expanded(
                child: inkButton(
                    onPressed: () {
                      navigateTo(PageTransactionRouter.transfer_digital_storage_page);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadAssetImage('assets_zr', width: dp(35), height: dp(35)),
                          Gaps.vGap3,
                          Text('${s.zr}', style: TextStyles.textWhite14),
                        ],
                      ),
                    ))),
            Expanded(
                child: inkButton(
                    onPressed: () {
                      navigateTo(PageTransactionRouter.transfer_digital_storage_page);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadAssetImage('assets_zc', width: dp(35), height: dp(35)),
                          Gaps.vGap3,
                          Text('${s.zhaunchu}', style: TextStyles.textWhite14),
                        ],
                      ),
                    ))),
            Expanded(
                child: inkButton(
                    onPressed: () {
                      navigateTo(PageTransactionRouter.ledger_digital_storage_page);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadAssetImage('assets_zb', width: dp(35), height: dp(35)),
                          Gaps.vGap3,
                          Text('${s.zbb}', style: TextStyles.textWhite14),
                        ],
                      ),
                    ))),
            Expanded(
                child: inkButton(
                    onPressed: () {
                      navigateTo(PageTransactionRouter.my_digital_storage_page);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadAssetImage('assets_wdsc', width: dp(35), height: dp(35)),
                          Gaps.vGap3,
                          Text('${s.text2}', style: TextStyles.textWhite14),
                        ],
                      ),
                    ))),
          ],
        ),
        Gaps.vGap20,
        Expanded(
            child: isData == false
                ? buildErrorWidget(topHeight: dp(200))
                : GlobalTransaction.digitalStorageAssetsList.length == 0
                    ? buildLoadingShadeCustom(top: dp(200))
                    : listViewBuilder(
                        itemCount: GlobalTransaction.digitalStorageAssetsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(left: dp(12), right: dp(12), bottom: dp(12)),
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFF161427)),
                              padding: EdgeInsets.only(bottom: dp(12), top: dp(12)),
                              height: dp(168),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Gaps.hGap12,
                                    LoadImage('${GlobalTransaction.digitalStorageAssetsList[index].icon}', width: dp(25), height: dp(25)),
                                    Gaps.hGap5,
                                    Text('${GlobalTransaction.digitalStorageAssetsList[index].netCurrencyName}', style: TextStyles.textWhite14),
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
                                          Text('${s.ky}', style: TextStyles.textWhite12),
                                          Gaps.vGap3,
                                          Text('${GlobalTransaction.digitalStorageAssetsList[index].value}', style: TextStyles.textWhite17),
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${s.dongjie}', style: TextStyles.textWhite12),
                                          Gaps.vGap3,
                                          Text('${GlobalTransaction.digitalStorageAssetsList[index].freeze}', style: TextStyles.textWhite17),
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text('${s.text3}', style: TextStyles.textWhite12),
                                          Gaps.vGap3,
                                          Text('${GlobalTransaction.digitalStorageAssetsList[index].usdValue}', style: TextStyles.textWhite17),
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
                                            onPressed: GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer != '1'
                                                ? null
                                                : () {
                                                    if (GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer == '1')
                                                      navigateTo(PageTransactionRouter.transfer_digital_storage_page,
                                                              bundle: Bundle()
                                                                ..putBool('type', true)
                                                                ..putString('coin', GlobalTransaction.digitalStorageAssetsList[index].netCurrencyName))
                                                          .then((value) => getData());
                                                  },
                                            child: Container(
                                              decoration: BoxDecoration(border: Border.all(color: GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer == '1' ? Colours.white : Colours.textGrey6, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                                              alignment: Alignment.center,
                                              child: Text('${s.zr}', style: GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer == '1' ? TextStyles.textWhite12 : TextStyles.textGrey612),
                                              padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(7), bottom: dp(7)),
                                            ))),
                                    Gaps.hGap12,
                                    Expanded(
                                        child: inkButton(
                                            onPressed: GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer != '1'
                                                ? null
                                                : () {
                                                    if (GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer == '1')
                                                      navigateTo(PageTransactionRouter.transfer_digital_storage_page,
                                                              bundle: Bundle()
                                                                ..putBool('type', false)
                                                                ..putString('coin', GlobalTransaction.digitalStorageAssetsList[index].netCurrencyName))
                                                          .then((value) => getData());
                                                  },
                                            child: Container(
                                              decoration: BoxDecoration(border: Border.all(color: GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer == '1' ? Colours.white : Colours.textGrey6, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                                              alignment: Alignment.center,
                                              child: Text('${s.zhaunchu}', style: GlobalTransaction.digitalStorageAssetsList[index].isOpenTransfer == '1' ? TextStyles.textWhite12 : TextStyles.textGrey612),
                                              padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(7), bottom: dp(7)),
                                            ))),
                                    Gaps.hGap12,
                                    Expanded(
                                        child: inkButton(
                                            onPressed: () {
                                              navigateTo(PageTransactionRouter.ledger_digital_storage_page, bundle: Bundle()..putString('coin', GlobalTransaction.digitalStorageAssetsList[index].netCurrencyName));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(border: Border.all(color: Colours.white, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                                              alignment: Alignment.center,
                                              child: Text('${s.zbb}', style: TextStyles.textWhite12),
                                              padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(7), bottom: dp(7)),
                                            ))),
                                    Gaps.hGap12,
                                    GlobalTransaction.digitalStorageAssetsList[index].netCurrencyName == 'REX'
                                        ? Expanded(
                                            child: inkButton(
                                                onPressed: () {
                                                  navigateTo(PageTransactionRouter.digital_flash_cash_coin_page,
                                                          bundle: Bundle()
                                                            ..putString('flashIcon1', GlobalTransaction.digitalStorageAssetsList[index].icon)
                                                            ..putString('flashIcon2', GlobalTransaction.getDigitalStorageAssets('MTP').icon))
                                                      .then((value) => getData());
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colours.white, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                                                  alignment: Alignment.center,
                                                  child: Text('${s.sd}', style: TextStyles.textWhite12),
                                                  padding: EdgeInsets.only(left: dp(12), right: dp(12), top: dp(7), bottom: dp(7)),
                                                )))
                                        : Container(),
                                    Gaps.hGap12,
                                  ]),
                                ],
                              ));
                        })),
      ],
    );
  }

  getData() {
    Net().post(ApiTransaction.collection_balance, null, success: (data) {
      collectionBalanceEntity = CollectionBalanceEntity().fromJson(data);
      GlobalTransaction.digitalStorageAssetsList = collectionBalanceEntity.currencyList;
      if (collectionBalanceEntity.currencyList.length == 0) isData = false;
      setState(() {});
    }, failure: (error) {
      isData = false;
      setState(() {});
    });
  }
}
