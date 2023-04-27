import 'dart:io';

import 'package:mars/common/transaction_component_index.dart';

import '../../common/utils/num_util.dart';
import '../../common/whiteBase/base_alive_state.dart';
import '../../models/noticeList.dart';
import '../../models/swap_product_list_entity.dart';
import '../../widgets/font_marquee.dart';

class HomeSwapPage extends StatefulWidget {
  @override
  _HomeSwapPageState createState() => _HomeSwapPageState();
}

class _HomeSwapPageState extends BaseAliveState<HomeSwapPage> {
  TextEditingController number1Controller = new TextEditingController();
  TextEditingController number2Controller = new TextEditingController();
  TextEditingController dottedController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();

  FocusNode number1FocusNode = FocusNode();
  FocusNode number2FocusNode = FocusNode();
  String coin;
  String swapCoin;
  List<String> coinList = [];
  bool directionType = true; //true 转入 false 转出
  bool isOther = false;
  SwapProductListProductList swapProductListEntity;
  double expectedQuantity = 0.0;
  double dottedQuantity = 0.0;
  List<NoticeList> noticeList = [];
  bool isData = true;
  bool isHd = false;
  bool isJy = false;
  SwapProductListSymbolArr currentSymbolArr;

  @override
  Widget get appBar => getAppBar('', colors: Color(0xFFF8F8FC));

  @override
  void initState() {
    super.initState();
    dottedController.text = '1';
    timeController.text = '30';

    number1Controller.addListener(() {
      refreshNumber1();
    });
    number2Controller.addListener(() {
      refreshNumber2();
    });
    getHomeData();
  }

  refreshNumber1() {
    if (number1Controller.text.length == 0 || !number1FocusNode.hasFocus) {
      return;
    }
    if (directionType) {
      double number1 = double.parse(number1Controller.text);
      expectedQuantity = NumUtil.formatNum((number1 * double.parse(swapProductListEntity.toCurrPrice)).toString(), 4);
    } else {
      double number1 = double.parse(number1Controller.text);
      expectedQuantity = NumUtil.formatNum((number1 / double.parse(swapProductListEntity.toCurrPrice)).toString(), 4);
    }
    double dotted = expectedQuantity * (double.parse(dottedController.text) / 100);
    dottedQuantity = expectedQuantity - dotted;
    number2Controller.text = expectedQuantity.toString();
    setState(() {});
  }

  refreshNumber2() {
    if (number2Controller.text.length == 0 || !number2FocusNode.hasFocus) {
      return;
    }
    if (directionType) {
      double number2 = double.parse(number2Controller.text);
      expectedQuantity = NumUtil.formatNum((number2 * double.parse(swapProductListEntity.currPrice)).toString(), 4);
    } else {
      double number2 = double.parse(number2Controller.text);
      expectedQuantity = NumUtil.formatNum((number2 * double.parse(swapProductListEntity.toCurrPrice)).toString(), 4);
    }
    double dotted = expectedQuantity * (double.parse(dottedController.text) / 100);
    dottedQuantity = expectedQuantity - dotted;
    number1Controller.text = expectedQuantity.toString();
    setState(() {});
  }

  @override
  Widget buildContent(BuildContext context) {
    return isData == false
        ? buildErrorWidget()
        : swapProductListEntity == null
            ? buildLoadingShadeCustom()
            : ListView(padding: EdgeInsets.all(dp(12)), children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${s.text37}', style: TextStyles.textWhite25.copyWith(color: Color(0xFFE74561))),
                        Gaps.vGap5,
                        Text('${s.text38}', style: TextStyles.textBlack14),
                      ],
                    ),
                    Align(alignment: Alignment.topRight, child: LoadImage('swap_tb_bg', width: dp(206), height: dp(113))),
                  ],
                ),
                buildNotice,
                Gaps.vGap12,
                Text('${s.text39}', style: TextStyles.textWhite14.copyWith(color: Color(0xFFE74561))),
                Gaps.vGap12,
                Container(
                  decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(10))),
                  padding: EdgeInsets.all(dp(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Text('$coin', style: TextStyles.textBlack12),
                      // Gaps.vGap8,
                      Container(
                          margin: EdgeInsets.only(bottom: dp(5)),
                          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), color: Color(0xFFF8F8FC)),
                          height: dp(49),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                                      child: TextField(
                                        focusNode: number1FocusNode,
                                        keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                                        controller: number1Controller,
                                        style: TextStyles.textBlack14,
                                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.sl}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                                      ))),
                              Gaps.hGap12,
                              Container(height: dp(35), width: dp(0.5), color: Colours.colorEE),
                              Gaps.hGap12,
                              inkButton(
                                  onPressed: () {
                                    if (directionType)
                                      navigatorPush(PageTransactionRouter.select_currency_white_page, bundle: Bundle()..putObject('list', GlobalTransaction.swapProductListData.upCurrencyArr)).then((value) {
                                        if (value != null) {
                                          if (directionType) {
                                            coin = value;
                                          } else {
                                            swapCoin = value;
                                          }
                                        }
                                        setState(() {});
                                      });
                                    else
                                      navigatorPush(PageTransactionRouter.select_currency_white_page, bundle: Bundle()..putObject('list', GlobalTransaction.swapProductListData.downCurrencyArr)).then((value) {
                                        if (value != null) {
                                          if (!directionType) {
                                            coin = value;
                                          } else {
                                            swapCoin = value;
                                          }
                                        }
                                        setState(() {});
                                      });
                                  },
                                  child: Row(
                                    children: [
                                      Text('$coin', style: TextStyles.textBlack14),
                                      Gaps.hGap12,
                                      LoadImage('swap_xh1', width: dp(15)),
                                    ],
                                  )),
                            ],
                          )),
                      Row(children: [
                        // Text('≈ 0', style: TextStyles.textBlack12.copyWith(color: Color(0xFFE74561))),
                        Expanded(child: Container()),
                        Text('${s.text40}${GlobalTransaction.getSwapAssets(coin)?.value ?? '0'}', style: TextStyles.textGrey12),
                      ]),
                      Gaps.vGap12,
                      Center(
                          child: inkButton(
                              onPressed: () {
                                directionType = !directionType;
                                if (directionType) {
                                  coin = swapProductListEntity.currency;
                                  swapCoin = swapProductListEntity.toCurrency;
                                } else {
                                  swapCoin = swapProductListEntity.currency;
                                  coin = swapProductListEntity.toCurrency;
                                }
                                if (number1Controller.text.length != 0 && number2Controller.text.length != 0) {
                                  if (number1FocusNode.hasFocus) {
                                    refreshNumber1();
                                  } else {
                                    refreshNumber2();
                                  }
                                }
                                setState(() {});
                              },
                              child: LoadImage('swap_sw', width: dp(37)))),
                      Gaps.vGap12,
                      // Text('$swapCoin', style: TextStyles.textBlack12),
                      // Gaps.vGap8,
                      Container(
                          margin: EdgeInsets.only(bottom: dp(5)),
                          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), color: Color(0xFFF8F8FC)),
                          height: dp(49),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                                      child: TextField(
                                        focusNode: number2FocusNode,
                                        keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                                        controller: number2Controller,
                                        style: TextStyles.textBlack14,
                                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.sl}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                                      ))),
                              Gaps.hGap12,
                              Container(height: dp(35), width: dp(0.5), color: Colours.colorEE),
                              Gaps.hGap12,
                              inkButton(
                                  onPressed: () {
                                    if (directionType)
                                      navigatorPush(PageTransactionRouter.select_currency_white_page, bundle: Bundle()..putObject('list', GlobalTransaction.swapProductListData.downCurrencyArr)).then((value) {
                                        if (value != null) {
                                          if (!directionType) {
                                            coin = value;
                                          } else {
                                            swapCoin = value;
                                          }
                                        }
                                        setState(() {});
                                      });
                                    else
                                      navigatorPush(PageTransactionRouter.select_currency_white_page, bundle: Bundle()..putObject('list', GlobalTransaction.swapProductListData.upCurrencyArr)).then((value) {
                                        if (value != null) {
                                          if (directionType) {
                                            coin = value;
                                          } else {
                                            swapCoin = value;
                                          }
                                        }
                                        setState(() {});
                                      });
                                  },
                                  child: Row(
                                    children: [
                                      Text('$swapCoin', style: TextStyles.textBlack14),
                                      Gaps.hGap12,
                                      LoadImage('swap_xh1', width: dp(15)),
                                    ],
                                  )),
                            ],
                          )),
                      Row(children: [
                        // Text('≈ 0', style: TextStyles.textBlack12.copyWith(color: Color(0xFFE74561))),
                        Expanded(child: Container()),
                        Text('${s.text40}${GlobalTransaction.getSwapAssets(swapCoin)?.value ?? '0'}', style: TextStyles.textGrey12),
                      ]),
                      Gaps.vGap20,
                      Lines.line,
                      Row(
                        children: [
                          Text('${s.text41}', style: TextStyles.textBlack12),
                          Gaps.hGap5,
                          inkButton(
                              onPressed: () {
                                isHd = !isHd;
                                setState(() {});
                              },
                              child: LoadImage('swap_wh', width: dp(12))),
                          Gaps.hGap5,
                          isHd
                              ? Expanded(
                                  child: Container(
                                  height: dp(40),
                                  margin: EdgeInsets.only(top: dp(5), bottom: dp(5)),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(5))), border: Border.all(width: 0.5, color: Color(0x24000000))),
                                  padding: EdgeInsets.only(left: dp(5), right: dp(5)),
                                  child: Text('${s.text42}', style: TextStyles.textBlack12),
                                ))
                              : Container(
                            height: dp(40),
                            margin: EdgeInsets.only(top: dp(5), bottom: dp(5)),
                          )
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), color: Color(0xFFF8F8FC)),
                          height: dp(35),
                          child: TextField(
                            keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                            controller: dottedController,
                            style: TextStyles.textBlack14,
                            decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                          )),
                      Gaps.vGap12,
                      Row(
                        children: [
                          Text('${s.text43}', style: TextStyles.textBlack12),
                          Gaps.hGap5,
                          inkButton(
                              onPressed: () {
                                isJy = !isJy;
                                setState(() {});
                              },
                              child: LoadImage('swap_wh', width: dp(12))),
                          Gaps.hGap5,
                          isJy
                              ? Expanded(
                              child: Container(
                                height: dp(40),
                                margin: EdgeInsets.only(top: dp(5), bottom: dp(5)),
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(5))), border: Border.all(width: 0.5, color: Color(0x24000000))),
                                padding: EdgeInsets.only(left: dp(5), right: dp(5)),
                                child: Text('${s.text44}', style: TextStyles.textBlack12),
                              ))
                              :Container(
                            height: dp(40),
                            margin: EdgeInsets.only(top: dp(5), bottom: dp(5)),
                          )
                        ],
                      ),
                      Gaps.vGap8,
                      Container(
                          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), color: Color(0xFFF8F8FC)),
                          height: dp(35),
                          child: TextField(
                            keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                            controller: timeController,
                            style: TextStyles.textBlack14,
                            decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                          )),
                      Gaps.vGap20,
                      Lines.line,
                      Gaps.vGap20,
                      inkButton(
                          onPressed: () {
                            isOther = !isOther;
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              Text(directionType ? '${getCoinPrice(directionType)} $coin = ${getCoinPrice(!directionType)} $swapCoin' : '${getCoinPrice(!directionType)} $coin = ${getCoinPrice(directionType)} $swapCoin', style: TextStyles.textBlack14),
                              Expanded(child: Container()),
                              LoadImage(isOther ? 'swap_sxh2' : 'swap_sxh', width: dp(10)),
                            ],
                          )),
                      isOther
                          ? Column(children: [
                              Gaps.vGap8,
                              Row(
                                children: [
                                  Text('${s.text45}', style: TextStyles.textGrey12),
                                  Expanded(child: Container()),
                                  Text('$expectedQuantity $swapCoin', style: TextStyles.textGrey12),
                                ],
                              ),
                              Gaps.vGap8,
                              // Row(
                              //   children: [
                              //     Text('兑换率影响', style: TextStyles.textGrey12),
                              //     Expanded(child: Container()),
                              //     Text('0.2%', style: TextStyles.textGrey12),
                              //   ],
                              // ),
                              // Gaps.vGap8,
                              Row(
                                children: [
                                  Text('${s.text69}(${dottedController.text}%)', style: TextStyles.textGrey12),
                                  Expanded(child: Container()),
                                  Text('$dottedQuantity $swapCoin', style: TextStyles.textGrey12),
                                ],
                              ),
                            ])
                          : Container()
                    ],
                  ),
                ),
                Gaps.vGap12,
                inkButton(
                  onPressed: () {
                    if (currentSymbolArr != null) submit();
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: dp(30)),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Color(0xFFE74561), borderRadius: BorderRadius.circular(adaptationDp(10))),
                      height: dp(45),
                      alignment: Alignment.center,
                      child: Text(currentSymbolArr == null ? '${s.text46}' : '${s.text39}', style: TextStyles.textWhite18)),
                ),
              ]);
  }

  get buildNotice {
    return Container(
      height: ScreenUtil().setWidth(80),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(10))),
      padding: EdgeInsets.only(left: adaptationDp(12), right: adaptationDp(12)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        LoadAssetImage('home_gonggaox', width: ScreenUtil().setWidth(44), color: Colours.textBlack),
        Gaps.hGap8,
        Expanded(
            child: noticeList == null || noticeList.length == 0
                ? Container()
                : FontMarquee(noticeList.length, (BuildContext context, int index) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageTransactionRouter.webview_page,
                                arguments: Bundle()
                                  ..putString('titleName', '${getString().ggxq}')
                                  ..putString('url', '${ApiTransaction.BASE_URL}explorer/notice_detail/${noticeList[index].id}.html'));
                          },
                          child: Text('${noticeList[index].title}', style: TextStyles.textBlack13.copyWith(overflow: TextOverflow.ellipsis), maxLines: 1),
                        ));
                  })),
      ]),
    );
  }

  getCoinPrice(directionType) {
    currentSymbolArr = null;
    for (int i = 0; i < GlobalTransaction.swapProductListData.symbolArr.length; i++) {
      if (directionType) {
        String symbol = coin + '_' + swapCoin;
        if (symbol == GlobalTransaction.swapProductListData.symbolArr[i].symbol) {
          currentSymbolArr = GlobalTransaction.swapProductListData.symbolArr[i];
        }
      } else {
        String symbol = swapCoin + '_' + coin;
        if (symbol == GlobalTransaction.swapProductListData.symbolArr[i].symbol) {
          currentSymbolArr = GlobalTransaction.swapProductListData.symbolArr[i];
        }
      }
    }
    if (currentSymbolArr == null) return '0.0';
    return currentSymbolArr.price;
  }

  submit() {
    if (number1Controller.text.length == 0) {
      showToast('${s.qsrsl}');
      return;
    }
    if (dottedController.text.length == 0) {
      showToast('${s.text47}');
      return;
    }
    if (timeController.text.length == 0) {
      showToast('${s.text48}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.swap_order_add, {'product_id': swapProductListEntity.productId, 'pay_currency': coin, 'pay_amount': number1Controller.text, 'ex_currency': swapCoin, 'ex_rate': dottedController.text, 'auto_cancel_minute': timeController.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('${s.text49}');
      GlobalTransaction.refreshWalletAssets();
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }

  getHomeData() {
    Net().post(ApiTransaction.swap_product_list, null, success: (data) {
      GlobalTransaction.swapProductListData = SwapProductListEntity().fromJson(data);

      if (data['product_list'].length == 0) {
        isData = false;
        setState(() {});
        return;
      }
      swapProductListEntity = SwapProductListProductList().fromJson(data['product_list'][0]);
      coin = swapProductListEntity.currency;
      swapCoin = swapProductListEntity.toCurrency;
      if (mounted) setState(() {});
    }, failure: (error) {
      showToast('$error');
      isData = false;
      setState(() {});
    });
    Net().post(ApiTransaction.BASIC_AGREEMENT, {'flag': 15}, success: (data) {
      noticeList.clear();
      data.forEach((element) {
        noticeList.add(NoticeList.fromJson(element));
      });
      if (mounted) setState(() {});
    });
  }
}
