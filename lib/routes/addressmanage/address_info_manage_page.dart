import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletInfo.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/wallet_manage_dialog.dart';

//钱包信息管理
class AddressInfoManagePage extends StatefulWidget {
  final Bundle bundle;

  AddressInfoManagePage(this.bundle);

  @override
  _AddressInfoManagePageState createState() => _AddressInfoManagePageState();
}

class _AddressInfoManagePageState extends State<AddressInfoManagePage> {
  TextEditingController searchTEC = new TextEditingController();
  WalletInfo walletInfo;

  @override
  void initState() {
    super.initState();
    walletInfo = widget.bundle.getObject('walletPropose');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, getString().dzgl),
        body: walletInfo == null
            ? Container()
            : Column(
                children: [
                  GestureDetector(
                    child: Container(
                      color: Colours.white,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(35), top: ScreenUtil().setWidth(26)),
                      height: ScreenUtil().setWidth(94),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${getString().qbnc}', style: TextStyles.textBlack14),
                          Row(
                            children: [
                              Text('${walletInfo != null ? walletInfo.wallet_name : ''}', style: TextStyle(color: Colours.colorFF7854D5, fontSize: ScreenUtil().setSp(24))),
                              Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(12))),
                              LoadImage(
                                'icon_goto',
                                width: ScreenUtil().setWidth(25),
                                height: ScreenUtil().setWidth(24),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => WalletManageDialog((name) {
                                showLoadingContextDialog(context);
                                Net().post(ApiTransaction.ADDRESS_INFO_EDITS, {'account': walletInfo.account_id, 'nick_name': '$name'}, isLogin: false, success: (data) {
                                  closeLoadingContextDialog(context);
                                  walletInfo.wallet_name = name;
                                  GlobalTransaction.setWalletInfo(walletInfo.account_id, name: name);
                                  setState(() {});
                                }, failure: (error) {
                                  closeLoadingContextDialog(context);
                                  showToast('$error');
                                });
                              }, title: '${getString().qbnc}', hintText: '${getString().qsrqbnc}', type: 1));
                    },
                  ),
                  Container(
                    color: Colours.color0D000000,
                    width: double.infinity,
                    height: ScreenUtil().setWidth(1),
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(35)),
                      height: ScreenUtil().setWidth(94),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => WalletManageDialog((password) {
                                    if (GlobalTransaction.walletPassword == password) {
                                      Navigator.pushNamed(context, PageTransactionRouter.mnemonic_backup_page,
                                          arguments: Bundle()
                                            ..putInt('type', 2)
                                            ..putObject('walletPropose', walletInfo));
                                    } else {
                                      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().nsrdmmcw}');
                                    }
                                  }, title: '${getString().bwzjc}'));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${getString().bwzjc}', style: TextStyles.textBlack14),
                            LoadImage(
                              'icon_goto',
                              width: ScreenUtil().setWidth(25),
                              height: ScreenUtil().setWidth(24),
                            )
                          ],
                        ),
                      )),
                  Container(
                    color: Colours.color0D000000,
                    width: double.infinity,
                    height: ScreenUtil().setWidth(1),
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(35)),
                      height: ScreenUtil().setWidth(94),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${getString().bfsy}', style: TextStyles.textBlack14),
                          LoadImage(
                            'icon_goto',
                            width: ScreenUtil().setWidth(25),
                            height: ScreenUtil().setWidth(24),
                          )
                        ],
                      ),
                    ),
                    splashColor: Colors.transparent,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => WalletManageDialog((password) {
                                if (GlobalTransaction.walletPassword == password) {
                                  Navigator.pushNamed(context, PageTransactionRouter.export_secretkey_page, arguments: Bundle()..putObject('walletPropose', walletInfo));
                                } else {
                                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().nsrdmmcw}');
                                }
                              }, title: '${getString().bfsy}'));
                    },
                  ),
                  Container(
                    color: Colours.color0D000000,
                    width: double.infinity,
                    height: ScreenUtil().setWidth(1),
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  ),
                ],
              ));
  }
}
