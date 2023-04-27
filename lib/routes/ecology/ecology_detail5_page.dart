import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail5Page extends StatefulWidget {
  @override
  _EcologyDetail5PageState createState() => _EcologyDetail5PageState();
}

class _EcologyDetail5PageState extends State<EcologyDetail5Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Stack(
        children: [
          LoadImage('ep19', height: adaptationDp(125), width: double.infinity),
          CupertinoButton(
            child: LoadAssetImage('break_black', width: adaptation(44), height: adaptation(44), color: Colours.white, fit: BoxFit.contain),
            padding: EdgeInsets.only(top: adaptationDp(30)),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: adaptationDp(60), left: adaptationDp(15),right: adaptationDp(15)),
            child: Text('${getString().stwb116}', style: TextStyles.textWhite23),
          ),

        ],
      ),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb117}', style: TextStyles.textGrey14)),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb118}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb119}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb120}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb121}', style: TextStyles.textGrey13)),

    ]));
  }
}
