import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail6Page extends StatefulWidget {
  @override
  _EcologyDetail6PageState createState() => _EcologyDetail6PageState();
}

class _EcologyDetail6PageState extends State<EcologyDetail6Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Stack(
        children: [
          LoadImage('ep12', height: adaptationDp(125), width: double.infinity),
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
            child: Text('${getString().stwb122}', style: TextStyles.textWhite23),
          ),
        ],
      ),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb123}', style: TextStyles.textGrey14)),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb124}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb125}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb126}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb127}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb128}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb129}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb130}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb131}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb132}', style: TextStyles.textGrey13)),
    ]));
  }
}
