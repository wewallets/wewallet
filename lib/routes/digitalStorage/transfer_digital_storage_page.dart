import 'dart:io';

import 'package:mars/common/transaction_component_index.dart';

import '../../common/base/base_state.dart';

class TransferDigitalStoragePage extends StatefulWidget {
  final Bundle bundle;

  TransferDigitalStoragePage(this.bundle);

  @override
  _TransferDigitalStoragePageState createState() => _TransferDigitalStoragePageState();
}

class _TransferDigitalStoragePageState extends BaseState<TransferDigitalStoragePage> {
  TextEditingController numberController = new TextEditingController();
  String coin;

  int coinIndex = 0;
  bool directionType = true; //true 转入 false 转出
  int transferType = 2; //	1、众筹，2数藏，3资产
  List<String> typeList = ['众筹账户', '数藏账户', 'SWAP资产'];
  List<String> coinList = [];
  String incomeAssetsRise;

  @override
  Widget get appBar => getAppBar('${s.text23}');

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  void initState() {
    super.initState();
    typeList = [s.text21, s.text22, s.text62];

    if (widget.bundle != null) {
      if (widget.bundle.isContainsKey('type')) directionType = widget.bundle.getBool('type');
      if (widget.bundle.isContainsKey('coin')) coin = widget.bundle.getString('coin');
      if (widget.bundle.isContainsKey('transferType')) transferType = widget.bundle.getInt('transferType');
    } else {
      coin = GlobalTransaction.digitalStorageAssetsList[0].netCurrencyName;
    }

    GlobalTransaction.refreshWalletAssets();
    getData();
    getIncome();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(left: dp(12), right: dp(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
              Gaps.vGap30,
              Text('${s.text24}', style: TextStyles.textWhite14),
              Gaps.vGap12,
              Container(
                margin: EdgeInsets.only(bottom: dp(12)),
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFF161427)),
                child: Row(children: [
                  Gaps.hGap20,
                  Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                    LoadImage('zz_bsyd', width: dp(5.5), height: dp(5.5)),
                    LoadImage('zz_sxjt', width: dp(10.5), height: dp(35.5)),
                    LoadImage('zz_lsyd', width: dp(5.5), height: dp(5.5)),
                  ]),
                  Gaps.hGap30,
                  Expanded(
                      child: Column(
                    children: [
                      PopupMenuButton(
                        enabled: !directionType,
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Text('${s.text25}', style: TextStyles.textGrey13),
                            Gaps.hGap8,
                            Text(directionType ? '${s.text26}' : typeList[transferType - 1], style: TextStyles.textWhite13),
                            Expanded(child: Container()),
                            directionType ? Container() : LoadAssetImage('youjiantou', width: dp(15), color: Colours.white),
                          ],
                        ),
                        itemBuilder: (context) => buildTypeList(),
                      ),
                      Container(width: double.infinity, height: 0.5, color: Colours.textGrey, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
                      PopupMenuButton(
                        padding: EdgeInsets.zero,
                        enabled: directionType,
                        child: Row(
                          children: [
                            Text('${s.text27}', style: TextStyles.textGrey13),
                            Gaps.hGap8,
                            Text(!directionType ? '${s.text26}' : typeList[transferType - 1], style: TextStyles.textWhite13),
                            Expanded(child: Container()),
                            !directionType ? Container() : LoadAssetImage('youjiantou', width: dp(15), color: Colours.white),
                            Gaps.hGap15,
                          ],
                        ),
                        itemBuilder: (context) => buildTypeList(),
                      ),
                    ],
                  )),
                  inkButton(
                      onPressed: () {
                        directionType = !directionType;
                        setState(() {});
                      },
                      child: Container(
                        width: dp(70),
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('zz_ybbg')), fit: BoxFit.fill)),
                        height: dp(90),
                        alignment: Alignment.center,
                        child: LoadImage('zz_qh', width: dp(33)),
                      )),
                ]),
              ),
              Padding(padding: EdgeInsets.only(bottom: dp(12), top: dp(12)), child: Text('${s.text28}', style: TextStyles.textWhite14)),
              Container(
                  padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), border: Border.all(width: 0.5, color: Colours.white)),
                  height: dp(49),
                  width: double.infinity,
                  child: inkButton(
                    onPressed: () {
                      navigatorPush(PageTransactionRouter.select_currency_two_page, bundle: Bundle()..putObject('list', coinList)).then((value) {
                        if (value != null) {
                          coin = value;
                        }
                        setState(() {});
                      });
                    },
                    child: Row(
                      children: [
                        // LoadImage('${coinList[coinIndex]}', width: dp(25)),
                        // Gaps.hGap5,
                        Text('${coin ?? ''}', style: TextStyles.textWhite13),
                        Expanded(child: Container()),
                        LoadAssetImage('youjiantou', width: dp(25), color: Colours.white),
                      ],
                    ),
                  )),
              Padding(padding: EdgeInsets.only(bottom: dp(12), top: dp(12)), child: Text('${s.text29}', style: TextStyles.textWhite14)),
              Container(
                  margin: EdgeInsets.only(bottom: dp(5)),
                  padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), border: Border.all(width: 0.5, color: Colours.white)),
                  height: dp(49),
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
                                style: TextStyles.textWhite14,
                                cursorColor: Colours.white,
                                decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.text30}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                              ))),
                      Gaps.hGap12,
                      Text('$coin', style: TextStyles.textWhite14),
                      Gaps.hGap12,
                      Container(height: dp(35), width: dp(0.5), color: Colours.textGrey6),
                      Gaps.hGap12,
                      inkButton(
                          onPressed: () {
                            if (transferType == 3&&!directionType) {
                              numberController.text = GlobalTransaction.getSwapAssets(coin)?.value ?? '0';
                              return;
                            }
                            if (transferType == 1 && !directionType)
                              numberController.text = incomeAssetsRise ?? '0.0';
                            else
                              numberController.text = directionType
                                  ? GlobalTransaction.getAssetsWalletInfo(coin) == null
                                      ? '0.0'
                                      : GlobalTransaction.getAssetsWalletInfo(coin).value
                                  : GlobalTransaction.getDigitalStorageAssets(coin).value;

                            setState(() {});
                          },
                          child: Text('${s.qbb}', style: TextStyles.textWhite14)),
                    ],
                  )),
              coin == null ? Container() : Padding(padding: EdgeInsets.only(bottom: dp(12)), child: transferType == 1 && !directionType ? Text('${s.ky} ${incomeAssetsRise ?? '0.0'} $coin', style: TextStyles.textWhite14) : Text('${s.ky} ${getAssets()} $coin', style: TextStyles.textWhite14)),
              Expanded(child: Container()),
              inkButton(
                onPressed: () {
                  submit();
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: dp(30)),
                    width: double.infinity,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill)),
                    height: dp(60),
                    alignment: Alignment.center,
                    child: Text('${s.text31}', style: TextStyles.textBlack18)),
              ),
            ])),
        coin == null ? Container(width: double.infinity, height: double.infinity, color: Color(0x4D000000), child: buildLoadingShadeCustom()) : Container(),
      ],
    );
  }

  getAssets() {
    if (transferType == 3&&!directionType) return GlobalTransaction.getSwapAssets(coin)?.value ?? '0';
    return directionType
        ? GlobalTransaction.getAssetsWalletInfo(coin) == null
            ? '0.0'
            : GlobalTransaction.getAssetsWalletInfo(coin).value
        : GlobalTransaction.getDigitalStorageAssets(coin) == null
            ? '0.0'
            : GlobalTransaction.getDigitalStorageAssets(coin).value;
  }

  buildCoinList() {
    List<PopupMenuItem> list = [];
    for (int i = 0; i < coinList.length; i++) {
      list.add(PopupMenuItem(
        child: Text('${coinList[i]}'),
        value: '${coinList[i]}',
        padding: EdgeInsets.only(right: dp(150), left: dp(12)),
        onTap: () {
          coinIndex = i;
          coin = '${coinList[i]}';
          setState(() {});
        },
      ));
    }
    return list;
  }

  buildTypeList() {
    List<PopupMenuItem> list = [];
    for (int i = 0; i < typeList.length; i++) {
      list.add(PopupMenuItem(
        child: Text('${typeList[i]}'),
        value: '${typeList[i]}',
        padding: EdgeInsets.only(right: dp(100), left: dp(12)),
        onTap: () {
          transferType = i + 1;
          coinList.clear();
          coin = null;

          getData();
          setState(() {});
        },
      ));
    }
    return list;
  }

  getData() {
    Net().post(ApiTransaction.collection_transfer_currency, {'transfer_type': transferType}, success: (data) {
      coinList.clear();
      data.forEach((element) {
        coinList.add(element);
      });
      if (coin == null) {
        coin = coinList[0];
        // numberController.text = '';
      }
      setState(() {});
    },failure: (error){
      showToast('$error');
    });
  }

  getIncome() {
    Net().post(ApiTransaction.user_income, null, success: (data) {
      incomeAssetsRise = data['assets_RISE'];
      if (mounted) setState(() {});
    }, failure: (error) {
      if (mounted) setState(() {});
    });
  }

  submit() {
    if (numberController.text.length == 0) {
      showToast('${s.text30}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(
        transferType == 1
            ? (directionType ? ApiTransaction.assets_in : ApiTransaction.assets_out)
            : transferType == 3
                ? (directionType ? ApiTransaction.swap_assets_in : ApiTransaction.swap_assets_out)
                : (directionType ? ApiTransaction.collection_assets_in : ApiTransaction.collection_assets_out),
        {'currency': coin, 'amount': numberController.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('${getString().tjcgddsh}');
      GlobalTransaction.refreshWalletAssets();
      Navigator.pop(context);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }
}
