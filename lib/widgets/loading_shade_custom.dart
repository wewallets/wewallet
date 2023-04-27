import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/utils/loadImage.dart';
import 'package:mars/res/colors.dart';

/**
 * 加载进度条组件
 */
class LoadingShadeCustom extends StatelessWidget {
  //子布局
  final Widget child;

  //加载中是否显示
  final bool loading;

  //进度提醒内容
  final String msg;

  //加载中动画
  final Widget progress;

  //背景透明度
  final double alpha;

  //字体颜色
  final Color textColor;

  LoadingShadeCustom({Key key, @required this.loading, this.msg, this.progress = const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colours.themeColor)), this.alpha = 0.6, this.textColor = Colors.black, @required this.child})
      : assert(child != null),
        assert(loading != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (loading) {
      Widget layoutProgress;
      if (msg == null) {
        layoutProgress = Center(
          child: progress,
        );
      } else {
        layoutProgress = Center(
          child: Container(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(40.0), bottom: ScreenUtil().setWidth(40.0), left: ScreenUtil().setWidth(80.0), right: ScreenUtil().setWidth(80.0)),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LoadImage('common_loading', format: 'gif', fit: BoxFit.fill, height: ScreenUtil().setWidth(50), width: ScreenUtil().setWidth(50)),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenUtil().setWidth(15.0), 0, 0),
                  child: Text(msg, style: TextStyle(color: textColor, fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w500, decoration: TextDecoration.none)),
                )
              ],
            ),
          ),
        );
      }
//      widgetList.add(
//        ModalBarrier(
//          color: Color(0x03000000),
//          dismissible: false,
//        ),
//      );
      widgetList.add(layoutProgress);
    }
    return Stack(
      children: widgetList,
    );
  }
}
