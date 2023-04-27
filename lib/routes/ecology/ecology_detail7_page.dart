import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail7Page extends StatefulWidget {
  @override
  _EcologyDetail7PageState createState() => _EcologyDetail7PageState();
}

class _EcologyDetail7PageState extends State<EcologyDetail7Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Stack(
        children: [
          LoadImage('ep13', height: adaptationDp(125), width: double.infinity),
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
            child: Text('${getString().stwb133}', style: TextStyles.textWhite23),
          ),
        ],
      ),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb134}', style: TextStyles.textGrey14)),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb135}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb136}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb137}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb138}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb139}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb140}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb141}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb142}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb143}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb144}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb145}', style: TextStyles.textGrey13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb146}', style: TextStyles.textBlack13)),
      Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb147}', style: TextStyles.textGrey13)),
    ]));
  }
}
