import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/routes/market/market_class_page.dart';
import 'package:mars/widgets/my_underline_tab_indicator.dart';

//行情
class QuotationPage extends StatefulWidget {
  @override
  _QuotationPageState createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TabController _controller;
  List<String> tabList = ['USDT'];
  var tabBarView;

  @override
  void initState() {
    super.initState();
    // getClassCurrency();
    _controller = TabController(vsync: this, length: tabList.length);
    EventBus().on('refreshQuotation', ({arg}) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    EventBus().off('refreshQuotation');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: LayoutUtil.getAppBar(context, '${getString().hqq}', noLeading: false, elevation: 0.0),
      body: _controller == null
          ? LayoutUtil.getLoadingShadeCustom()
          : Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(6)),
                  height: ScreenUtil().setWidth(92),
                  width: double.infinity,
                  decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/market_head_bg.png'))),
                  child: TabBar(
                    unselectedLabelColor: Colours.colorFFB0A8C8,
                    unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(28)),
                    labelColor: Colours.colorFF7854D5,
                    labelStyle: TextStyle(fontSize: ScreenUtil().setSp(32)),
                    controller: _controller,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: ScreenUtil().setWidth(4), color: Colours.colorFF7854D5)),
                    tabs: tabList.map((e) => Text('$e')).toList(),
                  ),
                ),
                Flexible(
                  child: TabBarView(
                    children: tabList.map((e) => MarketClassPage(e)).toList(),
                    controller: _controller,
                  ),
                )
              ],
            ),
    );
  }

  // 获取分类币种
  getClassCurrency() {
    if (SpUtil.hasKey('basecurrencys')) {
      tabList = SpUtil.getStringList('basecurrencys');
      _controller = TabController(vsync: this, length: tabList.length);
      if (mounted) setState(() {});
    }
    Net().post(ApiTransaction.BASE_CY, null, success: (data) {
      tabList.clear();
      data.forEach((v) {
        tabList.add(v['currency_name']);
      });
      _controller = TabController(vsync: this, length: tabList.length);
      SpUtil.putStringList('basecurrencys', tabList);
    }, failure: (error) {});
  }
}
