import 'package:qr_flutter/qr_flutter.dart';
import 'package:mars/wallet/common/component_index.dart';

class UseSettingPage extends StatefulWidget {
  @override
  _UseSettingPageState createState() => _UseSettingPageState();
}

class _UseSettingPageState extends BaseState<UseSettingPage> {
  @override
  Widget get appBar => getAppBar('使用设置');

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Color get backgroundColor => Color(0xFFF3F6FB);

  @override
  Widget buildContent(BuildContext context) {
    return ListView(padding: EdgeInsets.all(dp(30)), children: [

    ]);
  }

  getData() {}
}
