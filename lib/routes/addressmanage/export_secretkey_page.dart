import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletInfo.dart';
import 'package:mars/widgets/dialog/save_QR_code_dialog.dart';

//导出私钥
class ExportSecretkeyPage extends StatefulWidget {
  final Bundle bundle;

  ExportSecretkeyPage(this.bundle);

  @override
  _ExportSecretkeyPageState createState() => _ExportSecretkeyPageState();
}

class _ExportSecretkeyPageState extends State<ExportSecretkeyPage> {
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
        appBar: LayoutUtil.getAppBar(context, '${getString().bfsy}'),
        body: walletInfo == null
            ? Container()
            : ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40), vertical: ScreenUtil().setWidth(20)),
                    color: Colours.color1ACCB280,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: ScreenUtil().setWidth(14)),
                          decoration: BoxDecoration(color: Colours.FFE49700, borderRadius: BorderRadius.circular(20)),
                          height: ScreenUtil().setWidth(34),
                          width: ScreenUtil().setWidth(34),
                          child: Text(
                            '!',
                            style: TextStyles.textWhite14,
                          ),
                        ),
                        Expanded(
                            child: Text(
                          '${getString().sxsm}',
                          style: TextStyles.textE4970024,
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(100), right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   '钱包地址',
                        //   style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(34)),
                        //   child: Text(
                        //     '地址',
                        //     style: TextStyles.textTheme12.copyWith(fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        InkWell(
                            onTap: () {
                              Clipboard.setData(new ClipboardData(text: walletInfo.account_id));
                              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                            },
                            child: Row(
                              children: [
                                Text(
                                  '${walletInfo.account_id}',
                                  style: TextStyles.textBlack14,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(1)),
                                  child: LoadImage(
                                    'icon_am_copy',
                                    width: ScreenUtil().setWidth(22),
                                    height: ScreenUtil().setWidth(23),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            )),
                        Container(
                          color: Colours.colorEE,
                          height: ScreenUtil().setWidth(1),
                          margin: EdgeInsets.only(top: ScreenUtil().setWidth(24), bottom: ScreenUtil().setWidth(70)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(34)),
                          child: Text(
                            '${getString().sy}',
                            style: TextStyles.textTheme12.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Clipboard.setData(new ClipboardData(text: walletInfo.master_seed));
                              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                            },
                            child: Row(
                              children: [
                                Text(
                                  '${walletInfo.master_seed}',
                                  style: TextStyles.textBlack14,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(1)),
                                  child: LoadImage(
                                    'icon_am_copy',
                                    width: ScreenUtil().setWidth(22),
                                    height: ScreenUtil().setWidth(23),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            )),
                        Container(
                          color: Colours.colorEE,
                          height: ScreenUtil().setWidth(1),
                          margin: EdgeInsets.only(top: ScreenUtil().setWidth(24), bottom: ScreenUtil().setWidth(120)),
                        ),
                        Buttons.getDetermineButton(
                            isUse: true,
                            buttonText: '${getString().bcsyewm}',
                            voidCallback: () {
                              showDialog(context: context, builder: (_) => SaveQRCodeDialog(walletInfo.master_seed, '${getString().bcsyewmsm}'));
                            }),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
