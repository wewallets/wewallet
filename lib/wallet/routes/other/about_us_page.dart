import 'package:mars/wallet/common/component_index.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends BaseState<AboutUsPage> {
  @override
  Widget get appBar => getAppBar('关于我们', actions: []);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return ListView(padding: EdgeInsets.zero, children: [
      inkButton(
          onPressed: () {
            showToast('已经是最新版本');
          },
          child: Container(
            color: Colours().white,
            padding: EdgeInsets.all(dp(20)),
            child: Row(
              children: [
                LoadImage('my_qbgl', width: dp(24), height: dp(24)),
                Gaps.hGap10,
                Text('版本更新', style: TextStyles().textBlack14),
                Expanded(child: Container()),
                LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
              ],
            ),
          )),
    ]);
  }

  getData() {}
}
