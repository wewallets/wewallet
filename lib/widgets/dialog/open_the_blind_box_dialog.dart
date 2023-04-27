import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/collection_product_rand_entity.dart';
import 'package:mars/models/product_by_currency_entity.dart';
import '../../models/collection_product_list_entity.dart';
import 'base_dialog.dart';

//开盲盒
// ignore: must_be_immutable
class OpenTheBlindBoxDialog extends StatefulWidget {
  List<CollectionProductListEntity> collectionProductListEntityList = [];
  int index;
  var voidCallback;

  OpenTheBlindBoxDialog(this.collectionProductListEntityList, this.index,this.voidCallback);

  @override
  _OpenTheBlindBoxDialogState createState() => _OpenTheBlindBoxDialogState();
}

class _OpenTheBlindBoxDialogState extends State<OpenTheBlindBoxDialog> {
  TextEditingController numberController = new TextEditingController();
  List<ProductByCurrencyEntity> productByCurrencyEntityList = [];
  List<String> coinList = [];
  bool isUse;
  String coin;
  int index = 0;

  @override
  void initState() {
    super.initState();
    getProductByCurrency();
  }

  @override
  Widget build(BuildContext contexts) {
    return BaseDialog(
      width: double.infinity,
      height: double.infinity,
      widget: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: dp(60), right: dp(60)),
            decoration: BoxDecoration(color: Color(0xFF161427), borderRadius: BorderRadius.all(Radius.circular(dp(10)))),
            child: productByCurrencyEntityList.length == 0
                ? buildLoadingShadeCustom()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(dp(12)), child: Text('${s.text28}', style: TextStyles.textWhite14)),
                      Container(
                          margin: EdgeInsets.only(left: dp(12), right: dp(12)),
                          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), border: Border.all(width: 0.5, color: Colours.white)),
                          height: dp(49),
                          width: double.infinity,
                          child: inkButton(
                            onPressed: () {
                              navigatorTransactionContextPush(contexts, PageTransactionRouter.select_currency_two_page, bundle: Bundle()..putObject('list', coinList), onValue: (data) {
                                if (data != null) {
                                  coin = data;
                                }
                                setState(() {});
                              });
                            },
                            child: Row(
                              children: [
                                LoadImage('${productByCurrencyEntityList[index].iconCurrencyUrl}', width: dp(25), height: dp(25)),
                                Gaps.hGap5,
                                Text('$coin'.toUpperCase(), style: TextStyles.textWhite13),
                                Expanded(child: Container()),
                                LoadAssetImage('youjiantou', width: dp(25), color: Colours.white),
                              ],
                            ),
                          )),
                      Padding(padding: EdgeInsets.all(dp(12)), child: Text('${s.sl}', style: TextStyles.textWhite14)),
                      Container(
                          margin: EdgeInsets.only(left: dp(12), right: dp(12), bottom: dp(5)),
                          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), border: Border.all(width: 0.5, color: Colours.white)),
                          height: dp(49),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                                      child: TextField(
                                        keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                                        controller: numberController,
                                        style: TextStyles.textWhite14,
                                        cursorColor: Colours.white,
                                        onChanged: (String value) {
                                          setState(() {
                                            if (value == null || value == '')
                                              isUse = false;
                                            else
                                              isUse = true;
                                          });
                                        },
                                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.qsrsl}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                                      ))),
                            ],
                          )),
                      Padding(padding: EdgeInsets.only(left: dp(12), right: dp(12), bottom: dp(12)), child: Text('${productByCurrencyEntityList[index].payMin}-${productByCurrencyEntityList[index].payMax}', style: TextStyles.textGrey12)),
                      Container(height: 0.5, width: double.infinity, color: Colours.textGrey),
                      Gaps.vGap12,
                      Row(children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(left: dp(12)),
                          child: productByCurrencyEntityList.length < 1
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('${productByCurrencyEntityList[0].payCurrency.toUpperCase()}${s.text10}', style: TextStyles.textWhite10),
                                    Text('≈${productByCurrencyEntityList[0].yearAward}%', style: TextStyles.textWhite13),
                                  ],
                                ),
                        )),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(right: dp(12)),
                          child: productByCurrencyEntityList.length < 2
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('${productByCurrencyEntityList[1].payCurrency.toUpperCase()}${s.text10}', style: TextStyles.textWhite10),
                                    Text('≈${productByCurrencyEntityList[1].yearAward}%', style: TextStyles.textWhite13),
                                  ],
                                ),
                        ))
                      ]),
                      Gaps.vGap12,
                      Row(children: [
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(color: Color(0xFF242140), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(dp(10)))),
                                height: dp(38.5),
                                child: inkButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('${s.qx}', style: TextStyles.textWhite14)))),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('open_button')), fit: BoxFit.fill)),
                                height: dp(38.5),
                                child: inkButton(
                                    onPressed: () {
                                      if (numberController.text.length == 0) {
                                        showToast('${s.qsrsl}');
                                        return;
                                      }
                                      byCurrency();
                                    },
                                    child: Text('${s.text32}', style: TextStyles.textWhite14)))),
                      ]),
                    ],
                  ))
      ]),
      entryAnimation: EntryAnimation.DEFAULT,
    );
  }

  buildCoinList() {
    List<PopupMenuItem> list = [];
    for (int i = 0; i < productByCurrencyEntityList.length; i++) {
      list.add(PopupMenuItem(
        child: Text('${productByCurrencyEntityList[i].payCurrency.toUpperCase()}'),
        value: '${productByCurrencyEntityList[i].payCurrency}',
        padding: EdgeInsets.only(right: dp(90), left: dp(12)),
        onTap: () {
          index = i;
          coin = '${productByCurrencyEntityList[i].payCurrency}';
          setState(() {});
        },
      ));
    }
    return list;
  }

  getProductByCurrency() {
    Net().post(ApiTransaction.collection_product_by_currency, {'refer_currency': widget.collectionProductListEntityList[widget.index].referCurrency}, success: (data) {
      productByCurrencyEntityList.clear();
      data.forEach((v) {
        coinList.add(v['pay_currency']);
        productByCurrencyEntityList.add(ProductByCurrencyEntity().fromJson(v));
      });

      coin = productByCurrencyEntityList[0].payCurrency;
      setState(() {});
    });
  }

  byCurrency() {
    if (numberController.text.length == 0) {
      showToast('${s.qsrsl}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.collection_product_rand, {'refer_currency': widget.collectionProductListEntityList[widget.index].referCurrency, 'pay_currency': coin, 'amount': numberController.text}, success: (data) {
      CollectionProductRandEntity collectionProductRandEntity = CollectionProductRandEntity().fromJson(data);
      LayoutUtil.closeLoadingDialog(context);
      Navigator.pop(context);

      navigatorTransactionContextPush(context, PageTransactionRouter.buy_digital_storage_page,
          bundle: Bundle()
            ..putObject('collectionProductRandEntity', collectionProductRandEntity)
            ..putString('payType', coin));
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }
}
