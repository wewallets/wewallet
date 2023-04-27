import 'dart:async';

import 'package:flutter/cupertino.dart';

// 上下滚动的消息轮播
// ignore: must_be_immutable
class FontMarquee extends StatefulWidget {
  int count; // 子视图数量
  IndexedWidgetBuilder itemBuilder; // 子视图构造器

  FontMarquee(this.count, this.itemBuilder);

  @override
  _FontMarqueeState createState() => _FontMarqueeState();
}

class _FontMarqueeState extends State<FontMarquee> {
  PageController _controller;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
    if (widget.count > 1) {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) {
        // 如果当前位于最后一页，则直接跳转到第一页，两者内容相同，跳转时视觉上无感知
        if (_controller.page.round() >= widget.count) {
          _controller.jumpToPage(0);
        }
        _controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.linear);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _controller,
      itemBuilder: (buildContext, index) {
        if (index < widget.count) {
          return widget.itemBuilder(buildContext, index);
        } else {
          return widget.itemBuilder(buildContext, 0);
        }
      },
      itemCount: widget.count + 1, // 在原数据末尾添加一笔数据(即第一笔数据)，用于实现无限循环滚动效果
    );
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    if (_timer != null) _timer.cancel();
    super.dispose();
  }
}
