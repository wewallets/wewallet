import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail10Page extends StatefulWidget {
  @override
  _EcologyDetail10PageState createState() => _EcologyDetail10PageState();
}

class _EcologyDetail10PageState extends State<EcologyDetail10Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Stack(
        children: [
          LoadImage('ep16', height: adaptationDp(125), width: double.infinity),
          CupertinoButton(
            child: LoadAssetImage('break_black', width: adaptation(44), height: adaptation(44), color: Colours.white, fit: BoxFit.contain),
            padding: EdgeInsets.only(top: adaptationDp(30)),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: adaptationDp(60), left: adaptationDp(20)),
            child: Text('${getString().stwb163}', style: TextStyles.textWhite23),
          ),
        ],
      ),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb164}', style: TextStyles.textGrey14)),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb165}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb166}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb167}', style: TextStyles.textGrey13)),
      // Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb168}', style: TextStyles.textGrey13)),
      // Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb169}', style: TextStyles.textGrey13)),
    ]));
  }
}
