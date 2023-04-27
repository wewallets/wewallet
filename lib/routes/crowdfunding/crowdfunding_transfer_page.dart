import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';

//转账
class CrowdFundingTransferPage extends StatefulWidget {
  final Bundle bundle;

  CrowdFundingTransferPage(this.bundle);

  @override
  _CrowdFundingTransferPageState createState() => _CrowdFundingTransferPageState();
}

class _CrowdFundingTransferPageState extends State<CrowdFundingTransferPage> {
  TextEditingController numberController = new TextEditingController();

  //币种
  String coin = GlobalTransaction.coin;
  bool isUse = false;
  String assetsRise;
  int type = 0;

  @override
  void initState() {
    super.initState();
    if (widget.bundle.isContainsKey('type')) {
      type = widget.bundle.getInt('type');
    }
    assetsRise = widget.bundle.getString('assetsRise');
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: LayoutUtil.getAppBar(context, '${type==4?getString().zhaunchu:getString().zf70}', actions: [
        InkResponse(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(30)),
              child: Row(children: [
                Text('${getString().zf71}', style: TextStyles.text7854D528.copyWith(color: Color(0xFF3250D4))),
              ])),
          onTap: () {
            navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_award_record_page);
          },
        )
      ]),
      body: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              InkWell(
                child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setWidth(70),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(20)),
                    decoration: BoxDecoration(color: Colours.color107854D5, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Text(coin, style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.w500))),
                        // Padding(
                        //   child: Text('${getString().xzbz}', style: TextStyles.textGrey12),
                        //   padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(4)),
                        // ),
                        Gaps.hGap10,
                        // LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                      ],
                    )),
                onTap: () {
                  // Navigator.pushNamed(context, PageRouter.select_currency_page, arguments: Bundle()..putInt('type', 2)).then((value) {
                  //   if (value != null) coin = value;
                  //   if (mounted) setState(() {});
                  // });
                },
              ),
              Gaps.vGap40,
              Text('${getString().zf72}', style: TextStyles.textBlack12),
              Stack(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
                    child: TextField(
                      autofocus: false,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
                      controller: numberController,
                      keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
                      cursorColor: Colours.textBlack,
                      decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().qsrsl}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(32))),
                      onChanged: (s) {
                        if (numberController.text.length != 0)
                          isUse = true;
                        else
                          isUse = false;
                        setState(() {});
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: InkResponse(
                      child: Text('${getString().qbb}', style: TextStyles.textGrey614),
                      onTap: () {
                        numberController.text = type == 1 ? GlobalTransaction.getAssetsWalletInfo(coin).order_value : assetsRise ?? 0.0;
                        if (numberController.text.length != 0)
                          isUse = true;
                        else
                          isUse = false;
                        setState(() {});
                      },
                    ),
                    alignment: Alignment.bottomRight),
              ]),
              Divider(height: 0, color: Colours.colorEE),
              Gaps.vGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${getString().keyong}${type == 1 ? GlobalTransaction.getAssetsWalletInfo(coin).order_value : assetsRise} $coin', style: TextStyles.textGrey12),
                ],
              ),
              Gaps.vGap10,
              Gaps.vGap50,
              Buttons.getDetermineButton(
                  isUse: isUse,
                  color: Color(0xFF3250D4),
                  voidCallback: () {
                    if (numberController.text.length == 0) {
                      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qsrsl}");
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (_) => InputPasswordDialog((data) {
                              if (data == GlobalTransaction.walletPassword) {
                                transfer();
                              } else {
                                Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().nsrdmmcw}');
                              }
                            }));
                  }),
            ],
          )),
    );
  }

  transfer() {
    LayoutUtil.showLoadingDialog(context);
    Net().post(
        type == 1
            ? ApiTransaction.assets_in
            : type == 3
                ? ApiTransaction.assets_ai_in
                : type == 4
                    ? ApiTransaction.assets_ai_out
                    : ApiTransaction.assets_out,
        {'currency': coin, 'amount': numberController.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      GlobalTransaction.refreshWalletAssets();
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().zf73}');
      Navigator.pop(context);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$error');
    });
  }
}
