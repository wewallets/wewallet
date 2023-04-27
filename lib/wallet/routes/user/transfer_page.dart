import 'package:mars/wallet/common/component_index.dart';

class TransferPage extends StatefulWidget {
  final Bundle bundle;

  TransferPage(this.bundle);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends BaseState<TransferPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  String coin = 'YISE';

  @override
  Widget get appBar => getAppBar('转账');

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('coin'))
      coin = widget.bundle.getString('coin');
    else
      coin = Global.getCurrencyList()[0].currencyName;

  }

  @override
  Color get backgroundColor => Color(0xFFF3F6FB);

  @override
  Widget buildContent(BuildContext context) {
    return ListView(padding: EdgeInsets.all(dp(15)), children: [
      Text('选择币种', style: TextStyles().textGrey12),
      Gaps.vGap5,
      inkButton(
          onPressed: () {
            navigateTo(PageWalletRouter.select_currency_page).then((value) {
              if (value != null) coin = value;
              if (mounted) setState(() {});
            });
          },
          child: Container(
              padding: EdgeInsets.only(left: dp(12), right: dp(12)),
              height: dp(50),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
              child: Row(children: [
                Text('$coin', style: TextStyles().textBlack14),
                Expanded(child: Container()),
                LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
              ]))),
      Gaps.vGap15,
      Text('转账地址', style: TextStyles().textGrey12),
      Gaps.vGap5,
      Container(
          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
          height: dp(50),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: addressController,
                        style: TextStyles().textBlack14,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请出入或长按粘贴地址', hintStyle: TextStyles().textGrey14),
                      ))),
              Gaps.hGap12,
              inkButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: LoadImage('dapp_sys', width: dp(20), height: dp(20))),
            ],
          )),
      Gaps.vGap15,
      Text('数量', style: TextStyles().textGrey12),
      Gaps.vGap5,
      Container(
          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
          height: dp(50),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                      child: TextField(
                        keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                        controller: numberController,
                        style: TextStyles().textBlack14,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入数量', hintStyle: TextStyles().textGrey14),
                      ))),
              Gaps.hGap12,
              Text('$coin', style: TextStyles().textGrey13),
              Gaps.hGap10,
              Container(height: dp(12), width: 0.5, color: Color(0xFFF5F3F0)),
              Gaps.hGap10,
              inkButton(
                  onPressed: () {
                    numberController.text = Global.getAssetsWalletInfo(coin).value ?? 0.0;
                    setState(() {});
                  },
                  child: Text('全部', style: TextStyles().textTheme14)),
            ],
          )),
      Gaps.vGap15,
      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('${'可用 ${Global.getAssetsWalletInfo(coin).value ?? 0.0}'}  $coin', style: TextStyles().textGrey12),
        Expanded(child: Container()),
        Gaps.hGap20,
      ]),
      Buttons.getDetermineButton(
          margin: EdgeInsets.only(top: dp(120)),
          onPressed: () {
            transfer();
          }),
    ]);
  }

  transfer() {
    if (addressController.text.length == 0) {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qsrtbdz}");
      return;
    }
    if (numberController.text.length == 0) {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qsrtbsl}");
      return;
    }
    if (addressController.text == Global.userWallet.wallet.address) {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().bnzzzj}');
      return;
    }

    showLoadingDialog();

  }
}
