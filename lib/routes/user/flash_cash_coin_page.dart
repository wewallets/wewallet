import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/index.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';

//闪兑
class FlashCashCoinPage extends StatefulWidget {
  final Bundle bundle;

  FlashCashCoinPage(this.bundle);

  @override
  _FlashCashCoinPageState createState() => _FlashCashCoinPageState();
}

class _FlashCashCoinPageState extends State<FlashCashCoinPage> {
  TextEditingController number1Controller = new TextEditingController();

  WalletAssets walletAssets;
  String unit_price;
  String conversion;
  String flashIcon;
  String flashIcon1;
  String flashIcon2;
  int type;

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('assetsItem')) {
      walletAssets = widget.bundle.getObject('assetsItem');
      flashIcon = widget.bundle.getString('flashIcon');
      if (widget.bundle.isContainsKey('flashIcon2')) {
        flashIcon1 = widget.bundle.getString('flashIcon');
        flashIcon2 = widget.bundle.getString('flashIcon2');
      }
      if (widget.bundle.isContainsKey('type')) {
        type = widget.bundle.getInt('type');
      }
    }

    getFlash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().sd}'),
      body: walletAssets == null
          ? Container()
          : unit_price == null
              ? LayoutUtil.getLoadingShadeCustom()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(50)),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                    decoration: BoxDecoration(border: Border.all(color: Color(0xFFE6E1E1), width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            LoadImage('${walletAssets.icon}', width: ScreenUtil().setWidth(74)),
                            Gaps.hGap7,
                            Text(walletAssets.net_currency_name, style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)),
                            Expanded(child: Container()),
                            inkButton(
                                child: LoadImage(flashIcon == 'USDT' ? 'wallet_usdt' : 'logo_x', width: ScreenUtil().setWidth(74)),
                                onPressed: () {
                                  if (flashIcon2 != null)
                                    selectBonus(voidCallback: (coin) {
                                      number1Controller.text = '';
                                      conversion = '0';
                                      flashIcon = coin;
                                      setState(() {});
                                      getFlash(isShow: true);
                                    });
                                }),
                            Gaps.hGap7,
                            inkButton(
                                child: Text('$flashIcon', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  if (flashIcon2 != null)
                                    selectBonus(voidCallback: (coin) {
                                      number1Controller.text = '';
                                      conversion = '0';
                                      flashIcon = coin;
                                      setState(() {});
                                      getFlash(isShow: true);
                                    });
                                }),
                            Gaps.hGap2,
                            LoadAssetImage('xiajiantou', width: adaptationDp(8), color: Colours.textGrey6),
                          ],
                        ),
                        LoadImage('shanhuid', width: ScreenUtil().setWidth(40)),
                        Row(children: [
                          Expanded(
                              child: Container(
                                  child: TextField(
                            autofocus: false,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
                            controller: number1Controller,
                            keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
                            cursorColor: Colours.textBlack,
                            onChanged: (s) {
                              if (s.length != 0 && unit_price != null) {
                                conversion = NumUtil.multiplyDecStr(s, unit_price).toString();
                              } else {
                                conversion = '0';
                              }
                              setState(() {});
                            },
                            decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().qinshuru}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(32))),
                          ))),
                          Expanded(child: Container(margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)), child: Text('${conversion ?? 0.0}', style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(32))))),
                        ]),
                        Container(height: 0.5, color: Colours.colorEE, width: double.infinity),
                        Gaps.vGap10,
                        Row(children: [Text('${getString().huilv}', style: TextStyles.textGrey14), Text(' 1 ${walletAssets.net_currency_name} = ${unit_price ?? 0.0} $flashIcon', style: TextStyles.textBlack16)]),
                        Gaps.vGap5,
                        Row(children: [
                          // Text('${getString().kuanggongfei}0.001 ${Global.coin}', style: TextStyles.textGrey12),
                          Text('${getString().sxf}', style: TextStyles.textGrey14),
                          Text(' 0.2%', style: TextStyles.textBlack16),
                        ]),
                        Gaps.vGap5,
                        Row(children: [
                          // Text('${getString().kuanggongfei}0.001 ${Global.coin}', style: TextStyles.textGrey12),
                          Text('${getString().kgf}', style: TextStyles.textGrey14),
                          Text(' 0.001', style: TextStyles.textBlack16),
                        ]),
                        Gaps.vGap20,
                        Buttons.getDetermineButton(
                            buttonText: '${getString().lijiduih}',
                            voidCallback: () {
                              if (number1Controller.text.length == 0) {
                                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qingshuruduihshul}');
                                return;
                              }
                              showDialog(
                                  context: context,
                                  builder: (_) => InputPasswordDialog((data) {
                                        if (data == GlobalTransaction.walletPassword) {
                                          submit();
                                        } else {
                                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().nsrdmmcw}');
                                        }
                                      }));
                            }),
                      ],
                    ),
                  ),
                ]),
    );
  }

  selectBonus({voidCallback}) {
    List<String> list = ['USDT', 'YISE'];
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext contexts) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  Expanded(
                      child: new GestureDetector(
                    child: new Container(),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(child: Container(alignment: Alignment.center, padding: EdgeInsets.only(left: 20), child: Text("${getString().sd}", style: TextStyles.textBlack18))),
                            InkResponse(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                child: LoadAssetImage(Images.combined_shape_26671, width: ScreenUtil().setWidth(30)),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    if (voidCallback != null) voidCallback(list[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                    alignment: Alignment.center,
                                    child: Text(list[index], style: TextStyles.textBlack14),
                                  ));
                            },
                            itemCount: list.length)
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  getFlash({isShow = false}) {
    if (isShow) LayoutUtil.showLoadingDialog(context);

    Net().post(ApiTransaction.UNIT_PRICE, {'trad_currency': '${walletAssets.net_currency_name}', 'base_currency': '$flashIcon'}, success: (data) {
      if (isShow) LayoutUtil.closeLoadingDialog(context);

      unit_price = data['unit_price'];
      if (mounted) setState(() {});
    }, failure: (error) {
      if (isShow) LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }

  submit() {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.CONVERSION, {'pay_currency': walletAssets.net_currency_name, 'get_currency': '$flashIcon', 'amount': number1Controller.text, 'get_type': type}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      GlobalTransaction.refreshWalletAssets();
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().czcgclz}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }
}
