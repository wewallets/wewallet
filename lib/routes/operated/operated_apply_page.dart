import 'package:mars/common/transaction_component_index.dart';

//认购
class OperatedApplyPage extends StatefulWidget {
  final Bundle bundle;

  OperatedApplyPage(this.bundle);

  @override
  _OperatedApplyPageState createState() => _OperatedApplyPageState();
}

class _OperatedApplyPageState extends State<OperatedApplyPage> {
  String price;
  String currency;
  String explain;

  @override
  void initState() {
    super.initState();
    getPurchase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.white,
        appBar: LayoutUtil.getAppBar(context, '认购'),
        body: currency == null
            ? LayoutUtil.getLoadingShadeCustom()
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24)),
                      children: [
                        Gaps.vGap25,
                        Row(children: [
                          Text('接受币种', style: TextStyles.textBlack14),
                          Text('$currency', style: TextStyles.textBlack14),
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Gaps.vGap10,
                        Divider(height: 0, color: Colours.colorEE),
                        Gaps.vGap25,
                        Row(children: [
                          Text('数量', style: TextStyles.textBlack14),
                          Text('$price', style: TextStyles.textBlack14),
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Gaps.vGap10,
                        Divider(height: 0, color: Colours.colorEE),
                        Gaps.vGap25,
                        Text('认购说明', style: TextStyles.textBlack15.copyWith(fontWeight: FontWeight.bold)),
                        Gaps.vGap15,
                        Text(explain.replaceAll('\\n', '\n'), style: TextStyles.textGrey12.copyWith(height: 1.5)),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(50)),
                      child: Buttons.getDetermineButton(
                          isUse: true,
                          buttonText: '确认认购',
                          voidCallback: () {
                            submit();
                          })),
                ],
              ));
  }

  getPurchase() {
    Net().post(ApiTransaction.WALLET_PURCHASE_INFO, {
      'activity': widget.bundle.getString('activity'),
      'currency_id': widget.bundle.getString('base_currency_id'),
    }, success: (data) {
      explain = data['explain'];
      price = data['sg_price'];
      currency = data['recieve_currency'];
      if (mounted) setState(() {});
    }, failure: (error) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }

  submit() {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.WALLET_PURCHASE, {
      'activity': widget.bundle.getString('activity'),
      'sg_currency_id': widget.bundle.getString('base_currency_id'),
      'app_dev_no': widget.bundle.getString('device'),
      'ip': widget.bundle.getString('ip'),
    }, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '申购成功，处理中');
      GlobalTransaction.refreshWalletAssets();
      Navigator.pop(context);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }
}
