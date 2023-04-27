import 'package:flutter/material.dart';

class StickyDelegate extends SliverPersistentHeaderDelegate {
  final Container child;
  final double height;
 
  StickyDelegate({@required this.child,this.height});
 
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }
 
  @override
  double get maxExtent => this.height;
 
  @override
  double get minExtent => this.height;
 
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true; // 如果内容需要更新，设置为true
  }
}