import 'package:mars/wallet/common/component_index.dart';

class HelpAndFeedbackPage extends StatefulWidget {
  @override
  _HelpAndFeedbackPageState createState() => _HelpAndFeedbackPageState();
}

class _HelpAndFeedbackPageState extends BaseState<HelpAndFeedbackPage> {
  @override
  Widget get appBar => getAppBar('帮助与反馈', actions: []);

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
