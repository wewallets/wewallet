import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'base_dialog.dart';

//选择窗口
// ignore: must_be_immutable
class SelectionTipsDialog extends StatelessWidget {
  SelectionTipsDialog({this.title, this.content, this.leftText, this.rightText, this.voidCallback, this.noLeftText});

  var voidCallback;
  String title;
  String content;
  String leftText;
  String rightText;
  bool noLeftText;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      width: ScreenUtil().setWidth(630),
      height: ScreenUtil().setWidth(450),
      backgroundColor: Colours.white,
      widget: Stack(children: <Widget>[
        StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(child: Center(child: Text(title, style: TextStyle(fontSize: ScreenUtil().setSp(36), color: Colours.textBlack, fontWeight: FontWeight.w500))), padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(60))),
              Padding(
                child: Text(content, style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colours.textGrey6)),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(88), right: ScreenUtil().setWidth(30)),
              ),
              Padding(
                child: Row(
                  mainAxisAlignment: noLeftText == true ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    noLeftText == true
                        ? Container()
                        : Expanded(
                            child: Container(
                            height: ScreenUtil().setWidth(80),
                            width: double.infinity,
                            child: inkButton(
                              child: Text(leftText, style: TextStyles.textGrey616),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(6)), border: Border.all(width: 0.5, color: Colours.colorB8B1CF)),
                          )),
                    Gaps.hGap10,
                    Expanded(
                        child: Container(
                            height: ScreenUtil().setWidth(80),
                            width: double.infinity,
                            child: inkButton(
                              child: Text(rightText, style: TextStyles.textWhite16),
                              onPressed: () {
                                Navigator.pop(context);
                                voidCallback();
                              },
                            ))),
                  ],
                ),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
              )
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
