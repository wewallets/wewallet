import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail13Page extends StatefulWidget {
  @override
  _EcologyDetail13PageState createState() => _EcologyDetail13PageState();
}

class _EcologyDetail13PageState extends State<EcologyDetail13Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            LoadImage('ep214', height: adaptationDp(125), width: double.infinity),
            CupertinoButton(
              child: LoadAssetImage('break_black', width: adaptation(44), height: adaptation(44), color: Colours.white, fit: BoxFit.contain),
              padding: EdgeInsets.only(top: adaptationDp(30)),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: adaptationDp(60), left: adaptationDp(15), right: adaptationDp(15)),
              child: Text('${getString().xtj17}', style: TextStyles.textWhite23),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().xtj18}', style: TextStyles.textGrey14)),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().xtj19}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().xtj20}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().xtj21}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().xtj22}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().xtj23}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().xtj24}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().xtj25}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().xtj26}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().xtj27}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().xtj28}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().xtj29}', style: TextStyles.textGrey13)),
      ],
    ));
  }
}
