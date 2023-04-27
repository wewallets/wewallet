import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletPropose.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/wallet_manage_dialog.dart';

//创建钱包
class CreateWalletPage extends StatefulWidget {
  final Bundle bundle;

  CreateWalletPage(this.bundle);

  @override
  _CreateWalletPageState createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController pwd1Controller = new TextEditingController();
  TextEditingController pwd2Controller = new TextEditingController();
  bool isPwd1 = false;
  bool isPwd2 = false;
  bool isUse = false;
  int type = 0; // 0正常创建 1不显示密码创建 2不显示昵称 3旧地址导入不输入密码
  bool isBackup = false;
  bool isHome = false;
  WalletPropose walletPropose;

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('type')) {
      type = widget.bundle.getInt('type');
    }
    if (widget.bundle != null && widget.bundle.isContainsKey('isBackup')) isBackup = widget.bundle.getBool('isBackup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.white,
        appBar: LayoutUtil.getAppBar(context, '${getString().cjqbdiz}'),
        body: ListView(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(80), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          children: <Widget>[
            type == 2 || isBackup == true || type == 3 ? Container() : Text('${getString().qbnc}', style: TextStyles.textBlack12),
            type == 2 || isBackup == true || type == 3
                ? Container()
                : TextField(
                    autofocus: false,
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
                    cursorColor: Colours.textBlack,
                    decoration: InputDecoration(counterText: '', border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().qsrqbnc}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                    onChanged: (s) {
                      if (type == 1 || type == 3) {
                        if (nameController.text.length != 0) {
                          isUse = true;
                        } else {
                          isUse = false;
                        }
                        setState(() {});
                      }
                    },
                  ),
            type == 2 ? Container() : Divider(height: 0, color: Colours.colorEE),
            type == 1 || type == 3 ? Container() : Gaps.vGap20,
            type == 1 || type == 3 ? Container() : Text('${getString().szmm}', style: TextStyles.textBlack12),
            type == 1 || type == 3
                ? Container()
                : Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                            child: TextField(
                              autofocus: false,
                              controller: pwd1Controller,
                              style: TextStyles.textBlack14,
                              cursorColor: Colours.textBlack,
                              onChanged: (String value) {
                                if (type == 2) {
                                  if (nameController.text.length != 0) {
                                    isUse = true;
                                  } else {
                                    isUse = false;
                                  }
                                  setState(() {});
                                }
                              },
                              obscureText: !isPwd1,
                              maxLength: 20,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9-*/+.~!@#\$%^&*()]"))],
                              decoration: InputDecoration(counterText: '', border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().szmmcd}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                            ))),
                    InkWell(
                      child: LoadImage(isPwd1 ? Images.asset_eye1 : Images.asset_eyg1, width: ScreenUtil().setWidth(32)),
                      onTap: () {
                        setState(() {
                          isPwd1 = !isPwd1;
                        });
                      },
                    ),
                  ]),
            type == 1 || type == 3 ? Container() : Divider(height: 0, color: Colours.colorEE),
            type == 1 || type == 3 ? Container() : Gaps.vGap20,
            type == 1 || type == 3 ? Container() : Text('${getString().zqdmm}', style: TextStyles.textBlack12),
            type == 1 || type == 3
                ? Container()
                : Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                            child: TextField(
                              autofocus: false,
                              controller: pwd2Controller,
                              style: TextStyles.textBlack14,
                              cursorColor: Colours.textBlack,
                              onChanged: (String value) {
                                if (type == 0) {
                                  if ((nameController.text.length != 0 || isBackup == true) && pwd1Controller.text.length != 0 && pwd2Controller.text.length != 0) {
                                    isUse = true;
                                  } else {
                                    isUse = false;
                                  }
                                  setState(() {});
                                } else if (type == 2) {
                                  if (pwd1Controller.text.length != 0 && pwd2Controller.text.length != 0) {
                                    isUse = true;
                                  } else {
                                    isUse = false;
                                  }
                                  setState(() {});
                                }
                              },
                              obscureText: !isPwd2,
                              maxLength: 20,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9-*/+.~!@#\$%^&*()]"))],
                              decoration: InputDecoration(counterText: '', border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().zcsrxtmm}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                            ))),
                    InkWell(
                      child: LoadImage(isPwd2 ? Images.asset_eye1 : Images.asset_eyg1, width: ScreenUtil().setWidth(32)),
                      onTap: () {
                        setState(() {
                          isPwd2 = !isPwd2;
                        });
                      },
                    )
                  ]),
            Divider(height: 0, color: Colours.colorEE),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(60)),
                child: Buttons.getDetermineButton(
                    isUse: isUse,
                    buttonText: '${getString().cjqbdiz}',
                    voidCallback: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (type == 2) {
                        if (pwd1Controller.text.trim() == '') {
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qsrmm}");
                          return;
                        }
                        if (!RegExp(r"(?=.*([a-zA-Z].*))(?=.*[0-9].*)[a-zA-Z0-9-*/+.~!@#$%^&*()]{6,20}$").hasMatch(pwd1Controller.text.trim())) {
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().mmcgcw}");
                          return;
                        }
                        if (pwd2Controller.text != pwd1Controller.text) {
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qzrsrxtmm}");
                          return;
                        }

                        var walletPropose = widget.bundle.getObject('walletPropose');
                        GlobalTransaction.saveWallet(walletName: widget.bundle.getString('name'), accountId: walletPropose.account_id, masterKey: walletPropose.master_key, masterSeed: walletPropose.master_seed);
                        GlobalTransaction.saveWalletPassword(pwd2Controller.text);

                        Navigator.pushReplacementNamed(context, PageTransactionRouter.main_page);
                      } else if (type == 0) {
                        if (nameController.text.trim() == '' && isBackup != true) {
                                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qsrqbnc}");
                          return;
                        }
                        if (pwd1Controller.text.trim() == '') {
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qsrmm}");
                          return;
                        }
                        if (!RegExp(r"(?=.*([a-zA-Z].*))(?=.*[0-9].*)[a-zA-Z0-9-*/+.~!@#$%^&*()]{6,20}$").hasMatch(pwd1Controller.text.trim())) {
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().mmcgcw}");
                          return;
                        }
                        if (pwd2Controller.text != pwd1Controller.text) {
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qzrsrxtmm}");
                          return;
                        }
                        if (isUse) {
                          if (isBackup == true) {
                            LayoutUtil.showLoadingDialog(context);
                            Net().post(ApiTransaction.UPDATE_MEMONIC, {'ajm_address': widget.bundle.getString('ajm_address'), 'propose': widget.bundle.getString('propose')}, isLogin: false, success: (data) {
                              WalletPropose walletPropose = WalletPropose();
                              walletPropose.account_id = data['address'];
                              walletPropose.master_seed = RESUtil.decrypt(data['secret']);
                              walletPropose.master_key = RESUtil.decrypt(data['propose']);

                              Net().post(ApiTransaction.ADDRESS_INFO, {'account': '${walletPropose.account_id}'}, isLogin: false, success: (data) {
                                LayoutUtil.closeLoadingDialog(context);
                                scheduleMicrotask(() {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, PageTransactionRouter.mnemonic_backup_page,
                                      arguments: Bundle()
                                        ..putObject('walletPropose', walletPropose)
                                        ..putString('name', data['nick_name'] == null ? data['ripple_address'].toString().substring(0, 6) : data['nick_name'])
                                        ..putString('pwd', pwd2Controller.text)
                                        ..putBool('isBackup', isBackup)
                                        ..putInt('type', 1));
                                });
                                Navigator.pop(context);
                              }, failure: (error) {
                                LayoutUtil.closeLoadingDialog(context);
                                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                              });
                            }, failure: (error) {
                              LayoutUtil.closeLoadingDialog(context);
                              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                            });
                          } else {
                            Navigator.pushNamed(context, PageTransactionRouter.mnemonic_backup_page, arguments: Bundle()..putString('name', nameController.text)..putString('pwd', pwd2Controller.text));
                          }
                        }
                      } else if (type == 3) {
                        if (nameController.text.trim() == '') {
                        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qsrqbnc}");
                          return;
                        }
                        if (isUse) {
                          var walletPropose = widget.bundle.getObject('walletPropose');

                          Net().post(ApiTransaction.ADDRESS_INFO_EDIT, {'account': walletPropose.account_id, 'nick_name': '${nameController.text}'}, isLogin: false, success: (data) {
                            GlobalTransaction.saveWallet(walletName: nameController.text, accountId: walletPropose.account_id, masterKey: walletPropose.master_key, masterSeed: walletPropose.master_seed);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, PageTransactionRouter.mnemonic_backup_page,
                                arguments: Bundle()
                                  ..putObject('walletPropose', walletPropose)
                                  ..putString('name', nameController.text)
                                  ..putString('pwd', pwd2Controller.text)
                                  ..putInt('type', 1));
                          }, failure: (error) {
                            Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "$error");
                          });
                        }
                      } else if (type == 1) {
                        if (nameController.text.trim() == '') {
                         Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().qsrqbnc}");
                          return;
                        }
                        if (isUse) {
                          showDialog(
                              context: context,
                              builder: (_) => WalletManageDialog((password) {
                                    if (GlobalTransaction.walletPassword == password) {
                                      LayoutUtil.showLoadingDialog(context);
                                      Net().post(ApiTransaction.CREATE_ADDRESS, null, success: (data) {
                                        LayoutUtil.closeLoadingDialog(context);
                                        walletPropose = WalletPropose();
                                        walletPropose.account_id = data['address'];
                                        walletPropose.master_seed = RESUtil.decrypt(data['secret']);
                                        walletPropose.master_key = RESUtil.decrypt(data['propose']);

                                        Net().post(ApiTransaction.ADDRESS_INFO_EDIT, {'account': walletPropose.account_id, 'nick_name': '${nameController.text}'}, isLogin: false, success: (data) {
                                          GlobalTransaction.saveWallet(walletName: nameController.text, accountId: walletPropose.account_id, masterKey: walletPropose.master_key, masterSeed: walletPropose.master_seed);

                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, PageTransactionRouter.mnemonic_backup_page,
                                              arguments: Bundle()
                                                ..putString('name', nameController.text)
                                                ..putInt('type', 1)
                                                ..putObject('walletPropose', walletPropose));

                                          EventBus().send('refreshAddressManage', true);
                                        }, failure: (error) {
                                          LayoutUtil.closeLoadingDialog(context);
                                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "$error");
                                        });
                                      }, failure: (error) {
                                        LayoutUtil.closeLoadingDialog(context);
                                        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "${getString().scdzsb}");
                                      });
                                    } else {
                                      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().nsrdmmcw}');
                                    }
                                  }, title: '${getString().cjqbdz}'));
                        }
                      }
                    })),
          ],
        ));
  }
}
