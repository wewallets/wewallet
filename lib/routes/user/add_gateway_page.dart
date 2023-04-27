import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletAssets.dart';
import 'package:mars/models/walletPropose.dart';
import 'package:mars/socket/ripple_web_socket.dart';

//添加网关
class AddGatewayPage extends StatefulWidget {
  final Bundle bundle;

  AddGatewayPage(this.bundle);

  @override
  _AddGatewayPageState createState() => _AddGatewayPageState();
}

class _AddGatewayPageState extends State<AddGatewayPage> {
  List<WalletAssets> assetsList = [];

  String sequence = '';

  @override
  void initState() {
    super.initState();
    assetsList = widget.bundle.getList('assetsList');
  }

  @override
  Widget build(BuildContext context) {
    if (assetsList[0].currency == GlobalTransaction.coin) {
      assetsList.removeAt(0);
    }
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().tjwgzc}'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(30)), child: Text('${getString().tjwbzcsm}', style: TextStyles.textGrey12.copyWith(color: Colours.colorB4))),
        Container(color: Color(0x0D000000), height: ScreenUtil().setWidth(1)),
        Gaps.vGap20,
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildItemCoin(context, index);
            },
            itemCount: assetsList.length),
      ]),
    );
  }

  Widget buildItemCoin(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(44)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadImage('${assetsList[index].icon}', width: ScreenUtil().setWidth(64), height: ScreenUtil().setWidth(64)),
          Gaps.hGap5,
          Expanded(child: Text('${assetsList[index].net_currency_name}', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.w500))),
          InkResponse(
            child: LoadImage('${assetsList[index].is_trust == '1' ? 'swtich_2' : 'switch_1'}', width: ScreenUtil().setWidth(72), height: ScreenUtil().setWidth(40)),
            onTap: () {
              addGateway(index);
            },
          ),
        ],
      ),
    );
  }

  // initEvent() {
  //   RippleWebSocket.on(({arg}) {
  //     if (!mounted) return;
  //     if (arg['id'] == 'trust_account_info') {
  //       if (arg['status'] == 'success') {
  //         RippleWebSocket().trustSet(
  //             sequence: arg['result']['account_data']['Sequence'],
  //             secret: Global.walletInfo.master_seed,
  //             issuer: operationWallet.net_account,
  //             account: Global.walletInfo.account_id,
  //             currency: operationWallet.net_currency_name,
  //             isTrust: operationWallet.is_trust == null || operationWallet.is_trust == '0');
  //       } else {
  //         LayoutUtil.closeLoadingDialog(context);
  //         Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '添加失败');
  //       }
  //     } else if (arg['id'] == 'trustSet') {
  //       if (arg['status'] == 'success') {
  //         WalletPropose walletPropose = WalletPropose.fromJson(arg['result']);
  //         RippleWebSocket().submit(id: 'trustSetSubmit', txBlob: walletPropose.tx_blob);
  //       } else {
  //         LayoutUtil.closeLoadingDialog(context);
  //         Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '添加失败');
  //       }
  //     } else if (arg['id'] == 'trustSetSubmit') {
  //       LayoutUtil.closeLoadingDialog(context);
  //       if (arg['status'] == 'success') {
  //         if (operationWallet.is_trust == null || operationWallet.is_trust == '0') {
  //           operationWallet.is_trust = '1';
  //         } else {
  //           operationWallet.is_trust = '0';
  //         }
  //
  //         setState(() {});
  //       } else {
  //         LayoutUtil.closeLoadingDialog(context);
  //         Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '添加失败');
  //       }
  //     } else {
  //       LayoutUtil.closeLoadingDialog(context);
  //       Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '添加失败');
  //     }
  //   });
  // }

  addGateway(index) {
    LayoutUtil.showLoadingDialog(context);
    Net().post(assetsList[index].is_trust == null || assetsList[index].is_trust == '0' ? ApiTransaction.CHAIN_TRUST_SET : ApiTransaction.CHAIN_TRUST_SET_CANCEL, {'currency': assetsList[index].net_currency_name}, success: (data) {
      GlobalTransaction.refreshWalletAssets();

      LayoutUtil.closeLoadingDialog(context);
      if (assetsList[index].is_trust == null || assetsList[index].is_trust == '0') {
        assetsList[index].is_trust = '1';
      } else {
        assetsList[index].is_trust = '0';
      }
      if (assetsList[0].currency == GlobalTransaction.coin) {
        assetsList.removeAt(0);
      }
      setState(() {});
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().czcgclz}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
    // if (LayoutUtil.isActivation(context)) {
    //   if (walletAssets.is_trust == '1' && double.parse(walletAssets.order_value ?? 0.0) != 0.0) {
    //     Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '有余额，无法取消信任网关');
    //     return;
    //   }
    //   initEvent();
    // LayoutUtil.showLoadingDialog(context);
    //   operationWallet = walletAssets;
    //   RippleWebSocket().accountInfo(Global.walletInfo.account_id, id: 'trust_account_info');
    // }
  }
}
