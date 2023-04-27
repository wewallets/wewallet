import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/index.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';

//闪兑
class DigitalFlashCashCoinPage extends StatefulWidget {
  final Bundle bundle;

  DigitalFlashCashCoinPage(this.bundle);

  @override
  _DigitalFlashCashCoinPageState createState() => _DigitalFlashCashCoinPageState();
}

class _DigitalFlashCashCoinPageState extends State<DigitalFlashCashCoinPage> {
  TextEditingController number1Controller = new TextEditingController();

  String unitPrice;
  String conversion;
  String coin1 = 'REX';
  String coin2 = 'MTP';
  String flashIcon1;
  String flashIcon2;
  String fee;

  @override
  void initState() {
    super.initState();
    flashIcon1 = widget.bundle.getString('flashIcon1');
    flashIcon2 = widget.bundle.getString('flashIcon2');
    getFlash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().sd}'),
      body: unitPrice == null
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
                        LoadImage('$flashIcon1', width: ScreenUtil().setWidth(74)),
                        Gaps.hGap7,
                        Text(coin1, style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)),
                        Expanded(child: Container()),
                        inkButton(child: LoadImage(flashIcon2, width: ScreenUtil().setWidth(74)), onPressed: () {}),
                        Gaps.hGap7,
                        inkButton(child: Text('$coin2', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)), onPressed: () {}),
                        Gaps.hGap2,
                        // LoadAssetImage('xiajiantou', width: adaptationDp(8), color: Colours.textGrey6),
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
                          if (s.length != 0 && unitPrice != null) {
                            conversion = NumUtil.multiplyDecStr(s, unitPrice).toString();
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
                    Row(children: [Text('${getString().huilv}', style: TextStyles.textGrey14), Text(' 1 $coin1 = ${unitPrice ?? 0.0} $coin2', style: TextStyles.textBlack16)]),
                    Gaps.vGap5,
                    Row(children: [
                      // Text('${getString().kuanggongfei}0.001 ${Global.coin}', style: TextStyles.textGrey12),
                      Text('${getString().sxf}', style: TextStyles.textGrey14),
                      Text(' $fee%', style: TextStyles.textBlack16),
                    ]),
                    // Gaps.vGap5,
                    // Row(children: [
                    //   // Text('${getString().kuanggongfei}0.001 ${Global.coin}', style: TextStyles.textGrey12),
                    //   Text('${getString().kgf}', style: TextStyles.textGrey14),
                    //   Text(' 0.001', style: TextStyles.textBlack16),
                    // ]),
                    Gaps.vGap20,
                    Buttons.getDetermineButton(
                        buttonText: '${getString().lijiduih}',
                        voidCallback: () {
                          if (number1Controller.text.length == 0) {
                            Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qingshuruduihshul}');
                            return;
                          }
                          showDialog(
                              context: context,
                              builder: (_) => InputPasswordDialog((data) {
                                    if (data == GlobalTransaction.walletPassword) {
                                      submit();
                                    } else {
                                      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().nsrdmmcw}');
                                    }
                                  }));
                        }),
                  ],
                ),
              ),
            ]),
    );
  }

  getFlash({isShow = false}) {
    if (isShow) LayoutUtil.showLoadingDialog(context);

    Net().post(ApiTransaction.collection_UNIT_PRICE, {'trad_currency': '$coin1', 'base_currency': '$coin2'}, success: (data) {
      if (isShow) LayoutUtil.closeLoadingDialog(context);

      unitPrice = data['symbol_arr'][0]['price'];
      fee = data['symbol_arr'][0]['fee'];
      if (mounted) setState(() {});
    }, failure: (error) {
      if (isShow) LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$error');
    });
  }

  submit() {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.collection_CONVERSION, {'pay_currency': coin1, 'get_currency': coin2, 'amount': number1Controller.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      GlobalTransaction.refreshWalletAssets();
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().czcgclz}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$error');
    });
  }
}
