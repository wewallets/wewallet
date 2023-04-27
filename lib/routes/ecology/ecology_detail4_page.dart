import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail4Page extends StatefulWidget {
  @override
  _EcologyDetail4PageState createState() => _EcologyDetail4PageState();
}

class _EcologyDetail4PageState extends State<EcologyDetail4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Stack(
        children: [
          LoadImage('ep18', height: adaptationDp(125), width: double.infinity),
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
            child: Text('RISE EARN', style: TextStyles.textWhite23),
          ),

        ],
      ),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb108}', style: TextStyles.textGrey14)),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb109}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb110}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb111}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb112}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb113}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb114}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb115}', style: TextStyles.textGrey13)),

    ]));
  }
}
