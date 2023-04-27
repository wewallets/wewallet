import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail3Page extends StatefulWidget {
  @override
  _EcologyDetail3PageState createState() => _EcologyDetail3PageState();
}

class _EcologyDetail3PageState extends State<EcologyDetail3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Stack(
        children: [
          LoadImage('ep7', height: adaptationDp(125), width: double.infinity),
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
            child: Text('${getString().stwb98}', style: TextStyles.textWhite23),
          ),
        ],
      ),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb99}', style: TextStyles.textGrey14)),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb100}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb101}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb102}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb103}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb104}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb105}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb106}', style: TextStyles.textGrey13)),

    ]));
  }
}
