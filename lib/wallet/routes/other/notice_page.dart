import 'package:mars/wallet/common/component_index.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends BaseState<NoticePage> {
  @override
  Widget get appBar => getAppBar('通知', actions: []);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return ListView(padding: EdgeInsets.all(dp(30)), children: []);
  }

  getData() {}
}
