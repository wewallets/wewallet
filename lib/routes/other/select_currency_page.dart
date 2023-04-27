import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletAssets.dart';

//选择币种
class SelectCurrencyPage extends StatefulWidget {
  final Bundle bundle;

  SelectCurrencyPage(this.bundle);

  @override
  _SelectCurrencyPageState createState() => _SelectCurrencyPageState();
}

class _SelectCurrencyPageState extends State<SelectCurrencyPage> {
  List<CityModel> cityList = [];
  String keyword;
  int type = 0;

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('type')) type = widget.bundle.getInt('type');

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.white,

        appBar: LayoutUtil.getAppBar(context, '${getString().xzbz}', elevation: 0.0),
        body: Column(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(10), bottom: ScreenUtil().setWidth(30)),
            //   decoration: BoxDecoration(color: ColorsUtil.hexColor(0xF6F6F6), borderRadius: BorderRadius.all(Radius.circular(20))),
            //   height: ScreenUtil().setWidth(80),
            //   padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
            //   child: Row(
            //     children: <Widget>[
            //       LoadImage('ss_an', width: ScreenUtil().setWidth(40)),
            //       Gaps.hGap12,
            //       Expanded(
            //           child: TextField(
            //         maxLines: 1,
            //         onSubmitted: (v) {
            //           if (v == '')
            //             keyword = null;
            //           else
            //             keyword = v;
            //         },
            //         onChanged: (v) {
            //           keyword = v;
            //         },
            //         decoration: InputDecoration(border: InputBorder.none, hintText: '搜索币种', hintStyle: TextStyle(color: ColorsUtil.hexColor(0xb4b4b4), fontSize: ScreenUtil().setSp(28))),
            //         keyboardType: TextInputType.text,
            //         textInputAction: TextInputAction.done,
            //         style: TextStyle(color: ColorsUtil.hexColor(0x333333), fontSize: ScreenUtil().setSp(28)),
            //       )),
            //       LoadImage('delete_text', width: ScreenUtil().setWidth(40)),
            //     ],
            //   ),
            // ),
            Expanded(
                child: AzListView(
                  data: cityList,
                  itemCount: cityList.length,
                  itemBuilder: (BuildContext context, int index) {
                    CityModel model = cityList[index];
                    return InkWell(
                        onTap: () {
                          if (type == 1) {
                            Navigator.of(context).pop();
                            if (model.name == GlobalTransaction.coin)
                              navigatorTransactionContextPush(context, PageTransactionRouter.account_receivable_page);
                            else
                              navigatorTransactionContextPush(context, PageTransactionRouter.recharge_coin_page, bundle: Bundle()..putObject('assetsItem', GlobalTransaction.getAssetsWalletInfo(model.name)));
                          } else if (type == 2) {
                            navigatorTransactionContextPush(context, PageTransactionRouter.transfer_accounts_page, bundle: Bundle()..putObject('assetsItem', GlobalTransaction.getAssetsWalletInfo(model.name)));
                          } else if (type == 3) {
                            navigatorTransactionContextPush(context, PageTransactionRouter.withdraw_coin_page, bundle: Bundle()..putObject('assetsItem', GlobalTransaction.getAssetsWalletInfo(model.name)));
                          } else
                            Navigator.of(context).pop(model.name);
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Text(model.name, style: TextStyles.textBlack14),
                              height: ScreenUtil().setWidth(79),
                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(height: ScreenUtil().setWidth(1), color: Colours.colorEE),
                          ],
                        ));
                  },
                  physics: BouncingScrollPhysics(),
                  indexBarOptions: IndexBarOptions(
                    needRebuild: true,
                    ignoreDragCancel: true,
                    downTextStyle: TextStyles.textWhite12,
                    textStyle: TextStyles.textBlack12,
                    downItemDecoration: BoxDecoration(shape: BoxShape.circle, color: Colours.themeColor),
                    indexHintWidth: 120 / 2,
                    indexHintHeight: 100 / 2,
                    indexHintAlignment: Alignment.centerRight,
                    indexHintChildAlignment: Alignment(-0.25, 0.0),
                    indexHintOffset: Offset(-20, 0),
                  ),
                  susItemHeight: ScreenUtil().setWidth(80),
                ))
          ],
        ));
  }

  getData() {
    if (SpUtil.hasKey('assetsList')) {
      cityList.clear();
      List<WalletAssets> assetsList = SpUtil.getObjList('assetsList', (v) => WalletAssets.fromJson(v));

      if (widget.bundle != null) {
        assetsList.forEach((element) {
          cityList.add(CityModel(name: element.net_currency_name, tagIndex: element.net_currency_name.substring(0, 1)));
        });
        if (mounted) setState(() {});
      } else {
        assetsList.forEach((element) {
          cityList.add(CityModel(name: element.net_currency_name, tagIndex: element.net_currency_name.substring(0, 1)));
        });
      }
      if (mounted) setState(() {});
    }
    Net().post(ApiTransaction.CHAIN_BALANCE, {'account': GlobalTransaction.walletInfo.account_id}, success: (data) {
      cityList.clear();
      data['currency_list'].forEach((element) {
        var ls = WalletAssets.fromJson(element);
        cityList.add(CityModel(name: ls.net_currency_name, tagIndex: ls.net_currency_name.substring(0, 1)));
      });

      if (mounted) setState(() {});
    });
  }
}

class CityModel extends ISuspensionBean {
  String name;
  String tagIndex;

  CityModel({
    this.name,
    this.tagIndex,
  });

  CityModel.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {'name': name};

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => json.encode(this);
}
