import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/widgets/my_underline_tab_indicator.dart';

import 'currency_list_drawer.dart';

class CurrencyDrawer extends StatefulWidget {
  final int intoPage; //0:交易页面 1:K线
  CurrencyDrawer({Key key, this.intoPage}) : super(key: key);

  @override
  _CurrencyDrawerState createState() => _CurrencyDrawerState();
}

class _CurrencyDrawerState extends State<CurrencyDrawer> with TickerProviderStateMixin {
  TabController _controller;
  List<String> drawers = [];

  @override
  void initState() {
    super.initState();
    getClassCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141F31),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(106), bottom: ScreenUtil().setWidth(23)),
            child: Text('${getString().bb}', style: TextStyles.textWhite18.copyWith(fontWeight: FontWeight.bold)),
          ),
          _controller == null
              ? Container()
              : Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        unselectedLabelColor: Colours.textBlack,
                        unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.bold),
                        labelColor: Colours.colorFFC939F3,
                        labelStyle: TextStyle(fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.bold),
                        controller: _controller,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: EdgeInsets.only(bottom: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
                        indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: ScreenUtil().setWidth(3), color: Colours.colorFFC939F3)),
                        tabs: drawers.map((item) {
                          return Text(item);
                        }).toList(),
                      ),
                      Container(
                        color: Color(0xFF283547),
                        width: double.infinity,
                        height: ScreenUtil().setWidth(1),
                      )
                    ],
                  ),
                ),
          _controller == null
              ? Container()
              :  Flexible(
            child: TabBarView(
              children: drawers.map((item) {
                return CurrencyListDrawer(type: item, intoPage: widget.intoPage);
              }).toList(),
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
      drawers = SpUtil.getStringList('basecurrencys');
      _controller = TabController(vsync: this, length: drawers.length);
      if (mounted) setState(() {});
    }
    Net().post(ApiTransaction.BASE_CY, null, success: (data) {
      drawers.clear();
      data.forEach((v) {
        drawers.add(v['currency_name']);
      });
      _controller = TabController(vsync: this, length: drawers.length);
      SpUtil.putStringList('basecurrencys', drawers);
    }, failure: (error) {});
  }
}
