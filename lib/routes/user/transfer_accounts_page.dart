import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/global.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/walletAssets.dart';
import 'package:mars/models/walletPropose.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';
import 'package:mars/widgets/dialog/scan_view_sheet_dialog.dart';
import 'package:mars/widgets/dialog/selection_tips_dialog.dart';
import 'package:mars/widgets/kline/utils/number_util.dart';
import 'package:permission_handler/permission_handler.dart';

//转账
class TransferAccountsPage extends StatefulWidget {
  final Bundle bundle;

  TransferAccountsPage(this.bundle);

  @override
  _TransferAccountsPageState createState() => _TransferAccountsPageState();
}

class _TransferAccountsPageState extends State<TransferAccountsPage> {
  TextEditingController addressController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  WalletAssets walletAssets;

  //币种
  String coin = GlobalTransaction.coin;
  bool isUse = false;

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('address')) addressController.text = widget.bundle.getString('address');
    if (widget.bundle != null && widget.bundle.isContainsKey('assetsItem')) {
      walletAssets = widget.bundle.getObject('assetsItem');
      coin = walletAssets.net_currency_name;
    } else {
      walletAssets = GlobalTransaction.getAssetsWalletInfo(GlobalTransaction.coin);
    }

    initCoinList();
  }

  initCoinList() {
    coin = coin;
    setState(() {});
  }

  @override
  void dispose() {
    addressController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: LayoutUtil.getAppBar(context, '${getString().zz}'),
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
                        Padding(
                          child: Text('${getString().xzbz}', style: TextStyles.textGrey12),
                          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(4)),
                        ),
                        Gaps.hGap10,
                        LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                      ],
                    )),
                onTap: () {
                  Navigator.pushNamed(context, PageTransactionRouter.select_currency_page, arguments: Bundle()..putInt('type', 2)).then((value) {
                    if (value != null) coin = value;
                    if (mounted) setState(() {});
                  });
                },
              ),
              Gaps.vGap40,
              Text('${getString().zzdz}', style: TextStyles.textBlack12),
              Stack(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
                    child: TextField(
                      autofocus: false,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[ZA-ZZa-z0-9_.]"))],
                      controller: addressController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
                      cursorColor: Colours.textBlack,
                      decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().qsrdduifdz1}${coin}${getString().qsrdduifdz2}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(32))),
                      onChanged: (s) {
                        if (numberController.text.length != 0 && addressController.text.length != 0)
                          isUse = true;
                        else
                          isUse = false;
                        setState(() {});
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: InkResponse(
                      child: LoadImage('sys', width: ScreenUtil().setWidth(32)),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (Platform.isAndroid) {
                          await Permission.camera.request().then((value) {
                            if ( value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
                              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().kqxjqxsb}');
                              return;
                            }
                          });
                        }
                        FocusScope.of(context).requestFocus(FocusNode());
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colours.transparent,
                            context: context,
                            builder: (builder) {
                              return ScanViewSheetDialog((data) {
                                addressController.text = data;
                                if (numberController.text.length != 0 && addressController.text.length != 0)
                                  isUse = true;
                                else
                                  isUse = false;
                                setState(() {});
                              });
                            });
                      },
                    ),
                    alignment: Alignment.bottomRight),
              ]),
              Divider(height: 0, color: Colours.colorEE),
              Gaps.vGap35,
              Text('${getString().zzsl}', style: TextStyles.textBlack12),
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
                        if (numberController.text.length != 0 && addressController.text.length != 0)
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
                        numberController.text = GlobalTransaction.getAssetsWalletInfo(coin).order_value ?? 0.0;
                        if (numberController.text.length != 0 && addressController.text.length != 0)
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
                  Text('${getString().keyong}${GlobalTransaction.getAssetsWalletInfo(coin)?.order_value ?? 0.0} ${coin}', style: TextStyles.textGrey12),
                  Text(walletAssets == null ? '' : '${getString().sxf}：${getFree()}', style: TextStyles.textGrey12),
                  // Text('${getString().kgf}0.001 ${Global.coin}', style: TextStyles.textGrey12),
                ],
              ),
              // Gaps.vGap10,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Text('', style: TextStyles.textGrey12),
              //     Text(walletAssets == null ? '' : '${getString().sxf}：${getFree()}', style: TextStyles.textGrey12),
              //   ],
              // ),
              Gaps.vGap10,
              Gaps.vGap50,
              Buttons.getDetermineButton(
                  isUse: isUse,
                  voidCallback: () {
                    if (addressController.text.length == 0) {
                      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qsrtbdz}");
                      return;
                    }
                    if (numberController.text.length == 0) {
                      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qsrtbsl}");
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (_) => InputPasswordDialog((data) {
                              if (data == GlobalTransaction.walletPassword) {
                                transfer();
                              } else {
                                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().nsrdmmcw}');
                              }
                            }));
                  }),
            ],
          )),
    );
  }

  getFree() {
    if (walletAssets == null) {
      return '';
    } else if (walletAssets.payment_fee_percent == null) {
      return '${walletAssets.payment_fee} ${walletAssets.payment_currency}';
    } else {
      if (numberController.text == '') return '${walletAssets.payment_fee_percent} ${walletAssets.payment_currency}';
      try {
        String ls = (double.parse(walletAssets.payment_fee_percent) * double.parse(numberController.text)).toString();
        ls.contains('e') ? ls = '0' : ls = ls;
        if ((walletAssets.payment_currency == GlobalTransaction.coin) && NumUtil.formatNum(ls, 4) > 2) {
          return '2 ${walletAssets.payment_currency}';
        } else
          return '${NumUtil.formatNum(ls, 4)} ${walletAssets.payment_currency}';
      } catch (e) {
        return '${walletAssets.payment_fee} ${walletAssets.payment_currency}';
      }
    }
  }

  transfer() {
    if (addressController.text == GlobalTransaction.walletInfo.account_id) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().bnzzzj}');
      return;
    }
    // if (double.parse(numberController.text) > double.parse(Global.getAssetsWalletInfo(coin).order_value)) {
    //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().yueebuz}');
    //   return;
    // }
    // if (double.parse(numberController.text) - (double.parse(Global.getAssetsWalletInfo(coin).order_value) - 0.001) > 0) {
    //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: 'DEC最少保留0.001余额');
    //   return;
    // }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.PAYMENT, {'currency': coin, 'to': addressController.text, 'amount': numberController.text}, success: (data) {
      GlobalTransaction.refreshWalletAssets();
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().zzcgl}');
      Navigator.pop(context);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
    // initEvent();
    // LayoutUtil.showLoadingDialog(context);
    // RippleWebSocket().accountInfo(addressController.text, id: 'transfer_account_info');
  }
}
