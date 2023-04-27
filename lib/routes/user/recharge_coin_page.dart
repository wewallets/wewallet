import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletAssets.dart';
import 'package:qr_flutter/qr_flutter.dart';

//充币
class RechargeCoinPage extends StatefulWidget {
  final Bundle bundle;

  RechargeCoinPage(this.bundle);

  @override
  _RechargeCoinPageState createState() => _RechargeCoinPageState();
}

class _RechargeCoinPageState extends State<RechargeCoinPage> {
  WalletAssets walletAssets;

  //币种
  String coin;
  String inAddress;
  String inNet = 'TRC20';
  String xrpTag;

  @override
  void initState() {
    super.initState();
    initCoinList();

    Future.delayed(Duration(milliseconds: 0), () {
      getAddress();
    });
  }

  initCoinList() {
    walletAssets = widget.bundle.getObject('assetsItem');
    coin = walletAssets.net_currency_name;
    walletAssets.recharge_in_net_list.add('BSC');
    if (walletAssets.recharge_in_net_list.length != 0) inNet = walletAssets.recharge_in_net_list[1];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: LayoutUtil.getAppBar(context, '',
          // actions: <Widget>[
          //   InkResponse(
          //     onTap: () {
          //       Navigator.pushNamed(context, PageRouter.account_book_page);
          //     },
          //     child: LoadImage(Images.coin_record, width: ScreenUtil().setWidth(32), height: ScreenUtil().setWidth(36), fit: BoxFit.contain),
          //   ),
          //   Gaps.hGap15,
          // ],
          elevation: 0.0),
      body: ListView(
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(0), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
        children: <Widget>[
          Text('${getString().cb}', style: Styles.textHeadline),
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
                    //   child: Text('${getString().xzbz}', style: TextStyles.textGrey12.copyWith(color: Colours.colorDE)),
                    //   padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(4)),
                    // ),
                    // Gaps.hGap10,
                    // LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                  ],
                )),
            onTap: () {
              // Navigator.pushNamed(context, PageRouter.select_currency_page);
            },
          ),
          Gaps.vGap20,
          buildNet(),
          Gaps.vGap45,
          Center(child: QrImage(foregroundColor: Color(0xFF4B4660), padding: EdgeInsets.zero, data: '$inAddress', size: ScreenUtil().setWidth(320), backgroundColor: Colors.white)),
          Gaps.vGap40,
          Text('${getString().chongbidiz}', style: TextStyles.textGrey12),
          Gaps.vGap12,
          inkButton(
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: inAddress));
                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
              },
              child: Container(
                decoration: BoxDecoration(color: Colours.colorF6),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(30)),
                child:  Row(children: [
                  Text('${inAddress ?? ''}', style: TextStyles.textBlack13),
                  Expanded(child: Container()),
                  LoadImage('icon_am_copy',width: adaptationDp(10)),
                ]),
                alignment: Alignment.centerLeft,
              )),
          xrpTag == null || xrpTag == '' ? Container() : Gaps.vGap15,
          xrpTag == null || xrpTag == '' ? Container() : Text('XRPTag', style: TextStyles.textGrey12),
          xrpTag == null || xrpTag == '' ? Container() : Gaps.vGap12,
          xrpTag == null || xrpTag == ''
              ? Container()
              : inkButton(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: xrpTag));
                    Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colours.colorF6),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(30)),
                    child: Row(children: [
                      Text('${xrpTag ?? ''}', style: TextStyles.textBlack13),
                      Expanded(child: Container()),
                      LoadImage('icon_am_copy',width: adaptationDp(10)),
                    ]),
                    alignment: Alignment.centerLeft,
                  )),
          Gaps.vGap15,
          Text.rich(TextSpan(children: [
            TextSpan(text: '*', style: TextStyles.textGrey12.copyWith(color: Colours.FFBD2A39)),
            TextSpan(text: '${getString().chongbitis1}$coin${getString().chongbitis2}', style: TextStyles.textGrey12.copyWith(color: Colours.FFBD2A39)),
          ])),
          Gaps.vGap30,
          Buttons.getDetermineButton(
              isUse: true,
              buttonText: '${getString().fzcbdz}',
              voidCallback: () {
                Clipboard.setData(new ClipboardData(text: inAddress));
                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
//                if (addressController.text.length == 0) {
//                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "请输入提币地址");
//                  return;
//                }
//                if (numberController.text.length == 0) {
//                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "请输入提币数量");
//                  return;
//                }
              }),
          Gaps.vGap25,
        ],
      ),
    );
  }

  buildNet() {
    List<Widget> list = [];
    for (int i = 0; i < walletAssets.recharge_in_net_list.length; i++) {
      list.add(Container(
          margin: EdgeInsets.only(right: adaptationDp(10)),
          child: InkWell(
              onTap: () {
                inNet = walletAssets.recharge_in_net_list[i];
                getAddress();
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(154),
                height: ScreenUtil().setWidth(60),
                decoration: inNet == walletAssets.recharge_in_net_list[i]
                    ? BoxDecoration(
                        color: Colours.themeColor,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        border: Border.all(width: 0.5, color: Colours.themeColor),
                      )
                    : BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        border: Border.all(width: 0.5, color: Colours.themeColor),
                      ),
                child: Text(walletAssets.recharge_in_net_list[i], style: inNet == walletAssets.recharge_in_net_list[i] ? TextStyles.textWhite13 : TextStyles.textBlack13),
              ))));
    }
    return Row(children: list);
  }

  getAddress() {
    if (SpUtil.hasKey('in_address_$coin${GlobalTransaction.walletInfo.account_id}')) {
      inAddress = SpUtil.getString('in_address_$coin${GlobalTransaction.walletInfo.account_id}');
      if (mounted) setState(() {});
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.GET_IN_ADDRESS, {'account': GlobalTransaction.walletInfo.account_id, 'currency': coin, 'in_net': inNet}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      inAddress = data['in_address'];
      xrpTag = data['xrp_tag'];
      SpUtil.putString('in_address_$coin${GlobalTransaction.walletInfo.account_id}', inAddress);
      SpUtil.putString('in_net_$coin${GlobalTransaction.walletInfo.account_id}', inNet);

      if (mounted) setState(() {});
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '获取地址失败');
    });
  }
}
