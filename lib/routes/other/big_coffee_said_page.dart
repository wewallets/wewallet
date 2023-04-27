import 'package:mars/common/transaction_component_index.dart';

class BigCoffeeSaidPage extends StatefulWidget {
  @override
  _BigCoffeeSaidPageState createState() => _BigCoffeeSaidPageState();
}

class _BigCoffeeSaidPageState extends State<BigCoffeeSaidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF261983),
        appBar: LayoutUtil.getAppBar(
          context, '${getString().dakas}',
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
            getImgPath(getLq1(), format: getLocale() == 'zh' || getLocale() == 'en' ? 'jpeg' : 'png'),
            height: adaptationDp(3000),
            width: double.infinity,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ]));
  }

  getLq1() {
    if (getLocale() == 'zh') {
      return 'dakas1';
    } else if (getLocale() == 'ms') {
      return 'dakas3';
    } else if (getLocale() == 'th') {
      return 'dakas4';
    } else {
      return 'dakas2';
    }
  }
}
