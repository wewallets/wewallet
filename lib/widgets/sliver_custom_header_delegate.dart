import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mars/common/transaction_component_index.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverBackground;
  final String titleBackground;
  final String leftImage;
  final String title;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverBackground,
    this.titleBackground,
    this.title,
    this.leftImage,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 60) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
  }

  Color makeStickyHeaderBlackTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 60 && isIcon) {
      return shrinkOffset <= 60 ? Colors.white : Colors.black;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 背景图
          shrinkOffset > 60 && titleBackground == null ? Container() : Container(child: LoadImage(shrinkOffset <= 60 ? coverBackground : titleBackground, fit: BoxFit.fill)),
          // 收起头部
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: shrinkOffset > 60 && titleBackground == null ? makeStickyHeaderTextColor(shrinkOffset, false) : Colours.transparent,
              constraints: BoxConstraints(maxHeight: minExtent),
              padding: EdgeInsets.only(top: paddingTop),
              child: Row(children: <Widget>[
                InkWell(
                  child: Padding(
                      child: titleBackground == null ? LoadAssetImage(leftImage, width: ScreenUtil().setWidth(44), color: makeStickyHeaderBlackTextColor(shrinkOffset, true)) : LoadAssetImage(leftImage, width: ScreenUtil().setWidth(44)), padding: EdgeInsets.only(left: ScreenUtil().setWidth(20))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: Padding(
                        child: Center(child: Text(title, style: TextStyles.textWhite20.copyWith(color: shrinkOffset > 60 && titleBackground == null ? makeStickyHeaderBlackTextColor(shrinkOffset, false) : makeStickyHeaderTextColor(shrinkOffset, false)))),
                        padding: EdgeInsets.only(right: ScreenUtil().setWidth(64)))),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
