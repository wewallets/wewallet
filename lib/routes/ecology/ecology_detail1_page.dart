import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail1Page extends StatefulWidget {
  @override
  _EcologyDetail1PageState createState() => _EcologyDetail1PageState();
}

class _EcologyDetail1PageState extends State<EcologyDetail1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            LoadImage('ep9', height: adaptationDp(125), width: double.infinity),
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
              child: Text('${getString().stwb73}', style: TextStyles.textWhite23),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb74}', style: TextStyles.textGrey14)),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb75}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb76}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15),bottom: adaptationDp(10)), child: Text('${getString().stwb77}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb78}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15),bottom: adaptationDp(10)), child: Text('${getString().stwb79}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb80}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15),bottom: adaptationDp(10)), child: Text('${getString().stwb81}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb82}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15),bottom: adaptationDp(10)), child: Text('${getString().stwb83}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15)), child: Text('${getString().stwb84}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15),right: adaptationDp(15),bottom: adaptationDp(10)), child: Text('${getString().stwb85}', style: TextStyles.textGrey13)),
      ],
    ));
  }
}
