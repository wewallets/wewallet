import 'dart:async';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/back_address_list_entity.dart';
import 'package:mars/models/walletPropose.dart';

//导入旧地址
class ChooseOldAddressPage extends StatefulWidget {
  final Bundle bundle;

  ChooseOldAddressPage(this.bundle);

  @override
  _ChooseOldAddressPageState createState() => _ChooseOldAddressPageState();
}

class _ChooseOldAddressPageState extends State<ChooseOldAddressPage> {
  List<BackAddressListEntity> list = [];
  int type = 0;

  @override
  void initState() {
    super.initState();
    list = widget.bundle.getList('list');
    if (widget.bundle != null && widget.bundle.isContainsKey('type')) type = widget.bundle.getInt('type');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().daoruqb}'),
      body: listViewBuilder(
          itemCount: list.length,
          padding: EdgeInsets.all(adaptationDp(15)),
          itemBuilder: (context, index) {
            return inkButton(
                onPressed: list[index].beenFound == '1'
                    ? null
                    : () {
                        if (type == 3) {
                          LayoutUtil.showLoadingDialog(context);
                          Net().post(ApiTransaction.UPDATE_MEMONIC, {'ajm_address': list[index].ajmAddress, 'propose': widget.bundle.getString('propose')}, isLogin: false, success: (data) {
                            WalletPropose walletPropose = WalletPropose();
                            walletPropose.account_id = data['address'];
                            walletPropose.master_seed = RESUtil.decrypt(data['secret']);
                            walletPropose.master_key = RESUtil.decrypt(data['propose']);

                            Net().post(ApiTransaction.ADDRESS_INFO, {'account': '${walletPropose.account_id}'}, isLogin: false, success: (data) {
                              LayoutUtil.closeLoadingDialog(context);
                              scheduleMicrotask(() {
                                GlobalTransaction.saveWallet(walletName: data['nick_name'] == null ? data['ripple_address'].toString().substring(0, 6) : data['nick_name'], accountId: walletPropose.account_id, masterKey: walletPropose.master_key, masterSeed: walletPropose.master_seed);
                                EventBus().send('refreshAddressManage', true);

                                Navigator.pop(context);

                                Navigator.pushNamed(context, PageTransactionRouter.mnemonic_backup_page,
                                    arguments: Bundle()
                                      ..putObject('walletPropose', walletPropose)
                                      ..putInt('type', 3));
                              });
                            }, failure: (error) {
                              LayoutUtil.closeLoadingDialog(context);
                              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                            });
                          }, failure: (error) {
                            LayoutUtil.closeLoadingDialog(context);
                            Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                          });
                        } else {
                          Navigator.pushNamed(context, PageTransactionRouter.create_wallet_page,
                              arguments: Bundle()
                                ..putString('ajm_address', list[index].ajmAddress)
                                ..putString('propose', widget.bundle.getString('propose'))
                                ..putBool('isBackup', true));
                        }
                        // if (type == 3) {
                        //   LayoutUtil.showLoadingDialog(context);
                        //   Net().post(Api.UPDATE_MEMONIC, {'ajm_address':list[index].ajmAddress, 'propose': widget.bundle.getString('propose')}, isLogin: false, success: (data) {
                        //     WalletPropose walletPropose = WalletPropose();
                        //     walletPropose.account_id = data['address'];
                        //     walletPropose.master_seed = RESUtil.decrypt(data['secret']);
                        //     walletPropose.master_key = RESUtil.decrypt(data['propose']);
                        //
                        //     Net().post(Api.ADDRESS_INFO, {'account': '${walletPropose.account_id}'}, isLogin: false, success: (data) {
                        //       LayoutUtil.closeLoadingDialog(context);
                        //       scheduleMicrotask(() {
                        //         Global.saveWallet(walletName: data['nick_name'] == null ? data['ripple_address'].toString().substring(0, 6) : data['nick_name'], accountId: walletPropose.account_id, masterKey: walletPropose.master_key, masterSeed: walletPropose.master_seed);
                        //         EventBus().send('refreshAddressManage', true);
                        //
                        //         Navigator.pop(context);
                        //       });
                        //     }, failure: (error) {
                        //       LayoutUtil.closeLoadingDialog(context);
                        //       Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                        //     });
                        //   }, failure: (error) {
                        //     LayoutUtil.closeLoadingDialog(context);
                        //     Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                        //   });
                        // } else {
                        //   Navigator.pushNamed(context, PageRouter.create_wallet_page,
                        //       arguments: Bundle()
                        //         ..putString('ajm_address', list[index].ajmAddress)
                        //         ..putString('propose', widget.bundle.getString('propose'))
                        //         ..putBool('isBackup', true));
                        // }
                        // LayoutUtil.showLoadingDialog(context);
                        // Net().post(Api.UPDATE_MEMONIC, {'ajm_address': list[index].ajmAddress, 'propose': widget.bundle.getString('propose')}, isLogin: false, success: (data) {
                        //   WalletPropose walletPropose = WalletPropose();
                        //   walletPropose.account_id = data['address'];
                        //   walletPropose.master_seed = RESUtil.decrypt(data['secret']);
                        //   walletPropose.master_key = RESUtil.decrypt(data['propose']);
                        //
                        //   Net().post(Api.ADDRESS_INFO, {'account': '${walletPropose.account_id}'}, isLogin: false, success: (data) {
                        //     LayoutUtil.closeLoadingDialog(context);
                        //     scheduleMicrotask(() {
                        //       Navigator.pushNamed(context, PageRouter.create_wallet_page,
                        //           arguments: Bundle()
                        //             ..putObject('walletPropose', walletPropose)
                        //             ..putString('name', data['nick_name'] == null ? data['ripple_address'].toString().substring(0, 6) : data['nick_name'])
                        //             ..putInt('type', type == 3 ? 3 : 0)
                        //             ..putBool('isBackup', true));
                        //     });
                        //     Navigator.pop(context);
                        //   }, failure: (error) {
                        //     LayoutUtil.closeLoadingDialog(context);
                        //     Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                        //   });
                        // }, failure: (error) {
                        //   LayoutUtil.closeLoadingDialog(context);
                        //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                        // });
                      },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: adaptationDp(15)),
                  padding: EdgeInsets.only(bottom: adaptationDp(20), top: adaptationDp(20), left: adaptationDp(15), right: adaptationDp(15)),
                  decoration: BoxDecoration(color: list[index].beenFound == '1' ? Colours.colorEE : Colours.white, boxShadow: [BoxShadow(color: Color(0x0D000000), offset: Offset(0.1, 0.1), blurRadius: 3, spreadRadius: 3)], borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${list[index].name}', style: TextStyles.textBlack16),
                      Gaps.vGap10,
                      Text('${list[index].ajmAddress}', style: TextStyles.textGrey14),
                    ],
                  ),
                ));
          }),
    );
  }
}
