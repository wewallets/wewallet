import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';

import 'base_dialog.dart';

//钱包管理弹窗
// ignore: must_be_immutable
class WalletManageDialog extends StatelessWidget {
  WalletManageDialog(this.voidCallback, {this.title, this.type = 0, this.hintText});

  var voidCallback;
  TextEditingController passwordController = new TextEditingController();
  bool isPwd = false;
  bool isUse = false;

  String title;
  String hintText;
  int type = 0; //0密码输入框 1正常输入框

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      width: ScreenUtil().setWidth(630),
      height: ScreenUtil().setWidth(468),
      backgroundColor: Colours.white,
      widget: Stack(children: <Widget>[
        StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(child: Center(child: Text(title, style: Styles.textTitle.copyWith(fontWeight: FontWeight.bold))), padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(90))),
              Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(70)),
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(20)),
                  decoration: BoxDecoration(
                    color: Colours.FFF2F1F8,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(width: 0.5, color: Color(0xFFD9D5DC)),
                  ),
                  height: ScreenUtil().setWidth(80),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                              child: TextField(
                                autofocus: true,
                                controller: passwordController,
                                style: TextStyles.textBlack14,
                                inputFormatters: type == 0 ? [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9-*/+.~!@#\$%^&*()]"))] : [],
                                cursorColor: Colours.textBlack,
                                onChanged: (String value) {
                                  setState(() {
                                    if (value == null || value == '')
                                      isUse = false;
                                    else
                                      isUse = true;
                                  });
                                },
                                obscureText: type == 0 ? !isPwd : false,
                                decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: type == 0 ? '请输入钱包密码' : hintText, hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                              ))),
                      !isUse || type == 1
                          ? Container()
                          : InkWell(
                              child: LoadImage(isPwd ? Images.asset_eye : Images.asset_eyg, width: ScreenUtil().setWidth(44)),
                              onTap: () {
                                setState(() {
                                  isPwd = !isPwd;
                                });
                              },
                            )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(41), right: ScreenUtil().setWidth(39)),
                child: Row(
                  children: [
                    Expanded(
                        child: InkResponse(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                              decoration: BoxDecoration(border: Border.all(color: Colours.colorB8B1CF), color: Colours.white, borderRadius: BorderRadius.circular(6)),
                              height: ScreenUtil().setWidth(88),
                              child: Text(
                                '取消',
                                style: TextStyles.textGrey616,
                              ),
                            ))),
                    Expanded(
                        child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                        decoration: BoxDecoration(color: Colours.colorButton2, borderRadius: BorderRadius.circular(6)),
                        height: ScreenUtil().setWidth(88),
                        child: Text(
                          '确定',
                          style: TextStyles.textWhite16,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        voidCallback(passwordController.text);
                      },
                    ))
                  ],
                ),
              ),
            ],
          );
        }),
        Align(
            alignment: Alignment.topRight,
            child: InkResponse(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(child: LoadImage(Images.combined_shape_26671, width: ScreenUtil().setWidth(30)), padding: EdgeInsets.all(ScreenUtil().setWidth(30))),
            )),
      ]),
      entryAnimation: EntryAnimation.DEFAULT,
    );
  }
}
