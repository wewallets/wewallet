import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/common/utils/my_color.dart';
import 'package:mars/common/utils/my_imgs.dart';
import 'package:mars/common/utils/my_widget_builder.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/btc_bean.dart';
import 'package:mars/models/index.dart';
import 'package:mars/models/level_bean.dart';
import 'package:mars/models/market_detail_bean.dart';
import 'package:mars/models/trust_bean.dart';
import 'package:mars/routes/drawer/currency_drawer.dart';
import 'package:mars/socket/transaction_web_socket.dart';
import 'package:mars/widgets/divider_widget.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';

//交易
class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<TrustData> trustDatas = [];
  List<TrustHistory> trustHistoryDatas = [];

  TextEditingController _priceController = new TextEditingController();
  TextEditingController _sizeController = new TextEditingController();
  List<LevelInfo> buys = [];
  List<LevelInfo> sells = [];
  MarketDetailBean marketDetailBean;
  bool isBy = true; //买入操作

  String currentPrice = '0.00'; // 当前价格
  String currentCySize = '0.00'; // 当前数量
  num inNum = 0.01; // 每次操作
  double entrustHeight = 0.0; //没有当前委托显示的高度
  double gearWidth = 0.0; //单条档位百分比宽度
  double gearLVHeight = 250; //档位列表高度
  int gear = 0; //档位 0:全部 1:买 2:卖
  String market1 = 'YISE';
  String market2 = 'USDT';

  String turnover = '0.0';
  String unitPrice = '0.0';

  Timer newsTimer;
  Timer newsTimer2;

  String lsOfferSequence = '';

  //可用
  String offerValue = '0.0';

  bool isPrice = false;

  int commissionType = 0;

  String depthType = '4';

  @override
  void initState() {
    super.initState();
    gearWidth = ((ScreenUtil().screenWidth - ScreenUtil().setWidth(64)) / 2) / 100;
    double useHeight = kToolbarHeight + ScreenUtil().statusBarHeight + ScreenUtil().setWidth(110) + ScreenUtil().setWidth(942);
    if (useHeight > ScreenUtil().screenHeight || ((ScreenUtil().screenHeight - useHeight) < 250)) {
      entrustHeight = 300;
    } else {
      entrustHeight = ScreenUtil().screenHeight - useHeight;
    }

    for (int i = 0; i < 10; i++) {
      buys.add(LevelInfo()
        ..orderPrice = '--'
        ..lastValue = '--');
      sells.add(LevelInfo()
        ..orderPrice = '--'
        ..lastValue = '--');
    }
    initEvent();

    if (GlobalTransaction.isWsOnHttp) {
      startWs();
    }

    getData(isOne: true);
    timeNews();
    initTextEditing();
    getHl();
  }

  initTextEditing() {
    _priceController.addListener(() {
      if (_priceController.text.contains('.')) {
        var ls = _priceController.text.split('.');
        if (ls[1].length > 4) {
          currentPrice = _priceController.text.substring(0, _priceController.text.indexOf('.') + 4);
          _priceController.text = currentPrice;
          _priceController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _priceController.text.length));
        }
      } else {
        currentPrice = _priceController.text;
      }
      try {
        refreshPrice();
      } catch (e) {}
    });
    _sizeController.addListener(() {
      try {
        if (_sizeController.text.contains('.')) {
          var ls = _sizeController.text.split('.');
          if (ls[1].length > 4) {
            currentCySize = _sizeController.text.substring(0, _sizeController.text.indexOf('.') + 4);
            _sizeController.text = currentCySize;
            _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _sizeController.text.length));
          }
        } else {
          currentCySize = _sizeController.text;
        }
        setState(() {});
      } catch (e) {}

      refreshPrice();
    });
  }

  initEvent() {
    EventBus().on('switch_transaction', ({arg}) {
      isPrice = true;
      GlobalTransaction.isNewsTimer = true;
      market1 = arg['market1'];
      market2 = arg['market2'];
      trustHistoryDatas.clear();
      buys.clear();
      sells.clear();
      marketDetailBean=null;
      for (int i = 0; i < 10; i++) {
        buys.add(LevelInfo()
          ..orderPrice = '--'
          ..lastValue = '--');
        sells.add(LevelInfo()
          ..orderPrice = '--'
          ..lastValue = '--');
      }


      if (arg['type'] == 'purchase') {
        isBy = true;
        if (mounted) setState(() {});
      } else {
        isBy = false;
        if (mounted) setState(() {});
      }

      getData(isOne: true);
      getHl();
    });
    EventBus().on('refreshTransaction', ({arg}) {
      trustHistoryDatas.clear();

      if (mounted) setState(() {});

      GlobalTransaction.refreshWalletAssets();

      switchWs();
      getHl();
      // getBalance();
      // getLevel();
      // getCurrentTrust();
      // getHistoryTrust();
      // getMarketDetail();
    });
    EventBus().on('tranSwitchCurrency', ({arg}) {
      isPrice = true;
      BTCBean btcBean = arg;
      if (market1 != btcBean.tradName || market2 != btcBean.baseName) {
        market1 = btcBean.tradName;
        market2 = btcBean.baseName;
        buys.clear();
        sells.clear();
        trustHistoryDatas.clear();
        marketDetailBean=null;
        for (int i = 0; i < 10; i++) {
          buys.add(LevelInfo()
            ..orderPrice = '--'
            ..lastValue = '--');
          sells.add(LevelInfo()
            ..orderPrice = '--'
            ..lastValue = '--');
        }

        getData(isOne: true);
        getHl();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    EventBus().off('refreshTransaction');
    EventBus().off('switch_transaction');
    EventBus().off('tranSwitchCurrency');
    _priceController.dispose();
    _sizeController.dispose();
    newsTimer2.cancel();
    newsTimer.cancel();
    TransactionWebSocket.off();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colours.background,
      key: _scaffoldKey,
      drawer: Drawer(
        child: CurrencyDrawer(intoPage: 0),
      ),
      appBar: LayoutUtil.getAppBar(context, '${getString().bbjy}', noLeading: false, elevation: 0.0),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildHead(),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverCustomCommonHeaderDelegate(
                  expandedHeight: ScreenUtil().setWidth(110),
                  collapsedHeight: ScreenUtil().setWidth(110),
                  paddingTop: 0,
                  widget: (double shrinkOffset, bool overlapsContent) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: ScreenUtil().setWidth(23), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(28)),
                              child: Row(
                                children: [
                                  inkButton(
                                      child: Text('${getString().dqwt}', style: commissionType == 0 ? TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold) : TextStyles.textBlack16),
                                      onPressed: () {
                                        commissionType = 0;
                                        setState(() {});
                                      }),
                                  Gaps.hGap25,
                                  inkButton(
                                      child: Text("${getString().lsjl}", style: commissionType == 1 ? TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold) : TextStyles.textBlack16),
                                      onPressed: () {
                                        commissionType = 1;
                                        setState(() {});
                                      }),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                    child: Row(
                                      children: [MImage.icAllFlag, Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(16))), Text("${getString().qbb}", style: TextStyles.textGrey621)],
                                    ),
                                    onTap: () {
                                      if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.trust_page);
                                    },
                                    behavior: HitTestBehavior.opaque,
                                  )
                                ],
                              )),
                          Expanded(child: Container()),
                          Container(
                            color: Colours.colorEE,
                            width: double.infinity,
                            height: ScreenUtil().setWidth(1),
                          )
                        ],
                      ),
                      color: Colours.background,
                    );
                  })),
          ((commissionType == 0 && trustDatas.length > 0) || (commissionType == 1 && trustHistoryDatas.length > 0))
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    commissionType == 0 ? _buildTruRow : _buildHisRow,
                    childCount: commissionType == 0 ? trustDatas.length : trustHistoryDatas.length,
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(
                    height: entrustHeight,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [MImage.icEmpty, Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(30))), Text('${getString().zwsj}', style: TextStyles.textGrey12)],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  _buildHead() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
          height: ScreenUtil().setWidth(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        MImage.icBtcMenu,
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(27))),
                        Text(
                          '${market1.toUpperCase()}/${market2.toUpperCase()}',
                          style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  _riceFallTxt()
                ],
              ),
              InkWell(
                child: Row(
                  children: [MImage.icBtcKlineThree, Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(14))), Text("${getString().kx}", style: TextStyles.textBlack14)],
                ),
                onTap: () {
                  Navigator.pushNamed(context, PageTransactionRouter.k_line_page,
                      arguments: Bundle()
                        ..putString('market1', market1)
                        ..putString('market2', market2));
                },
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(30))),
            Expanded(child: _buildLeft()),
            Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(34))),
            Expanded(child: _buildRight()),
          ],
        ),
        Container(
          color: Colours.colorF5,
          height: ScreenUtil().setWidth(16),
          width: double.infinity,
        )
      ],
    );
  }

  _riceFallTxt() {
    String riceFallTxt = '   --   ';
    Color riceFallBgColor = Colours.textGrey;
    Color riceFallTxtColor = Colors.white;
    if (marketDetailBean != null && marketDetailBean.riceFall != null && marketDetailBean.riceFall.length > 0) {
      if (!marketDetailBean.riceFall.contains('0.00')) {
        riceFallTxt = marketDetailBean.riceFall + '%';
        if (!marketDetailBean.riceFall.startsWith('-')) {
          riceFallBgColor = Colours.color1416A47A;
          riceFallTxtColor = Colours.FF16A47A;
          riceFallTxt = '+' + marketDetailBean.riceFall + '%';
        } else {
          riceFallBgColor = Colours.color14D94F57;
          riceFallTxtColor = Colours.colorFFD94F57;
        }
      } else {
        riceFallTxt = '0.00%';
      }
    }
    return Container(
      alignment: Alignment.center,
      height: ScreenUtil().setWidth(42),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(14)),
      child: Text(
        riceFallTxt,
        style: TextStyle(color: riceFallTxtColor, fontSize: ScreenUtil().setSp(24)),
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(11)),
      decoration: BoxDecoration(color: riceFallBgColor, borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }

  String an1 = '';
  String an2 = '';
  String an3 = '';
  String an4 = '';

  getBuy() {
    if (getLocale() == 'zh') {
      an1 = 'zwmr1';
      an2 = 'zwmr2';
      an3 = 'zwmr3';
      an4 = 'zwmr4';
    } else if (getLocale() == 'ms') {
      an1 = 'msmr1';
      an2 = 'msmr2';
      an3 = 'msmr3';
      an4 = 'msmr4';
    } else if (getLocale() == 'th') {
      an1 = 'thmr1';
      an2 = 'thmr2';
      an3 = 'thmr3';
      an4 = 'thmr4';
    } else {
      an1 = 'ic_by_wait_white1';
      an2 = 'ic_sell_btn2';
      an3 = 'ic_by_btn2';
      an4 = 'ic_trans_sell_green1';
    }
  }

  _buildLeft() {
    getBuy();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            replacement: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  child: LoadImage(an1, width: double.infinity, fit: BoxFit.fill, height: ScreenUtil().setWidth(70)),
                  onTap: () {
                    setState(() {
                      cleanPrice();
                      currentPerIndex = 0;
                      isBy = true;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                )),
                Expanded(child: LoadImage(an2, width: double.infinity, fit: BoxFit.fill, height: ScreenUtil().setWidth(70)))
              ],
            ),
            child: Row(
              children: [
                Expanded(child: LoadImage(an3, width: double.infinity, fit: BoxFit.fill, height: ScreenUtil().setWidth(70))),
                Expanded(
                    child: GestureDetector(
                  child: LoadImage(an4, width: double.infinity, fit: BoxFit.fill, height: ScreenUtil().setWidth(70)),
                  onTap: () {
                    setState(() {
                      cleanPrice();
                      currentPerIndex = 0;
                      isBy = false;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                )),
              ],
            ),
            visible: isBy,
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(16)),
            height: ScreenUtil().setWidth(80),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    width: ScreenUtil().setWidth(70),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colours.colorFFF7F7FA, borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)), border: Border.all(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1))),
                    child: LoadImage('icon_trading_jian', width: ScreenUtil().setWidth(24), fit: BoxFit.fill, height: ScreenUtil().setWidth(24)),
                  ),
                  onTap: () {
                    if (num.parse(currentPrice) <= 0) {
                      currentPrice = '0.00';
                      _priceController.text = '';
                      return;
                    }
                    currentPrice = '${NumUtil.subtract(num.parse(currentPrice), inNum)}';
                    _priceController.text = currentPrice.contains('.') ? currentPrice : int.parse(currentPrice);
                    _priceController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _priceController.text.length));

                    refreshPrice();
                  },
                  behavior: HitTestBehavior.opaque,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1)), bottom: BorderSide(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1)))),
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _priceController,
                    keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                    decoration: InputDecoration(counterText: '', border: InputBorder.none, hintText: '${getString().jg}(${market2.toUpperCase()})', hintStyle: TextStyles.textGrey14),
                    style: TextStyles.textBlack14,
                    maxLength: 12,
                    // onChanged: (value) {
                    //   currentPrice = value;
                    //   try {
                    //     if (_sizeController.text.length != 0 && _priceController.text.length != 0) turnover = (double.parse(_sizeController.text) * double.parse(_priceController.text)).toString();
                    //     setState(() {});
                    //   } catch (e) {}
                    // },
                  ),
                )),
                GestureDetector(
                  child: Container(
                    width: ScreenUtil().setWidth(70),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colours.colorFFF7F7FA, borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)), border: Border.all(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1))),
                    child: LoadImage('icon_trading_add', width: ScreenUtil().setWidth(24), fit: BoxFit.fill, height: ScreenUtil().setWidth(24)),
                  ),
                  onTap: () {
                    if (num.parse(currentPrice) <= 0) {
                      currentPrice = '0.00';
                    }
                    currentPrice = '${NumUtil.add(num.parse(currentPrice), inNum)}';
                    _priceController.text = currentPrice.contains('.') ? currentPrice : int.parse(currentPrice);
                    _priceController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _priceController.text.length));

                    refreshPrice();
                  },
                  behavior: HitTestBehavior.opaque,
                )
              ],
            ),
          ),
          Text(
            "≈¥ $unitPrice",
            style: TextStyles.textGrey12,
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(44), bottom: ScreenUtil().setWidth(16)),
            height: ScreenUtil().setWidth(80),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    width: ScreenUtil().setWidth(70),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colours.colorFFF7F7FA, borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)), border: Border.all(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1))),
                    child: LoadImage('icon_trading_jian', width: ScreenUtil().setWidth(24), fit: BoxFit.fill, height: ScreenUtil().setWidth(24)),
                  ),
                  onTap: () {
                    if (num.parse(_sizeController.text) <= 0) {
                      _sizeController.text = '0';
                      return;
                    }
                    currentCySize = '${NumUtil.subtract(num.parse(_sizeController.text), 1)}';
                    _sizeController.text = NumUtil.formatNum(currentCySize, _sizeController.text.contains('.') ? 4 : 0).toString();
                    _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _sizeController.text.length));
                    refreshPrice();
                  },
                  behavior: HitTestBehavior.opaque,
                ),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1)), bottom: BorderSide(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1)))),
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _sizeController,
                        keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                        decoration: InputDecoration(counterText: '', border: InputBorder.none, hintText: '${getString().sl}(${market1.toUpperCase()})', hintStyle: TextStyles.textGrey14),
                        style: TextStyles.textBlack14,
                        // onChanged: (value) {
                        //   // try {
                        //   // if (double.parse(_sizeController.text) >= 10000000) {
                        //   //   currentCySize = 10000000.toString();
                        //   //   _sizeController.text = 10000000.toString();
                        //   //   // currentCySize = NumUtil.formatNum(getAssetsWalletInfo(isBy ? market2 : market1).use_value, 4).toString();
                        //   //   // _sizeController.text = currentCySize;
                        //   //   // _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _sizeController.text.length));
                        //   //   return;
                        //   // } else {
                        //   //   currentCySize = NumUtil.formatNum(value, 4).toString();
                        //   //   _sizeController.text = currentCySize;
                        //   //   // _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _sizeController.text.length));
                        //   // }
                        //   // if (double.parse(_sizeController.text) == 0) {}
                        //   // if (_sizeController.text == '00') {
                        //   //   _sizeController.text = '0';
                        //   //   _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _sizeController.text.length));
                        //   // }
                        //   // } catch (e) {
                        //   //   _sizeController.text = '';
                        //   // }
                        //
                        //   try {
                        //     if (value.contains('.')) {
                        //       var ls = value.split('.');
                        //       if (ls[1].length > 4) {
                        //         currentCySize = value.substring(0, value.indexOf('.') + 4);
                        //         _sizeController.text = currentCySize;
                        //         // _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: currentCySize.length));
                        //         setState(() {});
                        //       }
                        //     } else {
                        //       currentCySize = value;
                        //     }
                        //   } catch (e) {}
                        //
                        //   refreshPrice();
                        // },
                      ),
                    ),
                    flex: 1),
                GestureDetector(
                  child: Container(
                    width: ScreenUtil().setWidth(70),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colours.colorFFF7F7FA, borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)), border: Border.all(color: Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1))),
                    child: LoadImage('icon_trading_add', width: ScreenUtil().setWidth(24), fit: BoxFit.fill, height: ScreenUtil().setWidth(24)),
                  ),
                  onTap: () {
                    if (num.parse(_sizeController.text) <= 0) {
                      _sizeController.text = '0';
                    }
                    currentCySize = '${NumUtil.add(num.parse(_sizeController.text), 1)}';
                    _sizeController.text = NumUtil.formatNum(currentCySize, _sizeController.text.contains('.') ? 4 : 0).toString();
                    _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _sizeController.text.length));
                    refreshPrice();
                  },
                  behavior: HitTestBehavior.opaque,
                )
              ],
            ),
          ),
          Text(
            "${getString().ky} ${!GlobalTransaction.isLogin || GlobalTransaction.walletInfo == null || GlobalTransaction.walletInfo.is_activation == null || GlobalTransaction.walletInfo.is_activation == '0' || getAssetsWalletInfo(market2) == null || getAssetsWalletInfo(market1) == null ? 0.0 : isBy ? NumUtil.formatNum(getAssetsWalletInfo(market2).use_value ?? '0.0', 4) : NumUtil.formatNum(getAssetsWalletInfo(market1).use_value ?? '0.0', 4) ?? 0.0} ${isBy ? market2.toUpperCase() : market1.toUpperCase()}",
            style: TextStyles.textGrey12,
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(42)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPercent(1, '25%'),
                _buildPercent(2, '50%'),
                _buildPercent(3, '75%'),
                _buildPercent(4, '100%'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${getString().jye}", style: TextStyles.textGrey15),
              Expanded(
                  child: Text(
                "$turnover ${market2.toUpperCase()}",
                textAlign: TextAlign.right,
                style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold),
              ))
            ],
          ),
          SizedBox(height: 20),
          Expanded(child: Container()),
          GestureDetector(
              onTap: () {
                offerCreate();
              },
              child: Container(
                decoration: BoxDecoration(color: isBy ? Colours.colorFFDAFFF5 : Colours.colorFFFFEDF0, borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(44)),
                height: ScreenUtil().setWidth(88),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  isBy ? "${getString().mr}$market1" : "${getString().mc}$market1",
                  style: TextStyles.textWhite16,
                ),
              ))
        ],
      ),
      height: ScreenUtil().setWidth(806),
    );
  }

  refreshPrice() {
    try {
      if (_sizeController.text.length != 0 && _priceController.text.length != 0) {
        turnover = NumUtil.formatNum(NumUtil.multiplyDec(num.parse(_sizeController.text), num.parse(_priceController.text)).toString(), 6).toString();
      } else {
        turnover = '0.0';
      }
      unitPrice = NumUtil.formatNum((double.parse(_priceController.text) * double.parse(exchangeRate)).toString(), 4).toString();
    } catch (e) {}
    if (mounted) setState(() {});
  }

  int currentPerIndex = 0;

  _buildPercent(int index, String txt) {
    return GestureDetector(
      child: Container(
        child: Text(
          '$txt',
          style: currentPerIndex == index ? TextStyle(color: Colours.colorFFC939F3, fontSize: ScreenUtil().setSp(22)) : TextStyles.textGrey11,
        ),
        width: ScreenUtil().setWidth(82),
        height: ScreenUtil().setWidth(48),
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: currentPerIndex == index ? Colours.colorFFC939F3 : Colours.colorFFEBEBEB, width: ScreenUtil().setWidth(1)), borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
      onTap: () {
        if (currentPerIndex != index) {
          currentPerIndex = index;
          switch (currentPerIndex) {
            case 1:
              currentCySize = isBy ? (NumUtil.multiply(double.parse(getAssetsWalletInfo(market2).use_value ?? 0.0), 0.25) / double.parse(_priceController.text)).toString() : NumUtil.multiply(double.parse(getAssetsWalletInfo(market1).use_value ?? 0.0), 0.25).toString();
              break;
            case 2:
              currentCySize = isBy ? (NumUtil.multiply(double.parse(getAssetsWalletInfo(market2).use_value ?? 0.0), 0.5) / double.parse(_priceController.text)).toString() : NumUtil.multiply(double.parse(getAssetsWalletInfo(market1).use_value ?? 0.0), 0.5).toString();
              break;
            case 3:
              currentCySize = isBy ? (NumUtil.multiply(double.parse(getAssetsWalletInfo(market2).use_value ?? 0.0), 0.75) / double.parse(_priceController.text)).toString() : NumUtil.multiply(double.parse(getAssetsWalletInfo(market1).use_value ?? 0.0), 0.75).toString();
              break;
            case 4:
              currentCySize = isBy ? (NumUtil.multiply(double.parse(getAssetsWalletInfo(market2).use_value ?? 0.0), 1) / double.parse(_priceController.text)).toString() : NumUtil.multiply(double.parse(getAssetsWalletInfo(market1).use_value ?? 0.0), 1).toString();
              break;
          }
          double ls = NumUtil.formatNum(currentCySize, 4);

          double fee = ls * 0.002;
          ls.isNaN ? ls = 0.0 : ls = ls - fee;

          currentCySize = currentCySize == '0.0' || currentCySize == 'NaN' ? '0' : ls.toString();
          _sizeController.text = currentCySize;
          _sizeController.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: _sizeController.text.length));
          refreshPrice();
        } else {
          setState(() {
            currentPerIndex = 0;
          });
        }
        if (mounted) setState(() {});
      },
      behavior: HitTestBehavior.opaque,
    );
  }

  _buildRight() {
    return Container(
      height: ScreenUtil().setWidth(806),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(16), left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('${getString().jg}', style: TextStyles.textGrey11), Text('${getString().sl}', style: TextStyles.textGrey11)],
            ),
          ),
          Offstage(
              child: Container(
                child: ListView.builder(
                  itemBuilder: _buildSigItem1,
                  itemCount: gear == 0 ? 5 : 10,
                ),
                height: ScreenUtil().setWidth(gearLVHeight),
              ),
              offstage: gear == 1),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(12), bottom: ScreenUtil().setWidth(14)),
            color: Colours.colorF5,
            width: double.infinity,
            height: ScreenUtil().setWidth(2),
          ),
          GestureDetector(
              onTap: () {
                if (marketDetailBean == null || marketDetailBean.close == null || marketDetailBean.close.contains('--')) return;
                if (num.parse(marketDetailBean?.close) <= 0) {
                  currentPrice = '0.00';
                  return;
                }
                currentPrice = '${marketDetailBean?.close}';
                _priceController.text = currentPrice;
                refreshPrice();
              },
              child: Text(
                marketDetailBean?.close ?? '--',
                style: TextStyle(color: Colours.colorFFFE3B58, fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.bold),
              )),
          GestureDetector(
              onTap: () {
                if (marketDetailBean == null || marketDetailBean.close == null || marketDetailBean.close.contains('--')) return;
                if (num.parse(marketDetailBean?.close) <= 0) {
                  marketDetailBean?.close = '0.00';
                  return;
                }
                currentPrice = '${marketDetailBean?.close}';
                _priceController.text = currentPrice;
                refreshPrice();
              },
              child: Text(
                '≈¥ ${marketDetailBean?.amountCny ?? '--'}',
                style: TextStyles.textGrey12,
              )),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(15), bottom: ScreenUtil().setWidth(14)),
            color: Colours.colorF5,
            width: double.infinity,
            height: ScreenUtil().setWidth(2),
          ),
          Offstage(
            child: Container(
              child: ListView.builder(
                itemBuilder: _buildSigItem2,
                itemCount: gear == 0 ? 5 : 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              height: ScreenUtil().setWidth(gearLVHeight),
            ),
            offstage: gear == 2,
          ),
          Expanded(child: Container()),
          _buildTag(),
        ],
      ),
    );
  }

  Widget _buildSigItem1(BuildContext context, int index) {
    int drift = (gear == 0) ? 5 : 0;
    LevelInfo info = sells[index + drift];
    double percentage = 0.0;
    if (info.orderPrice != null && !info.orderPrice.contains('--')) {
      percentage = (double.parse(info.orderSucValue) / double.parse(info.valueMerge)) * 100;
    }
    return Container(
      child: _buildSigRightItem(getDecimal(info.orderPrice), info.lastValue, ColorsUtil.hexColor(0xEC4C67, alpha: 0.08), Colours.colorFFFFEDF0, gearWidth * percentage),
    );
  }

  Widget _buildSigItem2(BuildContext context, int index) {
    LevelInfo info = buys[index];
    double percentage = 0.0;
    if (info.orderPrice != null && !info.orderPrice.contains('--')) {
      percentage = (double.parse(info.orderSucValue) / double.parse(info.valueMerge)) * 100;
    }

    return Container(
      child: _buildSigRightItem(getDecimal(info.orderPrice), info.lastValue, ColorsUtil.hexColor(0x16A47A, alpha: 0.08), Colours.colorFFDAFFF5, gearWidth * percentage),
    );
  }

  _buildTag() {
    return Container(
      margin: EdgeInsets.only(right: adaptationDp(5), bottom: ScreenUtil().setWidth(44)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setWidth(44),
                padding: EdgeInsets.only(left: adaptationDp(5), right: adaptationDp(5)),
                decoration: BoxDecoration(border: Border.all(color: Colours.colorE6, width: 0.5), borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(child: Text('${getString().sdd}$depthType', style: TextStyles.textGrey12), padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(4))),
                    Gaps.hGap5,
                  ],
                )),
            onTap: () {
              selectBonus(voidCallback: (data) {
                if (data == null) return;
                depthType = data;
                setState(() {});
                switchWs();
              });
            },
          ),
          GestureDetector(
            child: Row(
              children: [
                LoadImage(
                  gear == 2 ? 'ic_by_select_tag' : 'ic_by_tag',
                  width: ScreenUtil().setWidth(44),
                  height: ScreenUtil().setWidth(44),
                ),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Text('${getString().m}', style: TextStyles.textGrey11)
              ],
            ),
            onTap: () {
              if (gear != 2) {
                gearLVHeight = 500;
                setState(() {
                  gear = 2;
                });
              }
            },
            behavior: HitTestBehavior.opaque,
          ),
          GestureDetector(
            child: Row(
              children: [
                LoadImage(
                  gear == 1 ? 'ic_sale_select_tag' : 'ic_sale_tag',
                  width: ScreenUtil().setWidth(44),
                  height: ScreenUtil().setWidth(44),
                ),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Text('${getString().mm}', style: TextStyles.textGrey11)
              ],
            ),
            onTap: () {
              if (gear != 1) {
                gearLVHeight = 500;
                setState(() {
                  gear = 1;
                });
              }
            },
            behavior: HitTestBehavior.opaque,
          ),
          GestureDetector(
            child: Row(
              children: [
                LoadImage(gear == 0 ? 'ic_all_select_tag' : 'ic_all_tag', width: ScreenUtil().setWidth(44), height: ScreenUtil().setWidth(44)),
                // SizedBox(width: ScreenUtil().setWidth(10)),
                // Text('${getString().qbb}', style: TextStyles.textGrey11)
              ],
            ),
            onTap: () {
              if (gear != 0) {
                gearLVHeight = 250;
                setState(() {
                  gear = 0;
                });
              }
            },
            behavior: HitTestBehavior.opaque,
          ),
        ],
      ),
    );
  }

  _buildSigRightItem(String left, String right, Color bgC, Color ftC, double w) {
    w.isNaN ? w = 0 : w = w;
    return InkWell(
      child: Container(
        alignment: Alignment.centerRight,
        height: ScreenUtil().setWidth(50),
        child: Stack(
          children: [
            Align(
              child: Container(
                height: double.infinity,
                width: w,
                color: bgC,
              ),
              alignment: Alignment.centerRight,
            ),
            Container(
              height: double.infinity,
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    left ?? '--',
                    style: TextStyle(color: ftC, fontSize: ScreenUtil().setSp(24)),
                  ),
                  Text(
                    right ?? '--',
                    style: TextStyles.textBlack12,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (!left.contains('--')) {
          currentPrice = left;
          _priceController.text = left;
        }
      },
    );
  }

  _buildBotom() {
    return Container(
        color: MColor.white,
        child: Column(
          children: [
            MDivider(),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  MBuilder.text('${getString().dqwt}', size: 18, weight: FontWeight.w500),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
            MDivider(height: 1),
          ],
        ));
  }

  Widget _buildTruRow(BuildContext context, int index) {
    TrustData trustData = trustDatas[index];
    if (trustData == null) return Container();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(36), horizontal: ScreenUtil().setWidth(30)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${trustData.direction != null && trustData.direction.contains('sell') ? '${getString().mc}' : '${getString().mr}'}$market1/$market2',
                          style: TextStyle(color: trustData.direction != null && trustData.direction != null && trustData.direction.contains('sell') ? Colours.colorFFFFEDF0 : Colours.colorFFDAFFF5, fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.bold)),
                      Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(28))),
                      Text(trustData.orderOrigTime == null ? '' : DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(trustData.orderOrigTime) * 1000).toString()), style: TextStyles.textGrey12)
                    ],
                  ),
                  Row(
                    children: [
                      Text('${trustData.orderStatusStr}', style: TextStyles.textGrey11),
                      Gaps.hGap5,
                      InkResponse(
                          onTap: () {
                            offerDel(trustData.tid);
                          },
                          child: trustData.orderStatus == 'chainFail' || trustData.orderStatus == 'validateFail'
                              ? Container(
                                  decoration: BoxDecoration(color: ColorsUtil.hexColor(0xcB98E40, alpha: 0.09), borderRadius: BorderRadius.all(Radius.circular(4))),
                                  width: ScreenUtil().setWidth(100),
                                  height: ScreenUtil().setWidth(50),
                                  alignment: Alignment.center,
                                  child: Text('${getString().sc}', style: TextStyle(color: Colours.colorFFC939F3, fontSize: ScreenUtil().setSp(24))),
                                )
                              : Container()),
                      InkResponse(
                          onTap: () {
                            offerCancel(trustData.hash);
                          },
                          child: trustData.hash == null
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(color: ColorsUtil.hexColor(0xcB98E40, alpha: 0.09), borderRadius: BorderRadius.all(Radius.circular(4))),
                                  width: ScreenUtil().setWidth(100),
                                  height: ScreenUtil().setWidth(50),
                                  alignment: Alignment.center,
                                  child: Text('${getString().cxx}', style: TextStyle(color: Colours.colorFFC939F3, fontSize: ScreenUtil().setSp(24))),
                                ))
                    ],
                  )
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(34)),
              Row(
                children: [
                  Expanded(
                    child: Text('${getString().wtjg}($market2)', style: TextStyles.textB4B4B424),
                  ),
                  Expanded(
                      child: Text(
                    '${getString().wtsl}($market1)',
                    style: TextStyles.textB4B4B424,
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: Text('${getString().sjcg}($market1)', style: TextStyles.textB4B4B424, textAlign: TextAlign.right),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(24)),
              Row(
                children: [
                  Expanded(
                    child: Text('${NumUtil.formArtNum(double.parse(trustData.price) ?? 0.0, 4)}', style: TextStyles.textBlack14),
                  ),
                  Expanded(
                      child: Text(
                    '${NumUtil.formArtNum(double.parse(trustData.amount) ?? 0.0, 4)}',
                    style: TextStyles.textBlack14,
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: Text('${NumUtil.formArtNum(double.parse(trustData.amountSuc) ?? 0.0, 4)}', style: TextStyles.textBlack14, textAlign: TextAlign.right),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colours.colorEE,
          height: ScreenUtil().setWidth(1),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        ),
      ],
    );
  }

  Widget _buildHisRow(BuildContext context, int index) {
    var trustData = trustHistoryDatas[index];
    String statusTip;
    if (trustData.order_status == '0') {
      statusTip = '${getString().bfcj}';
    } else {
      statusTip = '${getString().wqcj}';
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(34), horizontal: ScreenUtil().setWidth(30)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${trustData.direction.contains('sell') ? '${getString().mc}' : '${getString().mr}'}${trustData.market1.toUpperCase()}/${trustData.market2.toUpperCase()}',
                      style: TextStyle(color: trustData.direction.contains('sell') ? Colours.colorFFFFEDF0 : Colours.colorFFDAFFF5, fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.bold)),
                  Text(statusTip, style: TextStyles.textBlack13)
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(37)),
              Row(
                children: [
                  Expanded(
                    child: Text('${getString().qbb}', style: TextStyles.textB4B4B424),
                  ),
                  Expanded(
                      child: Text(
                    '${getString().wtjg}(${trustData.market2.toUpperCase()})',
                    style: TextStyles.textB4B4B424,
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: Text('${getString().wtsl}(${trustData.market1.toUpperCase()})', style: TextStyles.textB4B4B424, textAlign: TextAlign.right),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(24)),
              Row(
                children: [
                  Expanded(
                    child: Text(DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(trustData.ts) * 1000).toString(), format: 'MM/dd HH:mm'), style: TextStyles.textBlack14),
                  ),
                  Expanded(
                      child: Text(
                    '${NumUtil.formArtNum(double.parse(trustData.prev_unit_price) ?? 0.0, 4)}',
                    style: TextStyles.textBlack14,
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: Text('${NumUtil.formArtNum(double.parse(trustData.prev_amount_sum) ?? 0.0, 4)}', style: TextStyles.textBlack14, textAlign: TextAlign.right),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(34)),
              Row(
                children: [
                  Expanded(
                    child: Text('${getString().cjze}(${trustData.market2.toUpperCase()})', style: TextStyles.textB4B4B424),
                  ),
                  Expanded(
                      child: Text(
                    '${getString().cjjj}(${trustData.market2.toUpperCase()})',
                    style: TextStyles.textB4B4B424,
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: Text('${getString().jyl}(${trustData.market1.toUpperCase()})', style: TextStyles.textB4B4B424, textAlign: TextAlign.right),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(24)),
              Row(
                children: [
                  Expanded(
                    child: Text('${NumUtil.formArtNum(double.parse(trustData.total_amount) ?? 0.0, 4)}', style: TextStyles.textBlack14),
                  ),
                  Expanded(
                      child: Text(
                    '${NumUtil.formArtNum(double.parse(trustData.unit_price) ?? 0.0, 4)}',
                    style: TextStyles.textBlack14,
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: Text('${NumUtil.formArtNum(double.parse(trustData.amount_sum) ?? 0.0, 4)}', style: TextStyles.textBlack14, textAlign: TextAlign.right),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colours.colorEE,
          height: ScreenUtil().setWidth(1),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        ),
      ],
    );
  }

  selectBonus({voidCallback}) {
    List<String> list = ['4', '3', '2', '1'];
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext contexts) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  Expanded(
                      child: new GestureDetector(
                    child: new Container(),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(child: Container(alignment: Alignment.center, padding: EdgeInsets.only(left: 20), child: Text("${getString().sdd}", style: TextStyles.textBlack18))),
                            InkResponse(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                child: LoadAssetImage(Images.combined_shape_26671, width: ScreenUtil().setWidth(30)),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    if (voidCallback != null) voidCallback(list[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                    alignment: Alignment.center,
                                    child: Text(list[index], style: TextStyles.textBlack14),
                                  ));
                            },
                            itemCount: list.length)
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  cleanPrice() {
    _sizeController.text = '';
    _priceController.text = '';
    setState(() {});
  }

  getData({isOne: false}) {
    GlobalTransaction.refreshWalletAssets();
    switchWs();
  }

  bool requestType = true;

  bool entrustType = true;

  timeNews() async {
    newsTimer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      if (mounted && GlobalTransaction.isNewsTimer) {
        if (GlobalTransaction.isWsOnHttp) {
          TransactionWebSocket().sinkSend('{"method":"pull_heart"}');
        } else {
          if (requestType) {
            switchWs();
          }
        }
        // getLevel();
        // getCurrentTrust();
        // getHistoryTrust();
        // getMarketDetail();
        // getBalance();
      }
    });
    newsTimer2 = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      if (mounted && GlobalTransaction.isNewsTimer) {
        if (entrustType) {
          getCurrentTrust();
          getHistoryTrust();
        }
      }
    });
  }

  //开始挂单
  offerCreate() {
    if (LayoutUtil.isLogin(context, isShowLogin: true) && LayoutUtil.isActivation(context)) {
      if (_sizeController.text.length == 0) {
        Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qsrgmsl}');
        return;
      } else if (_priceController.text.length == 0) {
        Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qsrgmjg}');
        return;
      }
      try {
        if (double.parse(_priceController.text) <= 0.0) {
          Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qsrgmjg}');
          return;
        } else {
          _priceController.text = double.parse(_priceController.text).toString();
        }
        if (double.parse(_sizeController.text) <= 0.0) {
          Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qsrgmsl}');
          return;
        } else {
          _sizeController.text = double.parse(_sizeController.text).toString();
        }
      } catch (e) {
        Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().qsrzqgmsljg}');
        return;
      }
      LayoutUtil.showLoadingDialog(context);
      Net().post(ApiTransaction.CHAIN_OFFER_CREATE, {
        'direction': isBy ? 'buy' : 'sell',
        'quantity_currency': market1,
        'quantity_value': _sizeController.text,
        'totalprice_currency': market2,
        'totalprice_value': turnover,
        'price': _priceController.text,
        'amount': _sizeController.text,
        'symbol': market1.toUpperCase() + '_' + market2.toUpperCase(),
      }, success: (data) {
        LayoutUtil.closeLoadingDialog(context);
        cleanPrice();
        Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().gdcg}');
      }, failure: (error) {
        LayoutUtil.closeLoadingDialog(context);
        Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$error');
      });
      // Net().post(Api.CHAIN_OFFER_POUNDAGE, {
      //   'account':Global.walletInfo.account_id,
      //   'symbol': market1.toUpperCase() + '_' + market2.toUpperCase(),
      //   'currency': isBy ? market2 : market1,
      //   'value': _sizeController.text,
      // }, success: (data) {
      //   LayoutUtil.closeLoadingDialog(context);
      //   showModalBottomSheet(
      //       isScrollControlled: true,
      //       backgroundColor: Colours.transparent,
      //       context: context,
      //       builder: (builder) {
      //         return TransactionBuySellDialog(isBy ? '1 $market1≈${_priceController.text} $market2' : '1 $market1≈${_priceController.text} $market2', '${_sizeController.text} $market1', '$turnover $market2', '${data['poundage']} ${Global.coin}', isBy, () {
      //           Navigator.pop(context);
      //           LayoutUtil.showLoadingDialog(context, msg: '挂单中...');
      //           Net().post(Api.CHAIN_OFFER_CREATE, {
      //             'direction': isBy ? 'buy' : 'sell',
      //             'quantity_currency': market1,
      //             'quantity_value': _sizeController.text,
      //             'totalprice_currency': market2,
      //             'totalprice_value': turnover,
      //             'price': _priceController.text,
      //             'amount': _sizeController.text,
      //             'symbol': market1.toUpperCase() + '_' + market2.toUpperCase(),
      //           }, success: (data) {
      //             LayoutUtil.closeLoadingDialog(context);
      //
      //             Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '挂单成功');
      //           }, failure: (error) {
      //             LayoutUtil.closeLoadingDialog(context);
      //             Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
      //           });
      //         });
      //       });
      // }, failure: (error) {
      //   LayoutUtil.closeLoadingDialog(context);
      //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
      // });
    }
  }

  //取消挂单
  offerCancel(transaction) {
    LayoutUtil.showLoadingDialog(context, msg: '${getString().cdz}');
    Net().post(ApiTransaction.CHAIN_OFFER_CANCEL, {'hash': transaction}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      switchWs();
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().cdcg}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$error');
    });
  }

  //删除挂单
  offerDel(transaction) {
    LayoutUtil.showLoadingDialog(context, msg: '${getString().scz}');
    Net().post(ApiTransaction.ORDER_HIDE, {'tid': transaction}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      switchWs();
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().sccg}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '$error');
    });
  }

  startWs() {
    TransactionWebSocket.on(({arg}) {
      if (arg['method'] == 'pull_heart' || arg['data'] == null) return;
      switch (arg['method']) {
        case 'pull_order_marge':
          pullOrderMarge(arg['data']);
          break;
        case 'pull_market_detail':
          pullMarketDetail(arg['data']);
          break;
        case 'pull_offer_balance':
          pullOfferBalance(arg['data']);
          break;
        case 'pull_order_list':
          pullOrderList(arg['data']);
          break;
        case 'pull_order_history':
          pullOrderHistory(arg['data']);
          break;
      }

      if (mounted) setState(() {});
    });

    TransactionWebSocket().sinkSend('{"method":"pull_order_marge","data":{"market":"${market1}_$market2","decimal":"$depthType"}}');

    TransactionWebSocket().sinkSend('{"method":"pull_market_detail","data":{"market":"${market1}_$market2"}}');
  }

  switchWs() {
    if (GlobalTransaction.isWsOnHttp) {
      TransactionWebSocket().closeWebSocket();
      TransactionWebSocket().connect();

      TransactionWebSocket().sinkSend('{"method":"pull_order_marge","data":{"market":"${market1}_$market2","decimal":"$depthType"}}');
      TransactionWebSocket().sinkSend('{"method":"pull_market_detail","data":{"market":"${market1}_$market2"}}');
      if (GlobalTransaction.isLogin && GlobalTransaction.walletInfo != null) {
        TransactionWebSocket().sinkSend('{"method":"pull_offer_balance","data":{"account":"${GlobalTransaction.walletInfo.account_id}"}}');
        TransactionWebSocket().sinkSend('{"method":"pull_order_list","data":{"account":"${GlobalTransaction.walletInfo.account_id}","market":"${market1}_$market2"}}');
        TransactionWebSocket().sinkSend('{"method":"pull_order_history","data":{"account":"${GlobalTransaction.walletInfo.account_id}","market":"${market1}_$market2"}}');
      }
    } else {
      getLevel();
      getBalance();
      getMarketDetail();
      // getCurrentTrust();
      // getHistoryTrust();
    }
  }

  getDecimal(data) {
    if (data == '--') return data;
    return NumUtil.formArtNum(double.parse(data), 4);
    // switch (depthType) {
    //   case '4':
    //     return NumUtil.formArtNum(double.parse(data), 4);
    //   case '3':
    //     return NumUtil.formArtNum(double.parse(data), 4);
    //   case '2':
    //     return NumUtil.formArtNum(double.parse(data), 4);
    //   case '1':
    //     return NumUtil.formArtNum(double.parse(data), 4);
    // }
  }

  //上下五档
  pullOrderMarge(data) {
    // if (levelData.buy != null && levelData.buy.length != 0 && levelData.buy[0].deci != depthType) return;
    //
    LevelTick levelData = LevelTick.fromJson(data);
    if (levelData.buy != null && levelData.buy.length != 0 && levelData.buy[0].deci != depthType) return;
    //
    if (levelData.sell != null && (levelData.buy.length != 0 && (levelData.buy[0].symbol.toUpperCase() != market1.toUpperCase() + '_' + market2.toUpperCase())) ||
        levelData.sell != null && levelData.sell.length != 0 && levelData.sell[0].symbol.toUpperCase() != market1.toUpperCase() + '_' + market2.toUpperCase()) {
      // buys.clear();
      // sells.clear();

      // for (int i = 0; i < 10; i++) {
      //   sells.add(LevelInfo()
      //     ..orderPrice = '--'
      //     ..lastValue = '--');
      // }
      // for (int i = 0; i < 10; i++) {
      //   buys.add(LevelInfo()
      //     ..orderPrice = '--'
      //     ..lastValue = '--');
      // }
      return;
    }

    if (levelData.buy != null && levelData.buy.length != 0) {
      buys.clear();
      buys.addAll(levelData.buy);
    }

    if (buys.length < 10) {
      for (int i = buys.length; i < 10; i++) {
        buys.add(LevelInfo()
          ..orderPrice = '--'
          ..lastValue = '--');
      }
    }

    if (levelData.sell != null && levelData.sell.length != 0) {
      sells.clear();
      if (levelData.sell.length < 10) {
        for (int i = 0; i < (10 - levelData.sell.length); i++) {
          sells.add(LevelInfo()
            ..orderPrice = '--'
            ..lastValue = '--');
        }
        levelData.sell.forEach((element) {
          sells.add(element);
        });
      } else {
        sells.addAll(levelData.sell);
      }
    }
  }

  //行情
  pullMarketDetail(data) {
    if (MarketDetailBean.fromJson(data).symbol != null && MarketDetailBean.fromJson(data).symbol.toUpperCase() != market1.toUpperCase() + '_' + market2.toUpperCase()) return;
    marketDetailBean = MarketDetailBean.fromJson(data);
  }

  pullOfferBalance(data) {
    assetsList.clear();
    data.forEach((element) {
      assetsList.add(WalletAssets.fromJson(element));
    });
  }

  pullOrderList(data) {
    trustDatas.clear();
    data?.forEach((v) {
      trustDatas.add(new TrustData.fromJson(v));
    });
  }

  pullOrderHistory(data) {
    trustHistoryDatas.clear();

    data.forEach((v) {
      trustHistoryDatas.add(new TrustHistory.fromJson(v));
    });

    if (trustHistoryDatas.length != 0 && trustHistoryDatas[0].symbol.toUpperCase() != market1.toUpperCase() + '_' + market2.toUpperCase()) return;

    if (mounted) setState(() {});
  }

  getLevel({isOne = false, isBuffer = false}) {
    // if (isBuffer) {
    //   if (SpUtil.hasKey('transaction_order_marge_buys')) {
    //     buys = SpUtil.getObjList('transaction_order_marge_buys', (v) => LevelInfo.fromJson(v));
    //   }
    //   if (SpUtil.hasKey('transaction_order_marge_sell')) {
    //     sells = SpUtil.getObjList('transaction_order_marge_sell', (v) => LevelInfo.fromJson(v));
    //   }
    //   if (mounted) setState(() {});
    // }
    requestType = false;
    Net().post(ApiTransaction.pull_order_buysell, {'symbol': (market1.toUpperCase() + '_' + market2.toUpperCase()), "num": "$depthType"}, success: (data) {
      requestType = true;
      pullOrderMarge(data);
      return;
      LevelTick levelData = LevelTick.fromJson(data);
      if (levelData.buy != null) {
        buys.clear();
        buys.addAll(levelData.buy);
      }
      if (buys.length < 10) {
        for (int i = buys.length; i < 10; i++) {
          buys.add(LevelInfo()
            ..orderPrice = '--'
            ..lastValue = '--');
        }
      }

      if (levelData.sell != null) {
        sells.clear();
        if (levelData.sell.length < 10) {
          for (int i = 0; i < (10 - levelData.sell.length); i++) {
            sells.add(LevelInfo()
              ..orderPrice = '--'
              ..lastValue = '--');
          }
          levelData.sell.forEach((element) {
            sells.add(element);
          });
        } else {
          sells.addAll(levelData.sell);
        }
      }

      if (buys.length != 0) SpUtil.putObjectList('transaction_order_marge_buys', buys);
      if (sells.length != 0) SpUtil.putObjectList('transaction_order_marge_sell', sells);

      if (mounted) setState(() {});
    }, failure: (error) {
      requestType = true;
    });
  }

  List<WalletAssets> assetsList = [];

//根据币名获取资产信息
  WalletAssets getAssetsWalletInfo(String icon) {
    if (GlobalTransaction.isLogin) {
      if (assetsList == null) return null;
      for (int i = 0; i < assetsList.length; i++) {
        if (assetsList[i].currency == icon.toUpperCase()) {
          return assetsList[i];
        }
      }
      return null;
    }
    return null;
  }

  //获取币种
  getBalance() {
    Net().post(ApiTransaction.OFFER_BALANCE, null, success: (data) {
      pullOfferBalance(data);
      // assetsList.clear();
      // data.forEach((element) {
      //   assetsList.add(WalletAssets.fromJson(element));
      // });

      if (mounted) setState(() {});
    });
  }

  //获取委托
  getCurrentTrust({isBuffer = false}) {
    entrustType = false;
    if (LayoutUtil.isLogin(context, isShowLogin: false))
      Net().post(ApiTransaction.TRUST_LIST, {'symbol': market1.toUpperCase() + '_' + market2.toUpperCase(), 'orderStatus': 'canceled', 'account': GlobalTransaction.walletInfo.account_id}, other: market1.toUpperCase() + market2.toUpperCase(), success: (data, other) {
        entrustType = true;
        if (market1.toUpperCase() + market2.toUpperCase() != other) return;
        trustDatas.clear();
        List listTmp = data['list'];
        listTmp?.forEach((v) {
          trustDatas.add(new TrustData.fromJson(v));
        });
        // SpUtil.putObjectList('transaction_order_list', trustDatas);
        if (mounted) setState(() {});
      }, failure: (error) {
        entrustType = true;
      });
  }

  //获取历史记录
  getHistoryTrust({isBuffer = false}) {
    if (LayoutUtil.isLogin(context, isShowLogin: false))
      Net().post(ApiTransaction.ORDER_HISTORY, {'symbol': market1.toUpperCase() + '_' + market2.toUpperCase(), 'orderStatus': 'canceled', 'account': GlobalTransaction.walletInfo.account_id}, other: market1.toUpperCase() + market2.toUpperCase(), success: (data, other) {
        if (market1.toUpperCase() + market2.toUpperCase() != other) return;
        trustHistoryDatas.clear();
        data.forEach((v) {
          trustHistoryDatas.add(new TrustHistory.fromJson(v));
        });
        if (mounted) setState(() {});
      });
  }

  String exchangeRate;

  getHl() {
    Net().post(ApiTransaction.recharge_exchangerate, null, success: (data) {
      exchangeRate = data['exchangerate'];
      if (mounted) setState(() {});
    });
  }

  getMarketDetail({isBuffer = false, isOne = false}) {
    // if (isBuffer) {
    //   if (SpUtil.hasKey('transaction_market_detail${market1.toUpperCase() + market2.toUpperCase()}')) {
    //     marketDetailBean = SpUtil.getObj('transaction_market_detail${market1.toUpperCase() + market2.toUpperCase()}', (v) => MarketDetailBean.fromJson(v));
    //     try {
    //       if (isOne && marketDetailBean != null || isPrice) {
    //         _priceController.text = NumUtil.formatNum(marketDetailBean.close, 4).toString();
    //         unitPrice = marketDetailBean.amountCny;
    //       }
    //     } catch (e) {}
    //     if (mounted) setState(() {});
    //   }
    // }
    requestType = false;

    Net().post(ApiTransaction.market_detail, {"symbol": market1.toUpperCase() + '_' + market2.toUpperCase()}, other: market1.toUpperCase() + market2.toUpperCase(), success: (data, other) {
      requestType = true;

      if (market1.toUpperCase() + market2.toUpperCase() != other) return;

      marketDetailBean = MarketDetailBean.fromJson(data);
      // try {
      //   if (isOne && marketDetailBean != null || isPrice) {
      //     isPrice = false;
      //     _priceController.text = NumUtil.formatNum(marketDetailBean.close, 4).toString();
      //     unitPrice = marketDetailBean.amountCny;
      //   }
      // } catch (e) {}

      // SpUtil.putObject('transaction_market_detail${market1.toUpperCase() + market2.toUpperCase()}', marketDetailBean);
      if (mounted) setState(() {});
    }, failure: (error) {
      requestType = true;
    });
  }
}
