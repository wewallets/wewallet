import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/utils/my_color.dart';
import 'package:mars/common/utils/my_imgs.dart';
import 'package:mars/common/utils/my_widget_builder.dart';
import 'package:mars/res/styles.dart';

class EmptyView extends StatelessWidget {
  final String str;
  EmptyView(this.str);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          MImage.icEmpty,
          Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(27))),
          Text(str,
              style: TextStyles.textGrey14)
        ],
      ),
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(250)),
    );
  }
}
