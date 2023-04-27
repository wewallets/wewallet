
import 'package:mars/common/transaction_component_index.dart';

//启动
class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> with TickerProviderStateMixin {
  String splashMiddle;

  @override
  void initState() {
    GlobalTransaction.context = context;
    super.initState();
    if (SpUtil.hasKey('isWsOnHttp')) GlobalTransaction.isWsOnHttp = SpUtil.getBool('isWsOnHttp');

    Future.delayed(Duration(milliseconds: 0), () {
      splashMiddle = 'logo_sp';
      if (GlobalTransaction.isLogin) {
        GlobalTransaction.refreshWalletAssets();
      }
      setState(() {});
    });
    Future.delayed(Duration(milliseconds: 4000), () {
      Navigator.pushReplacementNamed(context, PageTransactionRouter.new_main_page);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFBFBFB),
        body: Stack(
          children: <Widget>[
            splashMiddle == null ? Container() : LoadImage('logo_sp', format: 'gif', width: double.infinity, height: double.infinity, fit: BoxFit.contain),
          ],
        ));
  }
}
