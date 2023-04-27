import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';

//闪兑
class FlashCashPage extends StatefulWidget {
  final Bundle bundle;

  FlashCashPage(this.bundle);

  @override
  _FlashCashPageState createState() => _FlashCashPageState();
}

class _FlashCashPageState extends State<FlashCashPage> {
  TextEditingController number1Controller = new TextEditingController();
  String flashIcon = 'USDT';
  int type;
  String exchangeRate = '';
  String conversion = '';

  @override
  void initState() {
    super.initState();
    EventBus().on('bankCardInfoEntity', ({arg}) {
      Future.delayed(Duration(milliseconds: 200), () {
        Navigator.pushNamed(context, PageTransactionRouter.confirm_recharge_page,
            arguments: Bundle()
              ..putObject('bankCardInfoEntity', arg)
              ..putString('rechargeAmount', number1Controller.text));
      });
    });
    getFlash();
  }

  @override
  void dispose() {
    EventBus().off('bankCardInfoEntity');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().sd}'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(50)),
          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
          decoration: BoxDecoration(border: Border.all(color: Color(0xFFE6E1E1), width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: [
              Row(
                children: [
                  LoadImage('cny', width: ScreenUtil().setWidth(74)),
                  Gaps.hGap7,
                  Text('CNY', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)),
                  Expanded(child: Container()),
                  inkButton(child: LoadImage('wallet_usdt', width: ScreenUtil().setWidth(74)), onPressed: () {}),
                  Gaps.hGap7,
                  inkButton(child: Text('$flashIcon', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)), onPressed: () {}),
                ],
              ),
              LoadImage('shanhuid', width: ScreenUtil().setWidth(60)),
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
                    if (s.length != 0 && exchangeRate != null) {
                      conversion = NumUtil.formatNum(NumUtil.divideDecStr(s, exchangeRate).toString(), 4).toString();
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
              Row(children: [Text('${getString().huilv}', style: TextStyles.textGrey14), Text(' 1 USDT = $exchangeRate CNY', style: TextStyles.textBlack16)]),
              Gaps.vGap20,
              Buttons.getDetermineButton(
                  buttonText: '${getString().lijiduih}',
                  voidCallback: () {
                    if (number1Controller.text.length == 0) {
                      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qingshuruduihshul}');
                      return;
                    }
                    Navigator.pushNamed(context, PageTransactionRouter.bank_list_page).then((value) {});
                  }),
            ],
          ),
        ),
      ]),
    );
  }

  getFlash({isShow = false}) {
    if (isShow) LayoutUtil.showLoadingDialog(context);

    Net().post(ApiTransaction.recharge_exchangerate, null, success: (data) {
      if (isShow) LayoutUtil.closeLoadingDialog(context);
      exchangeRate = data['exchangerate'];
      if (mounted) setState(() {});
    }, failure: (error) {
      if (isShow) LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }
}
