import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'base_dialog.dart';

//输入钱包密码
// ignore: must_be_immutable
class InputPasswordDialog extends StatelessWidget {
  InputPasswordDialog(this.voidCallback);

  var voidCallback;
  TextEditingController passwordController = new TextEditingController();
  bool isPwd = false;
  bool isUse = false;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      width: ScreenUtil().setWidth(630),
      height: ScreenUtil().setWidth(508),
      backgroundColor: Colours.white,
      widget: Stack(children: <Widget>[
        StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(child: Center(child: Text('${getString().anqr}', style: Styles.textTitle)), padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(70))),
              Padding(
                child: Text('${getString().anqqrts}', style: Styles.textAuxiliary),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(28)),
              ),
              Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(70)),
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
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
                                cursorColor: Colours.textBlack,
                                onChanged: (String value) {
                                  setState(() {
                                    if (value == null || value == '')
                                      isUse = false;
                                    else
                                      isUse = true;
                                  });
                                },
                                obscureText: !isPwd,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9-*/+.~!@#\$%^&*()]"))],
                                decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().qsrqbmm}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                              ))),
                      !isUse
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
              Align(
                  alignment: Alignment.center,
                  child: Buttons.getSmallDetermineButton(
                      isUse: isUse,
                      buttonText: '${getString().qd}',
                      voidCallback: () {
                        Navigator.pop(context);
                        voidCallback(passwordController.text);
                      })),
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
