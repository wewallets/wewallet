import 'package:mars/common/transaction_component_index.dart';

import '../../common/base/base_state.dart';
import '../../models/collection_product_rand_entity.dart';

class BuyConsignmentDigitalStoragePage extends StatefulWidget {
  final Bundle bundle;

  BuyConsignmentDigitalStoragePage(this.bundle);

  @override
  _BuyConsignmentDigitalStoragePageState createState() => _BuyConsignmentDigitalStoragePageState();
}

class _BuyConsignmentDigitalStoragePageState extends BaseState<BuyConsignmentDigitalStoragePage> {
  CollectionProductRandEntity collectionProductRandEntity;

  @override
  Widget get appBar => null;

  @override
  void initState() {
    super.initState();
    collectionProductRandEntity = widget.bundle.getObject('collectionProductRandEntity');
  }

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(dp(12)),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                width: double.infinity,
                height: dp(170),
                child: Stack(
                  children: [
                    LoadImage('${collectionProductRandEntity.productUrls}', height: double.infinity, width: double.infinity, fit: BoxFit.fill),
                    // Align(alignment: Alignment.topRight, child: LoadImage('buy_ybtp', width: dp(135), height: dp(108.5))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: dp(12), left: dp(12)), child: Text('${s.text10} ≈${collectionProductRandEntity.yearAward}%', style: TextStyles.textBlack13)),
                        Container(width: dp(220), height: 0.5, color: Colours.white, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
                        Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${collectionProductRandEntity.payAmount}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50)))),
                        Gaps.vGap5,
                        Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${s.text11}(${widget.bundle.getString('payType')})', style: TextStyles.textBlack13)),
                        Container(width: double.infinity, height: 0.5, color: Colours.white, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
                        Row(children: [
                          Gaps.hGap12,
                          collectionProductRandEntity.income.length < 1 ? Container() : Text('${collectionProductRandEntity.income[0].income} ${collectionProductRandEntity.income[0].currency}', style: TextStyles.textBlack20),
                          Expanded(child: Container()),
                          collectionProductRandEntity.income.length < 2 ? Container() : Text('${collectionProductRandEntity.income[1].income} ${collectionProductRandEntity.income[1].currency}', style: TextStyles.textBlack20),
                          Gaps.hGap12,
                        ]),
                        Gaps.vGap12,
                      ],
                    ),
                  ],
                )),
            Expanded(child: Container()),
            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              inkButton(
                  onPressed: () {
                    pop();
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: dp(45), right: dp(45)),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), border: Border.all(width: 0.5, color: Colours.white)),
                      height: dp(59),
                      alignment: Alignment.center,
                      child: Text('${s.qx}', style: TextStyles.textWhite14))),
              Gaps.hGap12,
              Expanded(
                  child: inkButton(
                onPressed: () {
                  buy();
                },
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill)),
                    height: dp(60),
                    alignment: Alignment.center,
                    child: Text('${s.goumai}(${collectionProductRandEntity.payAmount} ${widget.bundle.getString('payType').toUpperCase()})', style: TextStyles.textBlack18)),
              ))
            ]),
          ],
        ));
  }

  buy() {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.collection_order_add, {'amount': collectionProductRandEntity.payAmount, 'product_id': collectionProductRandEntity.productId, 'product_urls': collectionProductRandEntity.productUrls}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      Navigator.pop(context);
      showToast('${getString().zfcgclz}');
      navigateTo(PageTransactionRouter.my_digital_storage_page);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }
}
