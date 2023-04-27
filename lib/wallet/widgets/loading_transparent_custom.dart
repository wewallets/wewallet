import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/wallet/res/colors.dart';

/**
 * 加载进度条组件
 */
class LoadingTransparentCustom extends StatelessWidget {
  const LoadingTransparentCustom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new ModalBarrier(
          color: Colors.transparent,
          dismissible: false,
        ),
        _loadingView
      ],
    );
  }

  Widget get _loadingView {
    return Center(
      child: Opacity(
        opacity: 0.8,
        child: Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(60.0)),
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colours().themeColor)),
        ),
      ),
    );
  }
}
