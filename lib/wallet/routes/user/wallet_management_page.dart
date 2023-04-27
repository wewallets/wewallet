import 'package:flutter/services.dart';
import 'package:mars/wallet/common/component_index.dart';

import '../../mobels/category_list_entity.dart';
import '../../mobels/wallet_entity.dart';
import '../../widgets/dialog/select_country_dialog.dart';

class WalletManagementPage extends StatefulWidget {
  final Bundle bundle;

  WalletManagementPage(this.bundle);

  @override
  _WalletManagementPageState createState() => _WalletManagementPageState();
}

class _WalletManagementPageState extends BaseState<WalletManagementPage> {
  int type = 0; //0：正常钱包管理  1：窗口式钱包管理
  int classType = 0;
  List<CategoryListEntity> categoryList = [];
  List<WalletEntity> walletList = [];

  @override
  Widget get appBar => type == 0
      ? getAppBar('钱包管理', actions: [
          Row(
            children: [
              inkButton(
                  child: LoadImage('qbgl_tj', width: dp(24)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => SelectCountryDialog(0, (data) async {
                              if (data == '创建新钱包')
                                navigateTo(PageWalletRouter.create_wallet_page, bundle: Bundle()..putString('network', Global.networkList[classType].name));
                              else
                                navigateTo(PageWalletRouter.import_wallet_page, bundle: Bundle()..putString('network', Global.networkList[classType].name));
                            }, ['创建新钱包', '导入钱包']));
                  }),
              Gaps.hGap15,
            ],
          )
        ])
      : null;

  @override
  void initState() {
    super.initState();

    type = widget.bundle == null
        ? 0
        : widget.bundle.isContainsKey('type')
            ? widget.bundle.getInt('type')
            : 0;

    classType = Global.getNetworkListIndex();

    setState(() {});
    initClass();

    getData();
  }

  initClass() {
    categoryList.clear();
    for (int i = 0; i < Global.networkList.length; i++) {
      CategoryListEntity categoryListEntity = CategoryListEntity();
      categoryListEntity.catName = Global.networkList[i].name;
      categoryListEntity.catIcon = Global.networkList[i].icon;
      categoryList.add(categoryListEntity);
    }
    initWallet();
  }

  initWallet() {
    walletList.clear();
    for (int i = 0; i < Global.walletList.length; i++) {
      if (Global.walletList[i].network == categoryList[classType].catName) {
        walletList.add(Global.walletList[i]);
      }
    }
    setState(() {});
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
        child: Row(children: [
      Expanded(flex: 2, child: buildClass),
      Expanded(flex: 7, child: buildWallet),
    ]));
  }

  get buildClass {
    return categoryList.length == 0
        ? Container()
        : listViewBuilder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              if (classType == index) {
                return Container(
                    color: Colours().white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Gaps.vGap15,
                        LoadImage('${categoryList[index].catIcon}', width: dp(40), height: dp(40)),
                        Gaps.vGap15,
                        // Container(
                        //   width: double.infinity,
                        //   alignment: Alignment.center,
                        //   height: dp(45),
                        //   color: Color(0x080041B9),
                        //   child: Text('${categoryList[index].catName.toUpperCase()}', style: TextStyles().textTheme14),
                        // ),
                        Container(height: dp(2), color: Colours().themeColor, width: double.infinity),
                      ],
                    ));
              } else {
                return inkButton(
                    onPressed: () {
                      classType = index;
                      initWallet();
                      setState(() {});
                    },
                    child: Container(
                        color: Colours().background,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Gaps.vGap15,
                            LoadImage('${categoryList[index].catIcon}', width: dp(40), height: dp(40)),
                            Gaps.vGap15,
                            Container(height: dp(2), color: Colours().background, width: double.infinity),
                            // Container(
                            //   width: double.infinity,
                            //   alignment: Alignment.center,
                            //   height: dp(45),
                            //   color: Color(0x080041B9),
                            //   child: Text('${categoryList[index].catName.toUpperCase()}', style: TextStyles().textTheme14),
                            // ),
                          ],
                        )));
              }
            });
  }

  get buildWallet {
    return walletList.length == 0
        ? Container(
            color: Colours().white,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(top: dp(15), left: dp(15), right: dp(15)),
                  child: Row(
                    children: [
                      Text('${categoryList[classType].catName}', style: TextStyles().textBlack14),
                      Expanded(child: Container()),
                      // type == 0 ? Container() : Icon(Icons.add_circle_outline, size: dp(18), color: Colours().textBlack),
                    ],
                  )),
              Gaps.vGap15,
              inkButton(
                child: Container(
                    decoration: BoxDecoration(color: Color(0xFFF3F6FB), borderRadius: BorderRadius.circular(dp(8))),
                    margin: EdgeInsets.only(bottom: dp(15), right: dp(15), left: dp(12)),
                    padding: EdgeInsets.only(left: dp(15)),
                    width: double.infinity,
                    height: dp(70),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: dp(18), color: Colours().textBlack),
                        Gaps.hGap7,
                        Text('添加钱包', style: TextStyles().textBlack12),
                      ],
                    )),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SelectCountryDialog(0, (data) async {
                            if (data == '创建新钱包')
                              navigateTo(PageWalletRouter.create_wallet_page, bundle: Bundle()..putString('network', Global.networkList[classType].name));
                            else
                              navigateTo(PageWalletRouter.import_wallet_page, bundle: Bundle()..putString('network', Global.networkList[classType].name));
                          }, ['创建新钱包', '导入钱包']));
                },
              )
            ]))
        : Container(
            color: Colours().white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: dp(15), left: dp(15), right: dp(15)),
                    child: Row(
                      children: [
                        Text('${categoryList[classType].catName}', style: TextStyles().textBlack14),
                        Expanded(child: Container()),
                        type == 0
                            ? Container()
                            : inkButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => SelectCountryDialog(0, (data) async {
                                            if (data == '创建新钱包')
                                              navigateTo(PageWalletRouter.create_wallet_page, bundle: Bundle()..putString('network', Global.networkList[classType].name));
                                            else
                                              navigateTo(PageWalletRouter.import_wallet_page, bundle: Bundle()..putString('network', Global.networkList[classType].name));
                                          }, ['创建新钱包', '导入钱包']));
                                },
                                child: Icon(Icons.add_circle_outline, size: dp(18), color: Colours().textBlack)),
                      ],
                    )),
                Expanded(
                    child: ListView.builder(
                  itemCount: walletList.length,
                  padding: EdgeInsets.only(top: dp(15)),
                  itemBuilder: (BuildContext context, int index) => inkButton(
                    child: Container(
                        decoration: BoxDecoration(color: Global.userWallet.wallet.address == walletList[index].wallet.address ? Color(0xFF627EEA) : Color(0xFFF3F6FB), borderRadius: BorderRadius.circular(dp(8))),
                        margin: EdgeInsets.only(bottom: dp(15), right: dp(15), left: dp(12)),
                        padding: EdgeInsets.only(left: dp(15)),
                        width: double.infinity,
                        height: dp(70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${walletList[index].name}', style: Global.userWallet.wallet.address == walletList[index].wallet.address ? TextStyles().textWhite12 : TextStyles().textBlack12),
                            Gaps.vGap5,
                            Text('${walletList[index].wallet.address}', style: Global.userWallet.wallet.address == walletList[index].wallet.address ? TextStyles().textWhite12 : TextStyles().textGrey10),
                          ],
                        )),
                    onPressed: () {
                      if (type == 1) {
                        Future.delayed(Duration(milliseconds: 0), () {
                          Global.switchWallet(walletList[index]);
                        });

                        Future.delayed(Duration(milliseconds: 100), () {
                          pop();
                        });
                      } else {
                        Clipboard.setData(new ClipboardData(text: walletList[index].wallet.address));
                        showToast('复制成功');
                      }
                    },
                  ),
                ))
              ],
            ));
  }

  getData() {}
}
