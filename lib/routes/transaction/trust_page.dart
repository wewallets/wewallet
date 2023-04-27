import 'package:flutter/material.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/layoutUtil.dart';
import 'package:mars/routes/transaction/trust_list_page.dart';

class TrustPage extends StatefulWidget {
  TrustPage({Key key}) : super(key: key);

  @override
  _TrustPageState createState() => _TrustPageState();
}

class _TrustPageState extends State<TrustPage> with TickerProviderStateMixin {
  TabController tabController;
  var itemName = ['全部委托', '历史记录'];

  @override
  void initState() {
    super.initState();
    itemName=['${getString().qbwt}','${getString().lsjl}'];
    tabController = new TabController(initialIndex: 0, length: itemName.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, '', elevation: 0.0),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TabBar(
                controller: tabController,
                tabs: itemName.map((title) {
                  return Tab(text: title);
                }).toList(),
                isScrollable: true,
                labelStyle: TextStyles.textBlack21,
                indicatorColor: Colors.transparent,
                labelColor: Colours.textBlack,
                unselectedLabelStyle: TextStyles.textGrey18,
              ),
              Container(
                color: Colours.colorEE,
                height: ScreenUtil().setWidth(1),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              ),
              Flexible(
                child: TabBarView(
                  controller: tabController,
                  children: itemName.map((item) {
                    return Container(
                      child: TrustListPage(item),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ));
  }
}
