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
class WithdrawCoinBrtPage extends StatefulWidget {
  final Bundle bundle;

  WithdrawCoinBrtPage(this.bundle);

  @override
  _WithdrawCoinBrtPageState createState() => _WithdrawCoinBrtPageState();
}

class _WithdrawCoinBrtPageState extends State<WithdrawCoinBrtPage> {
  TextEditingController numberController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();

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
    getAddress();
  }

  initCoinList() {
    walletAssets = widget.bundle.getObject('assetsItem');
    coin = walletAssets.net_currency_name;
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
          Text('提币', style: Styles.textHeadline),
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
                    //   child: Text('选择币种', style: TextStyles.textGrey12),
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
          // Gaps.vGap20,
          Row(
            children: <Widget>[
              // InkWell(
              //     onTap: () {},
              //     child: Container(
              //       alignment: Alignment.center,
              //       width: ScreenUtil().setWidth(154),
              //       height: ScreenUtil().setWidth(60),
              //       decoration: BoxDecoration(
              //         color: Colours.themeColor,
              //         borderRadius: BorderRadius.all(Radius.circular(3)),
              //         border: Border.all(width: 0.5, color: Colours.themeColor),
              //       ),
              //       child: Text('$inNet', style: TextStyles.textWhite13),
              //     )),
              // Gaps.hGap12,
            ],
          ),
          Gaps.vGap40,
          Text('提币数量', style: TextStyles.textBlack12),
          Stack(children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(100)),
                child: TextField(
                  autofocus: false,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
                  cursorColor: Colours.textBlack,
                  decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入数量', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyle(color: Colors.black, fontSize: 16)),
                  onChanged: (s) {
                    try {
                      if (double.parse(numberController.text) <= 0.0) {
                        quantityOfArrival = "0";
                      } else {
                        quantityOfArrival = NumUtil.getNumByValueDouble((double.parse(numberController.text) - 0.001), 4).toString();
                      }
                      if (double.parse(quantityOfArrival) <= 0.0) {
                        quantityOfArrival = "0";
                      }
                    } catch (e) {
                      quantityOfArrival = "0";
                    }
                    if (remarksController.text.length != 0 && numberController.text.length != 0)
                      isUse = true;
                    else
                      isUse = false;
                    if (mounted) setState(() {});
                  },
                )),
            Container(
                margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  InkResponse(
                    child: Text('$coin', style: TextStyles.textGrey614),
                    onTap: () {},
                  ),
                  Container(height: ScreenUtil().setWidth(20), color: Colours.colorEE, width: 0.5, margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20))),
                  InkResponse(
                    child: Text('全部', style: TextStyles.textGrey614),
                    onTap: () {
                      try {
                        if (double.parse(numberController.text) <= 0.0) {
                          quantityOfArrival = "0";
                        } else {
                          quantityOfArrival = NumUtil.getNumByValueDouble((double.parse(numberController.text) - 1), 4).toString();
                        }
                        if (double.parse(quantityOfArrival) <= 0.0) {
                          quantityOfArrival = "0";
                        }
                      } catch (e) {
                        quantityOfArrival = "0";
                      }

                      numberController.text = (NumUtil.getNumByValueStr(GlobalTransaction.getAssetsWalletInfo(coin).order_value, fractionDigits: 4) - 1).toString();
                      if (mounted) setState(() {});
                    },
                  ),
                ]),
                alignment: Alignment.bottomRight),
          ]),
          Divider(height: 0, color: Colours.colorEE),
          Gaps.vGap15,
          Text('备注名称', style: TextStyles.textBlack12),
          TextField(
            autofocus: true,
            onChanged: (s) {
              try {
                if (double.parse(numberController.text) <= 0.0) {
                  quantityOfArrival = "0";
                } else {
                  quantityOfArrival = NumUtil.getNumByValueDouble((double.parse(numberController.text) - 1), 4).toString();
                }
                if (double.parse(quantityOfArrival) <= 0.0) {
                  quantityOfArrival = "0";
                }
              } catch (e) {
                quantityOfArrival = "0";
              }
              if (remarksController.text.length != 0 && numberController.text.length != 0)
                isUse = true;
              else
                isUse = false;
              if (mounted) setState(() {});
            },
            controller: remarksController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
            cursorColor: Colours.textBlack,
            decoration: InputDecoration(counterText: '', border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入备注名称', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
          ),
          Divider(height: 0, color: Colours.colorEE),
          Gaps.vGap15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('可用：${GlobalTransaction.getAssetsWalletInfo(coin).order_value} $coin', style: TextStyles.textTheme12),
              Text('到账数量：$quantityOfArrival $coin', style: TextStyles.textGrey12),
            ],
          ),
          Gaps.vGap5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('', style: TextStyles.textTheme12),
              Text('矿工费：1 $coin', style: TextStyles.textGrey12),
            ],
          ),
          Gaps.vGap30,
          Container(
            decoration: BoxDecoration(color: Colours.color107854D5, borderRadius: BorderRadius.all(Radius.circular(8))),
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('提币须知', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold)),
                Gaps.vGap15,
                Text('${walletAssets.content}', style: TextStyles.textBlack12.copyWith(height: 1.5)),
              ],
            ),
          ),
          Gaps.vGap50,
          Buttons.getDetermineButton(
              isUse: isUse,
              voidCallback: () {
                if (numberController.text.length == 0) {
                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "请输入提币数量");
                  return;
                }
                if (quantityOfArrival == "0") {
                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "请输入正确提币数量");
                  return;
                }
                // if (double.parse(numberController.text) > double.parse(walletAssets.max_out_number)) {
                //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "最大提币数量：${walletAssets.max_out_number}");
                //   return;
                // }
                // if (double.parse(numberController.text) < double.parse(walletAssets.min_out_number)) {
                //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "最小提币数量：${walletAssets.min_out_number}");
                //   return;
                // }
                showDialog(
                    context: context,
                    builder: (_) => InputPasswordDialog((data) {
                          if (data == GlobalTransaction.walletPassword) {
                            transfer();
                          } else {
                            Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '您输入的密码错误~');
                          }
                        }));
              }),
          Gaps.vGap50,
        ],
      ),
    );
  }

  getAddress() {
    if (SpUtil.hasKey('in_address_$coin')) {
      inNet = SpUtil.getString('in_net_$coin');
      if (mounted) setState(() {});
    }
    Net().post(ApiTransaction.GET_IN_ADDRESS, {'account': GlobalTransaction.walletInfo.account_id, 'currency': coin}, success: (data) {
      inNet = data['in_net'];
      SpUtil.putString('in_net_$coin', inNet);

      if (mounted) setState(() {});
    });
  }

  transfer() {
    if (double.parse(numberController.text) > double.parse(GlobalTransaction.getAssetsWalletInfo(coin).order_value)) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$coin余额不足');
      return;
    }
    if (remarksController.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请填写备注名称');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.OUT_ORDER_BRT, {'amount': numberController.text, 'remark': remarksController.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '提币操作成功，处理中');
      Navigator.pop(context);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }
}
