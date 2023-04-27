import 'package:mars/common/transaction_component_index.dart';

//了解助记词
class UnderstandingMnemonicsPage extends StatefulWidget {
  @override
  _UnderstandingMnemonicsPageState createState() => _UnderstandingMnemonicsPageState();
}

class _UnderstandingMnemonicsPageState extends State<UnderstandingMnemonicsPage> {
  int isChoice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight + ScreenUtil().setWidth(10), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath(Images.understanding_bg)), fit: BoxFit.fill)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    child: LoadAssetImage(Images.break_black, width: ScreenUtil().setWidth(44), color: Colours.white),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Gaps.hGap12,
                  Text('${getString().ljzjc}', style: TextStyles.textWhite18.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Padding(child: Text('${getString().ljzjcts1}', style: TextStyles.textWhite16), padding: EdgeInsets.only(top: ScreenUtil().setWidth(66), bottom: ScreenUtil().setWidth(24))),
              Text('${getString().ljzjcts2}', style: TextStyles.textWhite14.copyWith(color: Color(0xCCFFFFFF))),
              Gaps.vGap25,
            ]),
          ),
          Container(
            height: ScreenUtil().setWidth(80),
            color: Color(0x1ACCB280),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: Row(children: <Widget>[
              LoadImage(Images.content_tx, width: ScreenUtil().setWidth(26)),
              Gaps.hGap5,
              Text('${getString().ljzjcts3}', style: TextStyles.textWhite14.copyWith(color: Colours.FFE49700)),
            ]),
          ),
          Padding(
            child: Text('${getString().ljzjcts4}', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(60), bottom: ScreenUtil().setWidth(40)),
          ),
          InkWell(
            child: Row(children: <Widget>[Gaps.hGap15, LoadImage(isChoice == 1 ? Images.choice : Images.no_choice, width: ScreenUtil().setWidth(30)), Gaps.hGap5, Text('${getString().ljzjcts5}', style: TextStyles.textGrey614)]),
            onTap: () {
              isChoice = 1;
              setState(() {});
            },
          ),
          Gaps.vGap20,
          InkWell(
            child: Row(children: <Widget>[Gaps.hGap15, LoadImage(isChoice == 2 ? Images.choice : Images.no_choice, width: ScreenUtil().setWidth(30)), Gaps.hGap5, Text('${getString().ljzjcts6}', style: TextStyles.textGrey614)]),
            onTap: () {
              isChoice = 2;
              setState(() {});
            },
          ),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(165), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
              child: Buttons.getDetermineButton(
                  isUse: isChoice == 1 ? true : false,
                  buttonText: isChoice == 1 ? '${getString().ljzjctshdzq}' : '${getString().cjqbdiz}',
                  voidCallback: () {
                    if (isChoice == 1) {
                      Navigator.pushNamed(context, PageTransactionRouter.create_wallet_page);
                    }
                  })),
        ],
      ),
    );
  }
}
