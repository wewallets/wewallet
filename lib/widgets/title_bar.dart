import 'package:flutter/material.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/my_color.dart';
import 'package:mars/common/utils/my_imgs.dart';

///
/// 功能：
/// 描述：
/// crated by xudailong on 2020/7/31.
///
// ignore: must_be_immutable
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  double mHeight;
  String leftText;
  String text; //从外部指定内容
  Color statusBarColor; //设置statusbar的颜色
  Color centerColor; //设置statusbar的颜色
  bool rightShow;
  bool leftIconShow;
  bool leftBackWhite;
  bool leftCallbackState;
  bool lineState;
  bool isShadow;
  bool showMenu;
  VoidCallback callback;
  VoidCallback menuCallBack;
  VoidCallback leftCallback;
  Widget rightIc;
  Widget rightText;

  TitleBar({
    this.mHeight,
    this.text='',
    this.leftText='',
    this.statusBarColor = Colors.white,
    this.leftBackWhite = false,
    this.centerColor,
    this.rightIc,
    this.rightText,
    this.callback,
    this.rightShow = false,
    this.lineState = true,
    this.isShadow = false,
    this.leftIconShow = true,
    this.showMenu = false,
    this.leftCallbackState = false,
    this.leftCallback,
    this.menuCallBack,
  }) : super();

  @override
  Size get preferredSize => Size.fromHeight(mHeight);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(0xFF141F31),
      height: mHeight,
      child: SafeArea(
        top: true,
        child: Container(
            decoration: BoxDecoration(
              boxShadow: !lineState && (isShadow)
                  ? <BoxShadow>[
                      BoxShadow(
                          offset: Offset(0, -5),
                          color: MColor.dividerColor,
                          blurRadius: 30.0,
                          spreadRadius: 5.0),
                    ]
                  : null,
              color: lineState && (isShadow) ? Color(0xFF141F31) : Color(0xFF141F31),
            ),
            height: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: <Widget>[
                      (leftIconShow == null || leftIconShow == true)
                          ? Container(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (leftCallbackState == true)
                                        ? this.leftCallback
                                        : () {
                                      Navigator.pop(context);
                                          },
                                    child: Container(
                                      child: !leftBackWhite
                                          ? Icon(Icons.arrow_back)
                                          : LoadAssetImage('break_black', width:ScreenUtil().setWidth(44),color: Colours.white),
                                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Visibility(
                                    child: Container(
                                      width: ScreenUtil().setWidth(2),
                                      color: Colours.white,
                                      height: ScreenUtil().setWidth(44),
                                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(27),left: ScreenUtil().setWidth(16)),
                                    ),
                                    visible: showMenu,
                                  ),
                                  Visibility(
                                    child: InkWell(
                                      child: Row(
                                        children: [
                                          LoadAssetImage('ic_btc_menu', width:ScreenUtil().setWidth(44),color: Colours.white),
                                          Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(17))),
                                          Text(
                                            leftText,
                                            style: TextStyles.textWhite18,
                                          )
                                        ],
                                      ),
                                      onTap: this.menuCallBack,
                                    ),
                                    visible: showMenu,
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: 40,
                              height: double.infinity,
                            ),
                      Container(
                        child: Text(
                          text,
                          style: TextStyle(
                              color: centerColor != null
                                  ? centerColor
                                  : Color(0xFF222222),
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                        height: double.infinity,
                        alignment: Alignment.center,
                      ),
                      rightShow
                          ? GestureDetector(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: rightText == null
                                    ? (rightIc != null) ? rightIc : Container()
                                    : rightText,
                                // margin: EdgeInsets.only(right: 15),
                              ),
                              onTap: this.callback,
                            )
                          : Container(
                              width: 24,
                            ),
                    ],
                  ),
                ),
                (lineState == null || lineState)
                    ? Container(
                        height: ScreenUtil().setWidth(1),
                        color: Colours.color1A000000,
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }
}
