import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/walletAssets.dart';
import 'package:mars/models/walletPropose.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';
import 'package:mars/widgets/dialog/scan_view_sheet_dialog.dart';
import 'package:mars/widgets/dialog/selection_tips_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

//提现
class WithdrawCoinPage extends StatefulWidget {
  final Bundle bundle;

  WithdrawCoinPage(this.bundle);

  @override
  _WithdrawCoinPageState createState() => _WithdrawCoinPageState();
}

class _WithdrawCoinPageState extends State<WithdrawCoinPage> {
  TextEditingController addressController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController xrpTagController = new TextEditingController();

  WalletAssets walletAssets;

  //币种
  String coin;
  String quantityOfArrival = '0';

  bool isUse = false;
  String inNet;

  @override
  void initState() {
    super.initState();
    initCoinList();
  }

  initCoinList() {
    walletAssets = widget.bundle.getObject('assetsItem');

    coin = walletAssets.net_currency_name;
    if (coin == 'USDT') inNet = 'TRC20';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: LayoutUtil.getAppBar(context, '',
          // actions: <Widget>[
          //   InkResponse(
          //     onTap: () {},
          //     child: LoadImage(Images.coin_record, width: ScreenUtil().setWidth(32), height: ScreenUtil().setWidth(36), fit: BoxFit.contain),
          //   ),
          //   Gaps.hGap15,
          // ],
          elevation: 0.0),
      body: ListView(
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(0), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
        children: <Widget>[
          Text('${getString().tb}', style: Styles.textHeadline),
          Gaps.vGap20,
          InkWell(
            child: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setWidth(88),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(color: Colours.colorF6, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Text('$coin', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.w500))),
                    // Padding(
                    //   child: Text('${getString().xzbz}', style: TextStyles.textGrey12),
                    //   padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(4)),
                    // ),
                    // Gaps.hGap10,
                    // LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                  ],
                )),
            onTap: () {
              // Navigator.pushNamed(context, PageRouter.select_currency_page).then((value) {
              //   if (value != null) coin = value;
              //   setState(() {});
              // });
            },
          ),
          inNet == null ? Container() : Gaps.vGap20,
          inNet == null
              ? Container()
              : Row(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          inNet = 'ERC20';
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(154),
                          height: ScreenUtil().setWidth(60),
                          decoration: inNet == 'ERC20'
                              ? BoxDecoration(
                                  color: Colours.themeColor,
                                  borderRadius: BorderRadius.all(Radius.circular(3)),
                                  border: Border.all(width: 0.5, color: Colours.themeColor),
                                )
                              : BoxDecoration(
                                  color: Colours.white,
                                  borderRadius: BorderRadius.all(Radius.circular(3)),
                                  border: Border.all(width: 0.5, color: Colours.themeColor),
                                ),
                          child: Text('ERC20', style: inNet == 'ERC20' ? TextStyles.textWhite13 : TextStyles.textBlack13),
                        )),
                    Gaps.hGap12,
                    coin != 'USDT'
                        ? Container()
                        : InkWell(
                            onTap: () {
                              inNet = 'TRC20';
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: ScreenUtil().setWidth(154),
                              height: ScreenUtil().setWidth(60),
                              decoration: inNet == 'TRC20'
                                  ? BoxDecoration(
                                      color: Colours.themeColor,
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      border: Border.all(width: 0.5, color: Colours.themeColor),
                                    )
                                  : BoxDecoration(
                                      color: Colours.white,
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      border: Border.all(width: 0.5, color: Colours.themeColor),
                                    ),
                              child: Text('TRC20', style: inNet == 'TRC20' ? TextStyles.textWhite13 : TextStyles.textBlack13),
                            )),
                    Gaps.hGap12,
                    coin != 'USDT'
                        ? Container()
                        : InkWell(
                            onTap: () {
                              inNet = 'BSC';
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: ScreenUtil().setWidth(154),
                              height: ScreenUtil().setWidth(60),
                              decoration: inNet == 'BSC'
                                  ? BoxDecoration(
                                      color: Colours.themeColor,
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      border: Border.all(width: 0.5, color: Colours.themeColor),
                                    )
                                  : BoxDecoration(
                                      color: Colours.white,
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      border: Border.all(width: 0.5, color: Colours.themeColor),
                                    ),
                              child: Text('BSC', style: inNet == 'BSC' ? TextStyles.textWhite13 : TextStyles.textBlack13),
                            )),
                  ],
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
                    if (addressController.text.length != 0 && numberController.text.length != 0)
                      isUse = true;
                    else
                      isUse = false;
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
                          Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().kqxjqxsb}');
                          return;
                        }
                      });
                    }
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colours.transparent,
                        context: context,
                        builder: (builder) {
                          return ScanViewSheetDialog((data) {
                            addressController.text = data;
                            if (addressController.text.length != 0 && numberController.text.length != 0)
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
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(100)),
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
                    try {
                      if (double.parse(numberController.text) <= 0.0) {
                        quantityOfArrival = "0";
                      } else {
                        quantityOfArrival = NumUtil.getNumByValueDouble((double.parse(numberController.text) - (double.parse(inNet == 'TRC20' ? walletAssets.tron_service_charge : walletAssets.service_charge))), 4).toString();
                      }
                      if (double.parse(quantityOfArrival) <= 0.0) {
                        quantityOfArrival = "0";
                      }
                    } catch (e) {
                      quantityOfArrival = "0";
                    }
                    if (addressController.text.length != 0 && numberController.text.length != 0)
                      isUse = true;
                    else
                      isUse = false;
                    if (mounted) setState(() {});
                  },
                )),
            Container(
                margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkResponse(
                      child: Text('$coin', style: TextStyles.textGrey614),
                      onTap: () {},
                    ),
                    Container(height: ScreenUtil().setWidth(20), color: Colours.colorEE, width: 0.5, margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20))),
                    InkResponse(
                      child: Text('${getString().qbb}', style: TextStyles.textGrey614),
                      onTap: () {
                        numberController.text = NumUtil.getNumByValueStr(GlobalTransaction.getAssetsWalletInfo(coin).order_value, fractionDigits: 4).toString();
                        if (mounted) setState(() {});
                      },
                    ),
                  ],
                ),
                alignment: Alignment.bottomRight),
          ]),
          Divider(height: 0, color: Colours.colorEE),
          !walletAssets.net_currency_name.contains('XRP') ? Container() : Gaps.vGap35,
          !walletAssets.net_currency_name.contains('XRP') ? Container() : Text('XRPTag', style: TextStyles.textBlack12),
          !walletAssets.net_currency_name.contains('XRP')
              ? Container()
              : Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(100)),
                  child: TextField(
                    autofocus: false,
                    controller: xrpTagController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
                    cursorColor: Colours.textBlack,
                    decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: 'XRPTag', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(32))),
                  )),
          !walletAssets.net_currency_name.contains('XRP') ? Container() : Divider(height: 0, color: Colours.colorEE),
          Gaps.vGap15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${getString().keyong}${GlobalTransaction.getAssetsWalletInfo(coin).order_value} $coin', style: TextStyles.textTheme12),
              Text('${getString().tbdasl}$quantityOfArrival $coin', style: TextStyles.textGrey12),
            ],
          ),
          Gaps.vGap5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('', style: TextStyles.textTheme12),
              Text('${getString().kuanggongfei}${inNet == 'TRC20' ? walletAssets.tron_service_charge : walletAssets.service_charge} $coin', style: TextStyles.textGrey12),
            ],
          ),
          Gaps.vGap30,
          walletAssets.net_currency_name == GlobalTransaction.coin
              ? Container()
              : Container(
                  decoration: BoxDecoration(color: Colours.color107854D5, borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('${getString().tbxuzd}', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)),
                      Gaps.vGap15,
                      Text('${inNet == 'TRC20' ? (getLocaleType() ? walletAssets.tron_content : walletAssets.tron_content_en) : (getLocaleType() ? walletAssets.content : walletAssets.content_en)}', style: TextStyles.textBlack12.copyWith(height: 1.5)),
                    ],
                  ),
                ),
          Gaps.vGap50,
          Buttons.getDetermineButton(
              isUse: numberController.text != '' && addressController.text != '',
              voidCallback: () {
                if (addressController.text.length == 0) {
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qsrtbdz}");
                  return;
                }
                if (numberController.text.length == 0) {
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qsrtbsl}");
                  return;
                }
                if (quantityOfArrival == "0") {
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qsrzqtbsl}');
                  return;
                }
                if (double.parse(numberController.text) > double.parse(walletAssets.max_out_number)) {
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "最大提币数量：${walletAssets.max_out_number}");
                  return;
                }
                if (double.parse(numberController.text) < double.parse(walletAssets.min_out_number)) {
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "最小提币数量：${walletAssets.min_out_number}");
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
          Gaps.vGap50,
        ],
      ),
    );
  }

  transfer() {
    if (double.parse(numberController.text) > double.parse(GlobalTransaction.getAssetsWalletInfo(coin).order_value)) {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$coin余额不足');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(GlobalTransaction.coin == walletAssets.net_currency_name ? ApiTransaction.out_order_eae : ApiTransaction.OUT_ORDER, {'currency': coin, 'out_address': addressController.text, 'amount': numberController.text, 'in_net': inNet, 'xrp_tag': xrpTagController.text}, success: (data) {
      GlobalTransaction.refreshWalletAssets();
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().tbcgclz}');
      Navigator.pop(context);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$error');
    });

    // initEvent();
    // LayoutUtil.showLoadingDialog(context);
    // RippleWebSocket().withdrawCoin(
    //   secret: Global.walletInfo.master_seed,
    //   destination: walletAssets.net_account,
    //   account: Global.walletInfo.account_id,
    //   value: double.parse(numberController.text) + double.parse(walletAssets.service_charge),
    //   issuer: walletAssets.net_account,
    //   currency: coin,
    // );
  }

  outOrder() {
    // Net().post(Api.OUT_ORDER, {'account': Global.walletInfo.account_id, 'out_address': addressController.text, 'currency': coin, 'hash': hash, 'amount': double.parse(numberController.text) + double.parse(walletAssets.service_charge)}, success: (data) {
    //   LayoutUtil.closeLoadingDialog(context);
    //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '提币成功');
    //   Navigator.pop(context);
    //   if (mounted) setState(() {});
    // }, failure: (error) {
    //   LayoutUtil.closeLoadingDialog(context);
    //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    // });
  }
}
