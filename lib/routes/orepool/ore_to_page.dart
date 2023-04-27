import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/profit.dart';
import 'package:mars/socket/ripple_web_socket.dart';

//矿池转入
class OreToPage extends StatefulWidget {
  final Bundle bundle;

  OreToPage(this.bundle);

  @override
  _OreToPageState createState() => _OreToPageState();
}

class _OreToPageState extends State<OreToPage> {
  TextEditingController walletTEC = new TextEditingController();
  bool isLegal = false;

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '投入矿池'),
      body: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(61), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('数量', style: TextStyles.textBlack12),
              Stack(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(100)),
                    child: TextField(
                      autofocus: false,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
                      controller: walletTEC,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(32)),
                      cursorColor: Colours.textBlack,
                      decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入数量', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyle(color: Colors.black, fontSize: 16)),
                      onChanged: (s) {
                        if (walletTEC.text.length != 0)
                          isLegal = true;
                        else
                          isLegal = false;
                        if (mounted) setState(() {});
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        InkResponse(
                          child: Text('全部', style: TextStyles.textGrey614),
                          onTap: () {
                            walletTEC.text = '${GlobalTransaction.getAssetsWalletInfo('DSP')?.value ?? 0.0}';
                            if (walletTEC.text.length != 0)
                              isLegal = true;
                            else
                              isLegal = false;
                            if (mounted) setState(() {});
                          },
                        ),
                      ],
                    ),
                    alignment: Alignment.bottomRight),
              ]),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(34)),
                color: Colours.colorEE,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: ' 余额  ', style: TextStyles.textBlack12),
                TextSpan(text: '${GlobalTransaction.getAssetsWalletInfo('DSP')?.value ?? 0.0} DSP', style: TextStyles.text7854D524.copyWith(color: Colours.themeColor)),
              ])),
              Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(120)),
                  child: Buttons.getDetermineButton(
                      isUse: isLegal,
                      buttonText: '确定',
                      bgImage: 'qt_qrann2',
                      voidCallback: () {
                        activation();
                      })),
              Gaps.vGap20,
              // Padding(
              //   padding: EdgeInsets.only(right: 0),
              //   child: InkWell(
              //       onTap: () {
              //         LayoutUtil.showLoadingDialog(context);
              //
              //         Net().post(Api.WALLET_AGREEMENT, {'flag': 1}, success: (data) async {
              //           LayoutUtil.closeLoadingDialog(context);
              //
              //           Navigator.pushNamed(context, PageRouter.webview_page, arguments: Bundle()..putString('titleName', '矿池转入协议')..putString('url', '${data['content']}'));
              //         }, failure: (error) {
              //           LayoutUtil.closeLoadingDialog(context);
              //
              //           showToast('$error');
              //         });
              //       },
              //       child: Center(
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Text('投入矿池，表示您已同意', style: TextStyles.textGrey13.copyWith(color: Colours.colorFF97A2AF)),
              //             Text('《矿池投入协议》', style: TextStyles.textGrey13.copyWith(color: Colours.colorFFD94F57)),
              //           ],
              //         ),
              //       )),
              // )
            ],
          )),
    );
  }

  checkPage() {
    if (walletTEC.text.length == 0) {
      isLegal = false;
    } else {
      isLegal = true;
    }
    if (mounted) setState(() {});
  }

  activation() {
    if (isLegal) {
      LayoutUtil.showLoadingDialog(context);
      Net().post(ApiTransaction.POOL_IN, {'product_id': widget.bundle.getString('id'), 'amount': walletTEC.text}, success: (data) {
        LayoutUtil.closeLoadingDialog(context);

        GlobalTransaction.refreshWalletAssets();

        Navigator.pop(context);

        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '转入矿池操作成功 ，处理中');
      }, failure: (error) {
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
        Navigator.pop(context);
      });
      // if (walletTEC.text == Global.walletInfo.account_id) {
      //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '不能激活自己哦');
      //   return;
      // }
      // LayoutUtil.showLoadingDialog(context);
      // RippleWebSocket().accountInfo(walletTEC.text, id: 'activation_account_info');
    }
  }
}
