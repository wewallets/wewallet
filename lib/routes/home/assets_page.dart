import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/acc_info_entity.dart';
import 'package:mars/models/index.dart';
import 'package:mars/res/colors.dart';
import 'package:mars/widgets/dialog/input_address_dialog.dart';
import 'package:mars/widgets/dialog/selection_tips_dialog.dart';
import 'package:mars/widgets/loading_shade_custom.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mars/widgets/fade_in_cache.dart' as fcache;

//我的资产
class AssetsPage extends StatefulWidget {
  @override
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController refreshController = RefreshController();
  List<WalletAssets> assetsList = [];
  String totalDEC = '0.0';
  String totalCny = '0.0';

  //是否显示金额
  bool isDisplay = true;

  //是否隐藏小额
  bool isSmallAmount = false;

  String isRaiseActive;

  @override
  void initState() {
    super.initState();

    getData();
    isActive();

    EventBus().on('switch_address', ({arg}) {
      Future.delayed(Duration(milliseconds: 0), () {
        totalDEC = '0.0';
        totalCny = '0.0';
        assetsList.clear();
        setState(() {});
        getData();
      });
    });

    EventBus().on('refreshAssets', ({arg}) {
      getData();
    });
  }

  @override
  void dispose() {
    EventBus().off('refreshAssets');
    EventBus().off('switch_address');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colours.white,
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: false,
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: <Widget>[
            buildSliverPersistentHeader,
            SliverList(
                delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return !GlobalTransaction.isLogin
                    ? LayoutUtil.buildErrorWidget(topHeight: 200, errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                    : assetsList.length == 0
                        ? LoadingShadeCustom(alpha: 0.1, msg: '${getString().zzjzzc}', loading: true, child: Container(), textColor: ColorsUtil.hexColor(0x333333))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: buildItemCoin,
                            itemCount: assetsList.length,
                            padding: EdgeInsets.only(top: ScreenUtil().setWidth(40), left: ScreenUtil().setWidth(18), right: ScreenUtil().setWidth(18)),
                          );
              },
              childCount: 1,
            )),
          ],
        ),
      ),
    );
  }

  get buildSliverPersistentHeader {
    double expandedHeight = ScreenUtil().setWidth(300) + ScreenUtil().statusBarHeight + kToolbarHeight;
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverCustomCommonHeaderDelegate(
            expandedHeight: expandedHeight,
            collapsedHeight: kToolbarHeight,
            paddingTop: ScreenUtil().statusBarHeight,
            widget: (double shrinkOffset, bool overlapsContent) {
              return Container(
                  height: expandedHeight,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      LoadImage('cc1_waves', fit: BoxFit.fill, width: double.infinity, height: expandedHeight),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            color: makeStickyHeaderWhite(expandedHeight, kToolbarHeight, shrinkOffset),
                            constraints: BoxConstraints(maxHeight: kToolbarHeight + ScreenUtil().statusBarHeight),
                            padding: EdgeInsets.only(top: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(30)),
                            child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                              Container(),
                              Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(70)), child: Text('${getString().zc}', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.w500, color: makeStickyHeaderIconColor(shrinkOffset)))),
                              Container(),
                            ]),
                          )),
                      (ScreenUtil().setWidth(270) - shrinkOffset) > 0
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(40)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Text('${getString().zzczk}', style: TextStyles.textWhite12),
                                      // Text('冻结资产', style: TextStyles.textWhite12),
                                    ]),
                                    Gaps.vGap10,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${getTotalCny() ?? 0.0} ', style: TextStyles.textWhite24.copyWith(fontWeight: FontWeight.bold)),
                                        // Text('${getFreeze() ?? 0.0} ', style: TextStyles.textWhite24.copyWith(fontWeight: FontWeight.bold, color: Color(0xFF2F2517))),
                                      ],
                                    ),
                                    Gaps.vGap5,
                                    // Text('≈${totalDEC ?? 0.0} ${Global.coin}', style: TextStyles.textGrey612),
                                  ],
                                ),
                              ))
                          : Container(),
                      (ScreenUtil().setWidth(270) - shrinkOffset) > 0
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: ScreenUtil().setWidth(110),
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // LoadImage('assets_xs', height: ScreenUtil().setWidth(30)), //assets_yc
                                    // Gaps.hGap15,
                                    // Text('隐藏小额币种', style: TextStyles.textWhite12),

                                    Expanded(child: Container()),
                                    LoadImage('assets_tjzc', height: ScreenUtil().setWidth(30)),
                                    Gaps.hGap7,
                                    InkWell(
                                      child: Text('${getString().tjzc}', style: TextStyles.textWhite12),
                                      onTap: () {
                                        var ls = assetsList;
                                        ls.removeAt(0);
                                        if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.add_gateway_page, arguments: Bundle()..putList('assetsList', ls)).then((value) => getData());
                                      },
                                    ),
                                    // Gaps.hGap15,
                                    // LoadAssetImage('qiehuan_3', width: dp(15), height: dp(15), color: Colours.white),
                                    // Gaps.hGap7,
                                    // inkButton(
                                    //     onPressed: (){
                                    //       if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.transfer_digital_storage_page);
                                    //     },
                                    //     child: Text('${getString().zf70}', style: TextStyles.textWhite12)),
                                    // Gaps.hGap7,
                                  ],
                                ),
                              ))
                          : Container(),
                    ],
                  ));
            }));
  }

  Color makeStickyHeaderBlack(maxExtent, minExtent, shrinkOffset) {
    final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 51, 51, 51);
  }

  Color makeStickyHeaderWhite(maxExtent, minExtent, shrinkOffset) {
    final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderBackground(maxExtent, minExtent, shrinkOffset) {
    final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(maxExtent, minExtent, shrinkOffset) {
    final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 51, 51, 51);
  }

  Color makeStickyHeaderIconColor(shrinkOffset) {
    if (shrinkOffset <= 60)
      return Colours.white;
    else
      return Colors.black;
  }

  Widget buildItemCoin(BuildContext context, int index) {
    return index != 0 && assetsList[index].is_trust == '0'
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(26), bottom: ScreenUtil().setWidth(18)),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('assets_item_bg')), fit: BoxFit.fill)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gaps.hGap15,
                    LoadImage('${assetsList[index].icon}', width: dp(25), height: dp(25)),
                    Gaps.hGap5,
                    Text('${assetsList[index].net_currency_name}', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
                Gaps.vGap20,
                Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Container(alignment: Alignment.centerLeft, child: Text('${getString().ky}', style: TextStyles.textGrey12))),
                        Expanded(child: Container(alignment: Alignment.center, child: Text('${getString().dongjie}', style: TextStyles.textGrey12))),
                        Expanded(child: Container(alignment: Alignment.centerRight, child: Text('USDT', style: TextStyles.textGrey12))),
                      ],
                    )),
                Gaps.vGap5,
                Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Container(alignment: Alignment.centerLeft, child: Text('${NumUtil.formatNum(assetsList[index].order_value ?? '0', 4) ?? 0.0}', style: TextStyles.textBlack16))),
                        Expanded(child: Container(alignment: Alignment.center, child: Text('${NumUtil.formatNum(assetsList[index].freeze ?? '0', 4) ?? 0.0}', style: TextStyles.textBlack16))),
                        Expanded(child: Container(alignment: Alignment.centerRight, child: Text('${NumUtil.formatNum(assetsList[index].cny_value ?? '0', 2) ?? 0.0}', style: TextStyles.textBlack16))),
                      ],
                    )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Gaps.hGap15,
                //     Text('${assetsList[index].value ?? 0.0}', style: TextStyles.textBlack16),
                //     Gaps.hGap5,
                //     Text('≈\$ ${assetsList[index].cny_value ?? 0.0}', style: TextStyles.textGrey12.copyWith(color: Colours.colorFF97A2AF)),
                //   ],
                // ),
                Gaps.vGap20,
                Row(children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            index == 0 ? receivable(index) : recharge(index);
                          },
                          child: Container(
                            color: Color(0x0FB98E40),
                            height: ScreenUtil().setWidth(72),
                            alignment: Alignment.center,
                            child: Text('${getString().cb}', style: TextStyles.textBlack12),
                          ))),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            withdraw(index);
                          },
                          child: Container(
                            color: Color(0x0FB98E40),
                            height: ScreenUtil().setWidth(72),
                            alignment: Alignment.center,
                            child: Text('${getString().tb}', style: TextStyles.textBlack12),
                          ))),
                  index == 0 ? Container() : Container(color: Colours.colorEE, height: ScreenUtil().setWidth(72), width: ScreenUtil().setWidth(1)),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            transfer(index);
                          },
                          child: Container(
                            color: Color(0x0FB98E40),
                            height: ScreenUtil().setWidth(72),
                            alignment: Alignment.center,
                            child: Text('${getString().zz}', style: TextStyles.textBlack12),
                          ))),
                  // index == 0 ? Container() : Container(color: Colours.colorEE, height: ScreenUtil().setWidth(72), width: ScreenUtil().setWidth(1)),
                  // index == 0
                  //     ? Expanded(
                  //         child: InkWell(
                  //             onTap: () {
                  //               Navigator.pushNamed(context, PageRouter.crowdfunding_transfer_page, arguments: Bundle()..putInt('type', 1)).then((value) {
                  //                 getData();
                  //               });
                  //             },
                  //             child: Container(
                  //               color: Color(0x0FB98E40),
                  //               height: ScreenUtil().setWidth(72),
                  //               alignment: Alignment.center,
                  //               child: Text('${getString().zf70}', style: TextStyles.textBlack12),
                  //             )))
                  //     : Container(),
                  // assetsList[index].net_currency_name == 'FIL' ? Container(color: Colours.colorEE, height: ScreenUtil().setWidth(72), width: ScreenUtil().setWidth(1)) : Container(),
                  // assetsList[index].net_currency_name == 'FIL'
                  //     ? Expanded(
                  //         child: InkWell(
                  //             onTap: () {
                  //               if (LayoutUtil.isLogin(context, isShowLogin: true) && LayoutUtil.isActivation(context)) {
                  //                 Navigator.pushNamed(context, PageRouter.flash_cash_coin_page,
                  //                         arguments: Bundle()
                  //                           ..putObject('assetsItem', assetsList[index])
                  //                           ..putString('flashIcon','USDT')
                  //                           ..putString('flashIcon2', 'YISE'))
                  //                     .then((value) => getData());
                  //               }
                  //             },
                  //             child: Container(
                  //               color: Color(0x0FB98E40),
                  //               height: ScreenUtil().setWidth(72),
                  //               alignment: Alignment.center,
                  //               child: Text('${getString().sd}', style: TextStyles.textBlack12),
                  //             )))
                  //     : Container(),
                ])
              ],
            ),
            margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(12)),
          );
  }

  receivable(index) {
    Navigator.pushNamed(context, PageTransactionRouter.account_receivable_page).then((value) => getData());
  }

  recharge(index) {
    if (isOperation(index, false)) {
      Navigator.pushNamed(context, PageTransactionRouter.recharge_coin_page, arguments: Bundle()..putObject('assetsItem', assetsList[index])).then((value) => getData());
    }
  }

  withdraw(index) {
    if (isOperation(index, true)) {
      Navigator.pushNamed(context, PageTransactionRouter.withdraw_coin_page, arguments: Bundle()..putObject('assetsItem', assetsList[index])).then((value) => getData());
    }
  }

  transfer(index) {
    if (index != 0 && assetsList[index].open_payment == '0') {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colours.transparent,
          context: context,
          builder: (builder) {
            return SelectionTipsDialog(title: '${getString().xytjwg}', content: '${getString().xytjwegsm}', leftText: '${getString().zb}', rightText: '${getString().zz}', voidCallback: () {}, noLeftText: true);
          });
      return;
    }
    Navigator.pushNamed(context, PageTransactionRouter.transfer_accounts_page, arguments: Bundle()..putObject('assetsItem', assetsList[index])).then((value) => getData());
  }

  isOperation(index, isOut) {
    if ((assetsList[index].is_trust == null || assetsList[index].is_trust == '0') && index != 0) {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colours.transparent,
          context: context,
          builder: (builder) {
            return SelectionTipsDialog(
                title: '${getString().xytjwg}',
                content: '${getString().xytjwegsm}',
                leftText: '${getString().zb}',
                rightText: '${getString().qd}',
                voidCallback: () {
                  var ls = assetsList;
                  ls.removeAt(0);
                  Navigator.pushNamed(context, PageTransactionRouter.add_gateway_page, arguments: Bundle()..putList('assetsList', ls)).then((value) => getData());
                });
          });
      return false;
    } else if (!isOut && (assetsList[index].open_in == null || assetsList[index].open_in == '0')) {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colours.transparent,
          context: context,
          builder: (builder) {
            return SelectionTipsDialog(title: '${getString().xtts}', content: '${getString().zsgb}${assetsList[index].net_currency_name}${getString().cb}', leftText: '${getString().zb}', rightText: '${getString().wzdl}', voidCallback: () {}, noLeftText: true);
          });
      return false;
    } else if (isOut && (assetsList[index].open_out == null || assetsList[index].open_out == '0')) {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colours.transparent,
          context: context,
          builder: (builder) {
            return SelectionTipsDialog(title: '${getString().xtts}', content: '${getString().zsgb}${assetsList[index].net_currency_name}${getString().tb}', rightText: '${getString().wzdl}', voidCallback: () {}, noLeftText: true);
          });
      return false;
    } else {
      return true;
    }
  }

  getCcTest(index) {
    if (GlobalTransaction.coin != assetsList[index].net_currency_name) {
      return '${getString().cb}';
    } else {
      return '${getString().sk}';
    }
  }

  getZzTest(index) {
    if (GlobalTransaction.coin != assetsList[index].net_currency_name) {
      return '${getString().tb}';
    } else {
      return '${getString().zz}';
    }
  }

  getStype(index) {
    if (GlobalTransaction.coin != assetsList[index].net_currency_name) {
      return assetsList[index].is_open_in == '1' || assetsList[index].is_open_out == '1' || index == 0 ? TextStyles.textBlack12 : TextStyles.textGrey12;
    } else {
      return TextStyles.textBlack12;
    }
  }

  getTotalCny() {
    double total = 0.0;
    if (assetsList.length == 0) return total;
    assetsList.forEach((element) {
      total += double.parse(element.cny_value ?? '0.0');
    });
    return NumUtil.formatNum(total.toString(), 4);
  }

  getFreeze() {
    double total = 0.0;
    if (assetsList.length == 0) return total;
    assetsList.forEach((element) {
      total += double.parse(element.freeze ?? 0.0);
    });
    return NumUtil.formatNum(total.toString(), 4);
  }

  active(data) {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.active, {'invite_code': data}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      isRaiseActive = '1';
      showToast('激活成功');
      if (mounted) setState(() {});
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }

  isActive() {
    Net().post(ApiTransaction.is_active, null, success: (data) {
      isRaiseActive = data['is_raise_active'];
      if (mounted) setState(() {});
    });
  }

  getData() {
    if (!GlobalTransaction.isLogin) return;
    if (SpUtil.hasKey('assetsList${GlobalTransaction.walletInfo.account_id}')) {
      assetsList = SpUtil.getObjList('assetsList${GlobalTransaction.walletInfo.account_id}', (v) => WalletAssets.fromJson(v));
      totalDEC = SpUtil.getString('total_assets_TH_THC${GlobalTransaction.walletInfo.account_id}');
      totalCny = SpUtil.getString('total_cny${GlobalTransaction.walletInfo.account_id}');
    } else {
      totalDEC = '0.0';
      totalCny = '0.0';
    }
    if (mounted) setState(() {});

    Net().post(ApiTransaction.CHAIN_BALANCE, null, success: (data) {
      assetsList.clear();
      totalDEC = data['total']['total_usd'].toString();
      totalCny = data['total']['total_cny'].toString();
      data['currency_list'].forEach((element) {
        assetsList.add(WalletAssets.fromJson(element));
      });

      SpUtil.putString('total_assets_TH_THC${GlobalTransaction.walletInfo.account_id}', totalDEC);
      SpUtil.putString('total_cny${GlobalTransaction.walletInfo.account_id}', totalCny);
      SpUtil.putObjectList('assetsList${GlobalTransaction.walletInfo.account_id}', assetsList);
      SpUtil.putObjectList('assetsList', assetsList);

      if (GlobalTransaction.isLogin) {
        if (GlobalTransaction.walletInfo.is_activation != '1') {
          if (assetsList[0].value != null && assetsList[0].value != '0') {
            GlobalTransaction.setWalletInfo(GlobalTransaction.walletInfo.account_id, isActivation: '1', balance: assetsList[0].value);
          }
        } else if (assetsList[0].value != null && assetsList[0].value != '0') {
          GlobalTransaction.setWalletInfo(GlobalTransaction.walletInfo.account_id, balance: assetsList[0].value);
        }
      }
      if (mounted) setState(() {});
    });
  }
}
