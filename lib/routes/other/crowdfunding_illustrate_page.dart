import 'package:mars/common/transaction_component_index.dart';

class CrowdFundingIllustratePage extends StatefulWidget {
  @override
  _CrowdFundingIllustratePageState createState() => _CrowdFundingIllustratePageState();
}

class _CrowdFundingIllustratePageState extends State<CrowdFundingIllustratePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF261983),
        appBar: LayoutUtil.getAppBar(
          context, '${getString().zf79}',
          // actions: [
          // InkResponse(
          //   child: Container(alignment: Alignment.center, padding: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)), child: Text('$selectType', style: TextStyles.text7854D528)),
          //   onTap: () {
          //     showSelect();
          //   },
          // )
          // ]
        ),
        body: ListView(children: [
          Image.asset(
            getImgPath(getLq1(), format: 'png'),
            height: adaptationDp(3000),
            width: double.infinity,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ]));
  }

  getLq1() {
    if (getLocale() == 'zh') {
      return 'zongchoubl1';
    } else if (getLocale() == 'ms') {
      return 'zongchoubl3';
    } else if (getLocale() == 'th') {
      return 'zongchoubl2';
    } else {
      return 'zongchoubl4';
    }
  }
}
