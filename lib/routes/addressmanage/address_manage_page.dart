import 'dart:collection';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletInfo.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/selection_tips_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//地址管理
class AddressManagePage extends StatefulWidget {
  @override
  _AddressManagePageState createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<AddressManagePage> {
  TextEditingController searchTEC = new TextEditingController();
  List<WalletInfo> listData; //显示数据
  RefreshController refreshController = RefreshController();

  String coin;
  int index = 0;

  bool isDispose = false;

  @override
  void initState() {
    super.initState();
    initData();

    initEvent();
    searchTEC.addListener(() {
      walletWhere(searchTEC.text);
    });
  }

  initEvent() {
    EventBus().on('refreshAddressManage', ({arg}) {
      initData();
    });
  }

  @override
  void dispose() {
    isDispose = true;
    EventBus().off('refreshAddressManage');
    super.dispose();
  }

  queryAddress(List<WalletInfo> queryAddressList, {isR = false}) {
    if (queryAddressList == null) return;
    String queryAddress = '';
    queryAddressList.forEach((element) {
      queryAddress += '${element.account_id},';
    });

    queryAddress = queryAddress.substring(0, queryAddress.length - 1);
    if (isR) LayoutUtil.showLoadingDialog(context);

    Net().post(ApiTransaction.ACCOUNTS_BALANCE, {'accounts': queryAddress}, success: (data) {
      if (isR) LayoutUtil.closeLoadingDialog(context);

      for (int i = 0; i < data['accounts'].length; i++) {
        if (listData[i].account_id == data['accounts'][i]['address']) {
          listData[i].is_activation = data['accounts'][i]['is_active'];
          listData[i].balance = data['accounts'][i]['assets_RISE'];
        }
      }

      GlobalTransaction.saveWalletList(walletInfoList: listData);

      if (refreshController != null) refreshController.refreshCompleted();

      if (mounted) setState(() {});
    }, failure: (error) {
      if (isR) LayoutUtil.closeLoadingDialog(context);

      if (refreshController != null) refreshController.refreshCompleted();

      showToast('$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, getString().dzgl, actions: <Widget>[
          InkResponse(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(30)),
                child: Row(children: [
                  Text('${GlobalTransaction.coin}', style: TextStyles.text7854D528.copyWith(color: Colours.themeColor)),
                ])),
            onTap: () {
              refreshController.requestRefresh();
            },
          )
        ]),
        body: SmartRefresher(
            controller: refreshController,
            enablePullUp: false,
            enablePullDown: true,
            onRefresh: () {
              initData();
            },
            onLoading: () {},
            child: listData == null
                ? Container()
                : Stack(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setWidth(150)),
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(188)),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: ScreenUtil().setWidth(230),
                                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(12)),
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('assets_item_bg')), fit: BoxFit.fill)),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: ScreenUtil().setWidth(34), bottom: ScreenUtil().setWidth(18)),
                                          child: Row(
                                            children: [
                                              Text.rich(TextSpan(children: [
                                                TextSpan(text: '${listData[index].wallet_name} ', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                                                TextSpan(text: listData[index].is_activation == '1' ? '${getString().yjh}' : '${getString().wjh}', style: listData[index].is_activation == '1' ? TextStyles.textGrey12 : TextStyles.textGrey12.copyWith(color: Colours.FFD94F57)),
                                              ]))
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          child: Row(
                                            children: [
                                              Expanded(child: Text(listData[index].account_id, style: TextStyles.textGrey13)),
                                              Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                                              LoadImage('icon_am_copy', width: ScreenUtil().setWidth(22), height: ScreenUtil().setWidth(23)),
                                              Gaps.hGap15,
                                            ],
                                          ),
                                          onTap: () {
                                            Clipboard.setData(new ClipboardData(text: listData[index].account_id));
                                            Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().fzcg}');
                                          },
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: ScreenUtil().setWidth(24), bottom: ScreenUtil().setWidth(34)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Text('${listData[index]?.balance == '' || listData[index]?.balance == null ? 0.0 : listData[index]?.balance} ${GlobalTransaction.coin}', style: TextStyles.textTheme12),
                                                Gaps.hGap20,
                                              ],
                                            )),
                                            listData[index]?.account_id == GlobalTransaction.walletInfo.account_id
                                                ? Container()
                                                : InkResponse(
                                                    child: Row(
                                                      children: [
                                                        Text('${getString().scc}', style: TextStyles.textGrey12.copyWith(color: Colours.colorFFFFEDF0)),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (builder) {
                                                            return SelectionTipsDialog(
                                                                title: '${getString().xtts}',
                                                                content: '${getString().shifousc}',
                                                                rightText: '${getString().scc}',
                                                                leftText: '${getString().qx}',
                                                                voidCallback: () {
                                                                  GlobalTransaction.deleteWallet(listData[index].account_id);
                                                                  listData.removeAt(index);
                                                                  setState(() {});
                                                                });
                                                          });
                                                    },
                                                  ),
                                            Gaps.hGap20,
                                            InkResponse(
                                              child: Row(
                                                children: [
                                                  Text('${getString().xq}', style: TextStyles.textGrey12),
                                                  Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(6)), child: LoadImage('youjiantou', width: ScreenUtil().setWidth(24))),
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.pushNamed(context, PageTransactionRouter.address_info_manage_page, arguments: Bundle()..putObject('walletPropose', listData[index])).then((value) {
                                                  listData = GlobalTransaction.walletInfoList;
                                                  setState(() {});
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    listData[index]?.account_id == GlobalTransaction.walletInfo.account_id
                                        ? Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: ScreenUtil().setWidth(170),
                                                height: ScreenUtil().setWidth(48),
                                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('dangqdz')), fit: BoxFit.fill)),
                                                child: Text('${getString().dqdz}', style: TextStyles.textWhite12),
                                              ),
                                            ))
                                        : Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              child: Container(
                                                margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                                                width: ScreenUtil().setWidth(170),
                                                height: ScreenUtil().setWidth(50),
                                                decoration: BoxDecoration(color: Colours.FFF2F1F8, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    LoadImage('qiehuan_3', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)),
                                                    Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(14))),
                                                    Text('${getString().qiehuandiz}', style: TextStyles.text757CB224.copyWith(color: Color(0xFFB98E40))),
                                                  ],
                                                ),
                                              ),
                                              onTap: () async {
                                                FocusScope.of(context).requestFocus(FocusNode());
                                                var indexData = listData[index];

                                                if (searchTEC.text.length != 0) {
                                                  listData = GlobalTransaction.walletInfoList;
                                                  searchTEC.text = '';
                                                }

                                                GlobalTransaction.switchWallet(indexData);
                                                sortData(GlobalTransaction.walletInfo.account_id);

                                                Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qhcg}');
                                                EventBus().send('switch_address', true);

                                                if (mounted) setState(() {});

                                                // Future.delayed(Duration(milliseconds: 0), () {
                                                //   sortData(Global.walletInfo.account_id);
                                                //   setState(() {});
                                                // });

                                                // SpUtil.remove('assetsList');
                                                // SpUtil.remove('pool_detail_profit');
                                                // var data = listData[index];
                                                // Global.switchWallet(data);
                                                //
                                                // if (searchTEC.text.length != 0) {
                                                //   listData = Global.walletInfoList;
                                                //   searchTEC.text = '';
                                                //   sortData(data);
                                                // } else {
                                                // }
                                                //
                                                // Global.saveWalletList(walletInfoList: listData);
                                                //
                                                // Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qhcg}');
                                                // EventBus().send('switch_address', true);
                                                //
                                                // if (mounted) setState(() {});
                                                //
                                                // Future.delayed(Duration(milliseconds: 0), () {
                                                //   sortData(Global.walletInfo.account_id);
                                                //   setState(() {});
                                                // });
                                              },
                                            ),
                                          )
                                  ],
                                ),
                              );
                            },
                            itemCount: listData.length ?? 0,
                          )),
                      Container(
                        height: ScreenUtil().setWidth(188),
                        padding: EdgeInsets.only(top: ScreenUtil().setWidth(12), bottom: ScreenUtil().setWidth(14), right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: ScreenUtil().setWidth(90),
                                    decoration: BoxDecoration(color: Colours.colorF6, borderRadius: BorderRadius.all(Radius.circular(40))),
                                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        LoadImage('icon_am_search', width: ScreenUtil().setWidth(35), height: ScreenUtil().setWidth(35)),
                                        Padding(
                                          padding: EdgeInsets.only(right: ScreenUtil().setWidth(40), left: ScreenUtil().setWidth(64)),
                                          child: TextField(
                                            maxLines: 1,
                                            controller: searchTEC,
                                            decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().qsrqbncss}', hintStyle: TextStyles.textA9A9A928),
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.done,
                                            style: TextStyles.textBlack15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: inkButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, PageTransactionRouter.create_wallet_page, arguments: Bundle()..putInt('type', 1)).then((value) => initData());
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                                            decoration: BoxDecoration(color: Color(0xFF007EFF), borderRadius: BorderRadius.circular(6)),
                                            height: ScreenUtil().setWidth(88),
                                            child: Text(
                                              '${getString().cjqz}',
                                              style: TextStyles.textWhite16,
                                            ),
                                          ))),
                                  Expanded(
                                      child: inkButton(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                                      decoration: BoxDecoration(color: Colours.themeColor, borderRadius: BorderRadius.circular(6)),
                                      height: ScreenUtil().setWidth(88),
                                      child: Text(
                                        '${getString().drdz}',
                                        style: TextStyles.textWhite16,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, PageTransactionRouter.import_wallet_page, arguments: Bundle()..putInt('type', 1)).then((value) => initData());
                                    },
                                  )),
                                ],
                              )))
                    ],
                  )));
  }

  walletWhere(String str) {
    if (str == '') {
      listData = GlobalTransaction.walletInfoList;
      sortData(GlobalTransaction.walletInfo.account_id);

      setState(() {});
      return;
    }

    listData = GlobalTransaction.walletInfoList;
    sortData(GlobalTransaction.walletInfo.account_id);

    List<WalletInfo> listNew = [];

    listData.forEach((item) {
      if (item.wallet_name.toLowerCase().contains(str.toLowerCase())) {
        listNew.add(item);
      }
    });
    listData = listNew;
    setState(() {});
  }

  sortData(data) {
    for (int i = 0; i < listData.length; i++) {
      if (listData[i]?.account_id == data) {
        listData.insert(0, listData.removeAt(i));
      }
    }
  }

  initData({isR = false}) {
    listData = GlobalTransaction.walletInfoList;
    sortData(GlobalTransaction.walletInfo.account_id);

    queryAddress(listData, isR: isR);

    if (mounted) setState(() {});
  }
}
