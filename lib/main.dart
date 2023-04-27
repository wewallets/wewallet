import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/wallet/common/global.dart';
import 'package:mars/wallet/common/utils.dart';
import 'package:mars/wallet/common/utils/spUtil.dart';
import 'package:mars/wallet/routes/splash_page.dart';
import 'package:mars/wallet/common/router/pageRouter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'common/utils/RESUtil.dart';
import 'common/utils/SignRESUtil.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //设置屏幕只能竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await RESUtil.init();
  await PageTransactionRouter.setupRoutes();
  await PageWalletRouter.setupRoutes();
  await SpUtil.init();
  await SpWalletUtil.init();
  await SignRESUtil.init();
  Global.initNetWorkList();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        allowFontScaling: false,
        builder: () {
          return RefreshConfiguration(
            headerBuilder: () => getHeaderBuilder(),
            footerBuilder: () => getClassicFooter(),
            headerTriggerDistance: 80.0,
            springDescription: SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
            maxOverScrollExtent: 100,
            maxUnderScrollExtent: 0,
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: true,
            enableBallisticLoad: true,
            child: MaterialApp(
              color: Colours.white,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: SpUtil.hasKey('locale') ? Locale(SpUtil.getString('locale')) : null,
              home: SplashPage(),
              onGenerateRoute: PageTransactionRouter.router.generator,
            ),
          );
        });
  }
}
