import 'package:mars/wallet/common/component_index.dart';

import '../../generated/l10n.dart';

//启动
class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends BaseState<SplashPage> with TickerProviderStateMixin {
  String splashMiddle;
  AnimationController size1Controller;

  @override
  Widget get appBar => null;

  @override
  void initState() {
    super.initState();
    initLocale();

    size1Controller = AnimationController(duration: const Duration(milliseconds: 2500), vsync: this, lowerBound: 1.0, upperBound: 1.2);

    Future.delayed(Duration(milliseconds: 0), () async {
      size1Controller.forward();
    });

    Future.delayed(Duration(milliseconds: 3000), () async {
      // navigatorPush(PageRouter.login_Page, isPop: true);
      // Global.logout(context);

      navigatorPush(PageWalletRouter.main_page, isPop: true);
      // navigatorPush(PageRouter.my_gold_page, isPop: true);
      return;

      if (Global.isLogin) {
        navigatorPush(PageWalletRouter.main_page, isPop: true);
      } else {
        navigatorPush(PageWalletRouter.create_wallet_page, isPop: true);
      }
    });
  }

  initLocale() async {
    if (SpWalletUtil.hasKey('locale')) {
      await S.load(Locale(SpWalletUtil.getString('locale')));
    } else {
      await S.load(Locale('zh'));
      SpWalletUtil.putString('locale', 'zh');
    }
    setState(() {});
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(height: dp(162)),
          ScaleTransition(alignment: Alignment.topCenter, scale: size1Controller, child: LoadImage('sp_top', width: dp(212))),
          Expanded(child: Container()),
          Container(alignment: Alignment.center, child: LoadImage('sp_boom', width: dp(129))),
          Gaps.vGap50,
        ],
      ),
    );
  }
}
