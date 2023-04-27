import 'package:mars/common/transaction_component_index.dart';

//重置钱包密码
class ResetWalletPwdPage extends StatefulWidget {
  @override
  _ResetWalletPwdPageState createState() => _ResetWalletPwdPageState();
}

class _ResetWalletPwdPageState extends State<ResetWalletPwdPage> {
  TextEditingController dTEC = new TextEditingController();
  TextEditingController newPwdTEC = new TextEditingController();
  TextEditingController newTwoPwdTEC = new TextEditingController();
  bool isLegal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().czqbmm}'),
      body: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(60), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${getString().jzcbdczmm}', style: TextStyles.textBlack12),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: ScreenUtil().setWidth(24), bottom: ScreenUtil().setWidth(60)),
                height: ScreenUtil().setWidth(140),
                decoration: BoxDecoration(color: Colours.colorF6, borderRadius: BorderRadius.all(Radius.circular(6))),
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                child: TextField(
                  textAlign: TextAlign.left,
                  maxLines: 100,
                  keyboardType: TextInputType.multiline,
                  controller: dTEC,
                  onChanged: (v) {
                    checkPage();
                  },
                  decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().qsrzjchzsfk}', hintStyle: TextStyles.textB4B4B428),
                  textInputAction: TextInputAction.none,
                  style: TextStyles.textBlack15,
                ),
              ),
              Text('${getString().szxmm}', style: TextStyles.textBlack12),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    maxLines: 1,
                    controller: newPwdTEC,
                    onChanged: (v) {
                      checkPage();
                    },
                    decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().xdlmmts}', hintStyle: TextStyles.textB4B4B428),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    style: TextStyles.textBlack15,
                  )),
                  // Padding(
                  //   padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                  //   child: LoadImage(
                  //     'icon_pwd_hide',
                  //     width: ScreenUtil().setWidth(32),
                  //     height: ScreenUtil().setWidth(32),
                  //   ),
                  // )
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(40)),
                color: Colours.color0D000000,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Text('${getString().zcqdqbxmm}', style: TextStyles.textBlack12),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    maxLines: 1,
                    controller: newTwoPwdTEC,
                    onChanged: (v) {
                      checkPage();
                    },
                    decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().zcqdqbxmm}', hintStyle: TextStyles.textB4B4B428),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    style: TextStyles.textBlack15,
                  )),
                  // Padding(
                  //   padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                  //   child: LoadImage(
                  //     'icon_pwd_hide',
                  //     width: ScreenUtil().setWidth(32),
                  //     height: ScreenUtil().setWidth(32),
                  //   ),
                  // )
                ],
              ),
              Container(
                color: Colours.color0D000000,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Gaps.vGap50,
              Buttons.getDetermineButton(
                  isUse: isLegal,
                  voidCallback: () {
                    modifyPwd();
                  }),
            ],
          )),
    );
  }

  checkPage() {
    if (dTEC.text.length == 0 || newPwdTEC.text.length == 0 || newTwoPwdTEC.text.length == 0) {
      isLegal = false;
    } else {
      isLegal = true;
    }
    if (mounted) setState(() {});
  }

  modifyPwd() {
    if (!isLegal) {
      return;
    }
    if (GlobalTransaction.walletInfo.master_key == dTEC.text || GlobalTransaction.walletInfo.master_seed == dTEC.text) {
      if (newPwdTEC.text != newTwoPwdTEC.text) {
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().ershurumimbyz}');
        return;
      }
      GlobalTransaction.saveWalletPassword(newTwoPwdTEC.text);
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().xgmmcgg}');
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qsrzqdsyhzzc}');
      return;
    }
  }
}
