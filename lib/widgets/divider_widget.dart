
import 'package:flutter/cupertino.dart';
import 'package:mars/common/utils/my_color.dart';

class MDivider extends StatelessWidget {
  final double height;
  final Color mColor;

  MDivider({this.height,this.mColor});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: (height==null?10:height),
      color: (mColor==null?MColor.dividerColor:mColor),
    );
  }

}