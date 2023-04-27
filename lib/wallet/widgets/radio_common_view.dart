import 'package:flutter/material.dart';

/**
 * 右边能加其他widget单选
 */
class RadioCommonView extends StatelessWidget {
  final Function onChanged;
  final Image checkImage;
  final Image cancelImage;
  final String value;
  final String groupValue;
  Widget rightWidget;
  final EdgeInsetsGeometry edgeInsetsGeometry;

  bool get checked => value == groupValue;

  RadioCommonView(
      {Key key,
      this.rightWidget,
      @required this.edgeInsetsGeometry,
      @required this.value,
      @required this.checkImage,
      @required this.cancelImage,
      @required this.groupValue,
      @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged != null && !checked
          ? () {
              onChanged(value);
            }
          : null,
      child: Row(
        children: <Widget>[
          Padding(
              padding: edgeInsetsGeometry,
              child: !checked ? cancelImage : checkImage),
          rightWidget == null ? Container() : rightWidget,
        ],
      ),
    );
  }

//
}
