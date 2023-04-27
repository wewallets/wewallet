import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mars/common/transaction_component_index.dart';

enum EntryAnimation {
  DEFAULT,
  LEFT,
  RIGHT,
  TOP,
  BOTTOM,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
}

class BaseDialog extends StatefulWidget {
  BaseDialog({Key key, @required this.entryAnimation, @required this.widget,  this.cornerRadius, this.height, this.width,this.backgroundColor}) : super(key: key);

  final EntryAnimation entryAnimation;
  final Widget widget;
  final double cornerRadius;
  final double height;
  final double width;
  final Color backgroundColor;
  @override
  _BaseDialogState createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _entryAnimation;

  get _start {
    switch (widget.entryAnimation) {
      case EntryAnimation.DEFAULT:
        break;
      case EntryAnimation.TOP:
        return Offset(0.0, -1.0);
      case EntryAnimation.TOP_LEFT:
        return Offset(-1.0, -1.0);
      case EntryAnimation.TOP_RIGHT:
        return Offset(1.0, -1.0);
      case EntryAnimation.LEFT:
        return Offset(-1.0, 0.0);
      case EntryAnimation.RIGHT:
        return Offset(1.0, 0.0);
      case EntryAnimation.BOTTOM:
        return Offset(0.0, 1.0);
      case EntryAnimation.BOTTOM_LEFT:
        return Offset(-1.0, 1.0);
      case EntryAnimation.BOTTOM_RIGHT:
        return Offset(1.0, 1.0);
    }
  }

  get _isDefaultEntryAnimation => widget.entryAnimation == EntryAnimation.DEFAULT;

  @override
  void initState() {
    super.initState();
    if (!_isDefaultEntryAnimation) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );
      _entryAnimation = Tween<Offset>(begin: _start, end: Offset(0.0, 0.0)).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeIn,
        ),
      )..addListener(() => setState(() {}));
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        transform: !_isDefaultEntryAnimation ? Matrix4.translationValues(_entryAnimation.value.dx * width, _entryAnimation.value.dy * width, 0) : null,
        height: widget.height ?? MediaQuery.of(context).size.height * 0.6,
        width: widget.width ?? MediaQuery.of(context).size.width * (isPortrait ? 0.8 : 0.6),
        child: Material(
          color:widget.backgroundColor ??Colours.transparent,
          type: MaterialType.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.cornerRadius??8)),
          elevation: Theme.of(context).dialogTheme.elevation ?? 24.0,
          child: widget.widget,
        ),
      ),
    );
  }
}
