import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'base_dialog.dart';

//输入地址
// ignore: must_be_immutable
class InputAddressDialog extends StatelessWidget {
  InputAddressDialog(this.title, this.voidCallback);

  var voidCallback;
  String title = '';
  TextEditingController passwordController = new TextEditingController();
  bool isUse = false;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      width: ScreenUtil().setWidth(630),
      height: ScreenUtil().setWidth(450),
      backgroundColor: Colours.white,
      widget: Stack(children: <Widget>[
        StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(child: Center(child: Text('$title', style: Styles.textTitle)), padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(70))),
              // Padding(
              //   child: Text('${getString().anqqrts}', style: Styles.textAuxiliary),
              //   padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(28)),
              // ),
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
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9-*/+.~!@#\$%^&*()]"))],
                                decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入地址', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                              ))),
                    ],
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Buttons.getSmallDetermineButton(
                      isUse: isUse,
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
