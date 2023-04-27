import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';

class EcologyDetail12Page extends StatefulWidget {
  @override
  _EcologyDetail12PageState createState() => _EcologyDetail12PageState();
}

class _EcologyDetail12PageState extends State<EcologyDetail12Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            LoadImage('ep10', height: adaptationDp(125), width: double.infinity),
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
              child: Text('${getString().stwb40}', style: TextStyles.textWhite23),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb41}\n${getString().stwb42}\n${getString().stwb43}', style: TextStyles.textGrey14)),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb44}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb45}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb46}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb47}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb48}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb53}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb54}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb55}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb56}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb57}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb58}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb59}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb60}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb61}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb62}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb63}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb64}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb65}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb66}', style: TextStyles.textGrey17.copyWith(color: Colours.colorFFC939F3))),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb67}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb68}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb69}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb70}', style: TextStyles.textGrey13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().stwb71}', style: TextStyles.textBlack13)),
        Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(10)), child: Text('${getString().stwb72}', style: TextStyles.textGrey13)),
      ],
    ));
  }
}
