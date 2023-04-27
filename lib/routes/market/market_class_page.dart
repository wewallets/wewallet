import 'dart:async';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/marketList.dart';
import 'package:mars/socket/market_web_socket.dart';

///行情分类
class MarketClassPage extends StatefulWidget {
  final String type;

  MarketClassPage(this.type);

  @override
  _MarketClassPageState createState() => _MarketClassPageState();
}

class _MarketClassPageState extends State<MarketClassPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<MarketList> _allList = [];
  bool _loading = true;
  bool requestType = true;

  @override
  void initState() {
    super.initState();
    if (GlobalTransaction.isWsOnHttp)
      startWs();
    else
      getData();

    initEvent();

    timeNews();

    newsTimer.cancel();
    newsTimer = null;
    timeNews();
  }

  initEvent() async {
    EventBus().on('refreshQuotation', ({arg}) {
      if (GlobalTransaction.isWsOnHttp) {
        newsTimer.cancel();
        newsTimer = null;
        timeNews();
      }
    });
  }

  @override
  void dispose() {
    EventBus().off('refreshQuotation');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _loading == false
          ? Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoadImage('zhanwushuju', width: ScreenUtil().setWidth(220)),
                Gaps.vGap10,
                Text('${getString().zwsj}', style: TextStyle(fontSize: ScreenUtil().setSp(22), color: ColorsUtil.hexColor(0x999999))),
              ],
            ))
          : Stack(
              children: <Widget>[
                _allList.length == 0
                    ? LayoutUtil.getLoadingShadeCustom()
                    : ListView.builder(
                        padding: EdgeInsets.only(top: ScreenUtil().setWidth(60)),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Container(
                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(31), right: ScreenUtil().setWidth(29), top: ScreenUtil().setWidth(15), bottom: ScreenUtil().setWidth(15)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(TextSpan(children: [
                                            TextSpan(text: '${_allList[index].trad_currency_name} ', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                                            TextSpan(text: '/${_allList[index].base_currency_name}', style: TextStyles.textGrey11),
                                          ])),
                                          Text('24H${getString().l} ${_allList[index].amount ?? 0.0}', style: TextStyles.textGrey11),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Stack(
                                        children: [
                                          Text('\$${_allList[index].unit_price}', style: TextStyles.textBlack16.copyWith(color: _allList[index].rice_fall.contains('-') ? Colours.colorButton1 : Color(0xFF16A47A), fontWeight: FontWeight.bold)),
                                          // Align(
                                          //   alignment: Alignment.bottomLeft,
                                          //   child: Text('\$ ${_allList[index].cny_value}', style: TextStyles.textGrey11),
                                          // ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(color: _allList[index].rice_fall.contains('-') ? Colours.colorButton1 : Color(0xFF16A47A), borderRadius: BorderRadius.circular(2)),
                                            height: ScreenUtil().setWidth(66),
                                            width: ScreenUtil().setWidth(150),
                                            child: Text('${NumUtil.formArtNum(double.parse(_allList[index].rice_fall) ?? 0.0, 2)}%', style: TextStyles.textWhite14),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, PageTransactionRouter.k_line_page,
                                  arguments: Bundle()
                                    ..putString('market1', _allList[index].trad_currency_name)
                                    ..putString('market2', _allList[index].base_currency_name));
                            },
                          );
                        },
                        itemCount: _allList.length),
                getHeadTitleView(),
              ],
            ),
    );
  }

  Widget getHeadTitleView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      height: ScreenUtil().setWidth(74),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  Text('${getString().jyl}', style: TextStyles.textGrey12),
                  Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(12))),
                  LoadImage(
                    'icon_sort_default',
                    width: ScreenUtil().setWidth(14),
                    height: ScreenUtil().setWidth(21),
                  )
                ],
              )),
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  Text('${getString().zxj}', style: TextStyles.textGrey12),
                  Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(12))),
                  LoadImage(
                    'icon_sort_default',
                    width: ScreenUtil().setWidth(14),
                    height: ScreenUtil().setWidth(21),
                  )
                ],
              )),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${getString().zdf}', style: TextStyles.textGrey12),
                  Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(12))),
                  LoadImage(
                    'icon_sort_default',
                    width: ScreenUtil().setWidth(14),
                    height: ScreenUtil().setWidth(21),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Timer newsTimer;

  timeNews() async {
    newsTimer = Timer.periodic(Duration(milliseconds: GlobalTransaction.isWsOnHttp ? 4000 : 2000), (timer) {
      if (GlobalTransaction.isWsOnHttp) {
        MarketWebSocket().sinkSend('{"method":"pull_heart"}', isConnect: false);

        MarketWebSocket().sinkSend('{"method":"pull_market_list"}');
      } else {
        getData();
      }
    });
  }

  startWs() {
    MarketWebSocket.on(({arg}) {
      if (arg['method'] == 'pull_heart' || arg['data'] == null) return;
      switch (arg['method']) {
        case 'pull_market_list':
          if (_allList != null && _allList.length != 0)
            _allList.clear();
          else
            _allList = [];

          arg['data'].forEach((element) {
            _allList.add(MarketList.fromJson(element));
          });

          if (mounted) setState(() {});
          break;
      }

      if (mounted) setState(() {});
    });

    MarketWebSocket().sinkSend('{"method":"pull_market_list"}');
  }

  getData() {
    requestType = false;
    Net().post(ApiTransaction.pull_order_market, {'currency': widget.type}, success: (data) {
      requestType = true;
      if (_allList.length != 0)
        _allList.clear();
      else
        _allList = [];

      data.forEach((element) {
        _allList.add(MarketList.fromJson(element));
      });
      if (_allList.length == 0)
        _loading = false;
      else
        _loading = true;
      if (mounted) setState(() {});
    }, failure: (error) {
      requestType = true;

      if (_allList.length == 0)
        _loading = false;
      else
        _loading = true;
      if (mounted) setState(() {});
    });
  }
}
