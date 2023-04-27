import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverCustomCommonHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final Widget Function(double shrinkOffset, bool overlapsContent) widget;

  SliverCustomCommonHeaderDelegate({this.collapsedHeight, this.expandedHeight, this.paddingTop, this.widget});

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget(shrinkOffset, overlapsContent);
  }
}
