import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/widgets/my_underline_tab_indicator.dart';

import 'help_center_list_page.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> with TickerProviderStateMixin {
  TabController _controller;
  List<String> tabList = [];

  @override
  void initState() {
    super.initState();
    tabList = ['${getString().zf53}'];
    // tabList = ['${getString().zf74}', '${getString().zf75}', '${getString().zf76}', '${getString().zf77}'];
    _controller = TabController(vsync: this, length: tabList.length);
  }

  getTab(data) {
    if (tabList[0] == data) return 0;
    if (tabList[1] == data) return 1;
    if (tabList[2] == data) return 2;
    if (tabList[3] == data) return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getContextAppBar(context, '${getString().zf78}'),
        backgroundColor: Colours.background,
        body: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(6)),
            //   height: ScreenUtil().setWidth(92),
            //   width: double.infinity,
            //   decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/market_head_bg.png'))),
            //   child: TabBar(
            //     unselectedLabelColor: Colours.colorFFB0A8C8,
            //     unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
            //     labelColor: Colours.colorFF7854D5,
            //     labelStyle: TextStyle(fontSize: ScreenUtil().setSp(26)),
            //     controller: _controller,
            //     isScrollable: false,
            //     indicatorSize: TabBarIndicatorSize.label,
            //     indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: ScreenUtil().setWidth(4), color: Colours.colorFF7854D5)),
            //     tabs: tabList.map((e) => Text('$e')).toList(),
            //   ),
            // ),
            Expanded(
                child: TabBarView(
              children: tabList.map((e) => HelpCenterListPage(getTab(e))).toList(),
              controller: _controller,
            )),
          ],
        ));
  }
}
