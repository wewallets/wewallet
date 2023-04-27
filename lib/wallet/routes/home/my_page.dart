import 'package:mars/wallet/common/component_index.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends BaseState<MyPage> with TickerProviderStateMixin {
  @override
  Widget get appBar => getAppBar('我的', noLeading: true, actions: [
        Row(
          children: [
            inkButton(
                child: LoadImage('my_tz', width: dp(24)),
                onPressed: () {
                  navigateTo(PageWalletRouter.notice_page);
                }),
            Gaps.hGap15,
          ],
        )
      ]);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Color get backgroundColor => Color(0xFFF2F3F5);

  @override
  Widget buildContent(BuildContext context) {
    return ListView(padding: EdgeInsets.only(top: dp(15)), children: [
      inkButton(
          onPressed: () {
            navigateTo(PageWalletRouter.wallet_management_page);
          },
          child: Container(
            color: Colours().white,
            padding: EdgeInsets.all(dp(20)),
            child: Row(
              children: [
                LoadImage('my_qbgl', width: dp(24), height: dp(24)),
                Gaps.hGap10,
                Text('钱包管理', style: TextStyles().textBlack14),
                Expanded(child: Container()),
                LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
              ],
            ),
          )),
      Gaps.vGap20,
      inkButton(
          onPressed: () {
            Global.initNetWorkList();
            // navigateTo(PageWalletRouter.use_setting_page);
          },
          child: Container(
            color: Colours().white,
            padding: EdgeInsets.all(dp(20)),
            child: Row(
              children: [
                LoadImage('my_sysz', width: dp(24), height: dp(24)),
                Gaps.hGap10,
                Text('使用设置', style: TextStyles().textBlack14),
                Expanded(child: Container()),
                LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
              ],
            ),
          )),
      Lines().line,
      inkButton(
          onPressed: () {
            navigateTo(PageWalletRouter.help_and_feedback_page);
          },
          child: Container(
            color: Colours().white,
            padding: EdgeInsets.all(dp(20)),
            child: Row(
              children: [
                LoadImage('my_yjfk', width: dp(24), height: dp(24)),
                Gaps.hGap10,
                Text('帮助反馈', style: TextStyles().textBlack14),
                Expanded(child: Container()),
                LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
              ],
            ),
          )),
      Lines().line,
      inkButton(
          onPressed: () {
            navigateTo(PageWalletRouter.about_us_page);
          },
          child: Container(
            color: Colours().white,
            padding: EdgeInsets.all(dp(20)),
            child: Row(
              children: [
                LoadImage('my_gywm', width: dp(24), height: dp(24)),
                Gaps.hGap10,
                Text('关于我们', style: TextStyles().textBlack14),
                Expanded(child: Container()),
                LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
              ],
            ),
          )),
    ]);
  }

  getData() {}
}
