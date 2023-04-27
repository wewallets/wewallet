import 'dart:async';
import 'dart:io';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/event_bus.dart';
import 'package:mars/models/back_address_list_entity.dart';
import 'package:mars/models/walletPropose.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/scan_view_sheet_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

//导入钱包
class ImportWalletPage extends StatefulWidget {
  final Bundle bundle;

  ImportWalletPage(this.bundle);

  @override
  _ImportWalletPageState createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  int state = 0; //0:助记词 1:私钥 2:旧地址导入 3:旧地址导入不输入密码
  int type = 0;
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController dTEC = new TextEditingController();
  TextEditingController syTEC = new TextEditingController();
  bool isZJLegal = false;
  bool isSYLegal = false;

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('type')) type = widget.bundle.getInt('type');

    // initEvent();
  }

  @override
  void dispose() {
    RippleWebSocket.off();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, '${getString().daoruqb}', actions: [
          InkResponse(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
                child: Row(children: [
                  LoadImage('sys', width: ScreenUtil().setWidth(32)),
                ])),
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
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colours.transparent,
                  context: context,
                  builder: (builder) {
                    return ScanViewSheetDialog((data) {
                      if (state == 0) {
                        dTEC.text = data ?? '';
                      } else {
                        syTEC.text = data ?? '';
                      }
                      checkPage();
                    });
                  });
            },
          )
        ]),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(35)),
              child: Row(
                children: [
                  InkWell(
                    child: Text(
                      '${getString().zhujic}',
                      style: state == 0 ? TextStyles.textTheme20.copyWith(fontWeight: FontWeight.bold) : TextStyle(color: Colours.colorB8B1CF, fontSize: ScreenUtil().setSp(32)),
                    ),
                    onTap: () {
                      if (state == 1) {
                        setState(() {
                          state = 0;
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                  ),
                  type == 2 || type == 3
                      ? Container()
                      : InkWell(
                          child: Text(
                             '${getString().sy}',
                            style: state == 1 ? TextStyles.textTheme20.copyWith(fontWeight: FontWeight.bold) : TextStyle(color: Colours.colorB8B1CF, fontSize: ScreenUtil().setSp(32)),
                          ),
                          onTap: () {
                            if (state == 0) {
                              setState(() {
                                state = 1;
                              });
                            }
                          },
                        )
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            //   height: ScreenUtil().setWidth(88),
            //   decoration: BoxDecoration(color: Colours.colorF6, borderRadius: BorderRadius.all(Radius.circular(6))),
            //   padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            //   child: TextField(
            //     maxLines: 1,
            //     controller: nameTEC,
            //     onChanged: (v) {
            //       checkPage();
            //     },
            //     decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().sheznictis}', hintStyle: TextStyles.textB4B4B430),
            //     keyboardType: TextInputType.text,
            //     textInputAction: TextInputAction.done,
            //     style: TextStyles.textBlack15,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(10), bottom: ScreenUtil().setWidth(120)),
              height: ScreenUtil().setWidth(240),
              decoration: BoxDecoration(color: Colours.colorF6, borderRadius: BorderRadius.all(Radius.circular(6))),
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child: TextField(
                textAlign: TextAlign.left,
                maxLines: 100,
                keyboardType: TextInputType.multiline,
                controller: state == 0 ? dTEC : syTEC,
                onChanged: (v) {
                  checkPage();
                },
              decoration: InputDecoration(border: InputBorder.none, hintText: state == 0 ? '${getString().shezzzjts}' : '${getString().qingshurushiyao}', hintStyle: TextStyles.textB4B4B430),
                textInputAction: TextInputAction.none,
                style: TextStyles.textBlack15,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                child: Buttons.getDetermineButton(
                    isUse: state == 0 ? isZJLegal : isSYLegal,
                    buttonText: '${getString().qd}',
                    voidCallback: () {
                      import();
                    })),
          ],
        ));
  }

  checkPage() {
    if (state == 0) {
      if (dTEC.text.length == 0) {
        isZJLegal = false;
      } else {
        isZJLegal = true;
      }
    } else {
      if (syTEC.text.length == 0) {
        isSYLegal = false;
      } else {
        isSYLegal = true;
      }
    }
    if (mounted) setState(() {});
  }

  import() {
    // if (nameTEC.text.length == 0) {
    //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请您输入钱包昵称～');
    //   return;
    // }
    if (state == 0 && dTEC.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qnshurzjc}');
      return;
    }
    if (state == 1 && syTEC.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qnsrsy}');
      return;
    }
    if (GlobalTransaction.walletInfoList != null) {
      if (state == 0 && GlobalTransaction.getWalletInfo(masterKey: dTEC.text) != null) {
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().bncwtjdz}');
        return;
      } else if (state == 1 && GlobalTransaction.getWalletInfo(masterSeed: syTEC.text) != null) {
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().bncwtjdz}');
        return;
      }
    }
    if (type == 2 || type == 3) {
      LayoutUtil.showLoadingDialog(context);
      Net().post(ApiTransaction.BACK_ADDRESS_LIST, {'propose': dTEC.text}, success: (data) {
        LayoutUtil.closeLoadingDialog(context);

        List<BackAddressListEntity> list = [];
        data.forEach((v) {
          list.add(BackAddressListEntity().fromJson(v));
        });
        scheduleMicrotask(() {
          Navigator.pushNamed(context, PageTransactionRouter.choose_old_address_page,
              arguments: Bundle()
                ..putList('list', list)
                ..putString('propose', dTEC.text)
                ..putInt('type', type));
        });

        Navigator.pop(context);
      }, failure: (error) {
        LayoutUtil.closeLoadingDialog(context);
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
      });
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.BACK_ADDRESS, state == 0 ? {'propose': RESUtil.encryption(dTEC.text)} : {'secret': RESUtil.encryption(syTEC.text)}, isLogin: false, success: (data) {
      WalletPropose walletPropose = WalletPropose();
      walletPropose.account_id = data['address'];
      walletPropose.master_seed = RESUtil.decrypt(data['secret']);
      walletPropose.master_key = RESUtil.decrypt(data['propose']);
      if (type == 1) {
        Net().post(ApiTransaction.ADDRESS_INFO, {'account': '${walletPropose.account_id}'}, isLogin: false, success: (data) {
          LayoutUtil.closeLoadingDialog(context);

          GlobalTransaction.saveWallet(walletName: data['nick_name'] == null ? data['ripple_address'].toString().substring(0, 6) : data['nick_name'], accountId: walletPropose.account_id, masterKey: walletPropose.master_key, masterSeed: walletPropose.master_seed);
          Navigator.pop(context);
        }, failure: (error) {
          LayoutUtil.closeLoadingDialog(context);
          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
        });
      } else if (type == 0) {
        Net().post(ApiTransaction.ADDRESS_INFO, {'account': '${walletPropose.account_id}'}, isLogin: false, success: (data) {
          LayoutUtil.closeLoadingDialog(context);
          scheduleMicrotask(() {
            Navigator.pushNamed(context, PageTransactionRouter.create_wallet_page,
                arguments: Bundle()
                  ..putObject('walletPropose', walletPropose)
                  ..putString('name', data['nick_name'] == null ? data['ripple_address'].toString().substring(0, 6) : data['nick_name'])
                  ..putInt('type', 2));
          });
          Navigator.pop(context);
        }, failure: (error) {
          LayoutUtil.closeLoadingDialog(context);
          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
        });
      }
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
    // if (state == 1)
    //   RippleWebSocket().walletImport(syTEC.text);
    // else
    //   RippleWebSocket().validationCreate(dTEC.text);
  }
}
