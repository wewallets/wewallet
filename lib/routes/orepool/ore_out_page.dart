import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/profit.dart';
import 'package:mars/socket/ripple_web_socket.dart';

//矿池转出
class OreOutPage extends StatefulWidget {
  final Bundle bundle;

  OreOutPage(this.bundle);

  @override
  _OreOutPageState createState() => _OreOutPageState();
}

class _OreOutPageState extends State<OreOutPage> {
  TextEditingController walletTEC = new TextEditingController();
  bool isLegal = false;
  Profit profit;

  @override
  void initState() {
    super.initState();
    profit = widget.bundle.getObject('profit');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '矿池转出到币币账户'),
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
                            walletTEC.text = '${profit?.balance_mpool ?? 0.0}';
                            if (walletTEC.text.length != 0)
                              isLegal = true;
                            else
                              isLegal = false;
                            // walletTEC.text = NumUtil.getNumByValueStr(Global.getAssetsWalletInfo(coin).order_value, fractionDigits: 4).toString();
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
                TextSpan(text: '${profit?.balance_mpool ?? 0.0}', style: TextStyles.text7854D524.copyWith(color: Colours.themeColor)),
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
      Net().post(ApiTransaction.POOL_OUT, {'amount': walletTEC.text}, success: (data) {
        LayoutUtil.closeLoadingDialog(context);

        GlobalTransaction.refreshWalletAssets();

        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '转出矿池操作成功 ，处理中');
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
