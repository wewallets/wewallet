import 'package:mars/common/transaction_component_index.dart';

class ImPage extends StatefulWidget {
  @override
  _ImPageState createState() => _ImPageState();
}

class _ImPageState extends State<ImPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutUtil.getAppBar(context, 'IM'),
    );
  }
}
