import 'package:mars/common/transaction_component_index.dart';

//修改钱包密码
class ModifyWalletPwdPage extends StatefulWidget {
  @override
  _ModifyWalletPwdPageState createState() => _ModifyWalletPwdPageState();
}

class _ModifyWalletPwdPageState extends State<ModifyWalletPwdPage> {
  TextEditingController oldPwdTEC = new TextEditingController();
  TextEditingController newPwdTEC = new TextEditingController();
  TextEditingController newTwoPwdTEC = new TextEditingController();
  bool isLegal = false;

  bool isXsPwd1 = false;
  bool isXsPwd2 = false;
  bool isXsPwd3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().xgqb}'),
      body: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(40), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${getString().ydlmm}', style: TextStyles.textBlack12),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    maxLines: 1,
                    controller: oldPwdTEC,
                    onChanged: (v) {
                      checkPage();
                    },
                    decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().qsrqbymm}', hintStyle: TextStyles.textB4B4B428),
                    keyboardType: TextInputType.text,
                    obscureText: !isXsPwd1,
                    textInputAction: TextInputAction.done,
                    style: TextStyles.textBlack15,
                  )),
                  InkResponse(
                      onTap: () {
                        isXsPwd1 = !isXsPwd1;
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                        child: LoadImage(
                          isXsPwd1 ? 'icon_pwd_display' : 'icon_pwd_hide',
                          width: ScreenUtil().setWidth(32),
                          height: ScreenUtil().setWidth(32),
                        ),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(40)),
                color: Colours.color0D000000,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Text('${getString().xdlmm}', style: TextStyles.textBlack12),
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
                    obscureText: !isXsPwd2,
                    textInputAction: TextInputAction.done,
                    style: TextStyles.textBlack15,
                  )),
                  InkResponse(
                      onTap: () {
                        isXsPwd2 = !isXsPwd2;
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                        child: LoadImage(
                          isXsPwd2 ?  'icon_pwd_display' : 'icon_pwd_hide',
                          width: ScreenUtil().setWidth(32),
                          height: ScreenUtil().setWidth(32),
                        ),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(40)),
                color: Colours.color0D000000,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Text('${getString().zqdmm}', style: TextStyles.textBlack12),
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
                    obscureText: !isXsPwd3,
                    textInputAction: TextInputAction.done,
                    style: TextStyles.textBlack15,
                  )),
                  InkResponse(
                      onTap: () {
                        isXsPwd3 = !isXsPwd3;
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                        child: LoadImage(
                          isXsPwd3 ?  'icon_pwd_display' : 'icon_pwd_hide',
                          width: ScreenUtil().setWidth(32),
                          height: ScreenUtil().setWidth(32),
                        ),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(24)),
                color: Colours.color0D000000,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('* ', style: TextStyles.textD94F5722), Expanded(child: Text('${getString().qbmmtiscc}', style: TextStyles.textD94F5722))],
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
    if (oldPwdTEC.text.length == 0 || newPwdTEC.text.length == 0 || newTwoPwdTEC.text.length == 0) {
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
    if (GlobalTransaction.walletPassword != oldPwdTEC.text) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qsrzqymm}');
      return;
    }
    if (newPwdTEC.text != newTwoPwdTEC.text) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().ershurumimbyz}');
      return;
    }
    GlobalTransaction.saveWalletPassword(newTwoPwdTEC.text);
    Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().xgmmcgg}');
    Navigator.pop(context);
  }
}
