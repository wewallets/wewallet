import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/index.dart';
import 'package:mars/models/poolyesterday_entity.dart';
import 'package:mars/routes/drawer/user_drawer.dart';
import 'package:mars/widgets/dialog/scan_view_sheet_dialog.dart';
import 'package:mars/widgets/font_marquee.dart';
import 'package:mars/widgets/sliver_custom_common_header_delegate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//关于我们
class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>  {
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FB),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: false,
        onRefresh: () async {},
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                buildSliverPersistentHeader,
                SliverList(
                    delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
                          children: [
                            buildModular,
                          ],
                        );
                      },
                      childCount: 1,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  get buildSliverPersistentHeader {
    double expandedHeight = ScreenUtil().setWidth(70) + ScreenUtil().statusBarHeight + kToolbarHeight;
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverCustomCommonHeaderDelegate(
            expandedHeight: expandedHeight,
            collapsedHeight: kToolbarHeight - ScreenUtil().setWidth(20),
            paddingTop: ScreenUtil().statusBarHeight,
            widget: (double shrinkOffset, bool overlapsContent) {
              return Container(
                  height: expandedHeight,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      LoadImage('u_tb', fit: BoxFit.fill, width: double.infinity, height: expandedHeight),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            color: makeStickyHeaderWhite(expandedHeight, kToolbarHeight, shrinkOffset),
                            padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight + ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                            height: kToolbarHeight + ScreenUtil().statusBarHeight,
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                              Gaps.hGap20,
                              inkButton(
                                  child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(50), color: makeStickyHeaderIconColor(shrinkOffset)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ]),
                          )),
                    ],
                  ));
            }));
  }

  Color makeStickyHeaderWhite(maxExtent, minExtent, shrinkOffset) {
    final int alpha = (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderIconColor(shrinkOffset) {
    if (shrinkOffset <= 60)
      return Colours.white;
    else
      return null;
  }

  get buildModular {
    return Container(
        margin: EdgeInsets.only(left: adaptationDp(30), right: adaptationDp(30)),
        child: Column(children: [
          Gaps.vGap30,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
              Gaps.hGap5,
              Text('${getString().gywmwb1}', style: TextStyles.textBlack16.copyWith(color: Color(0xFF263090), fontWeight: FontWeight.bold)),
              Gaps.hGap5,
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
            ],
          ),
          Gaps.vGap10,
          Text.rich(TextSpan(children: [
            TextSpan(text: '【${getString().gywmwb1}】', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold, color: Colours.themeColor)),
            TextSpan(text: '${getString().gywmwb2}', style: TextStyles.textGrey13.copyWith(color: Color(0xFF555555))),
          ])),
          Gaps.vGap10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
              Gaps.hGap5,
              Text('${getString().gywmwb3}', style: TextStyles.textBlack16.copyWith(color: Color(0xFF263090), fontWeight: FontWeight.bold)),
              Gaps.hGap5,
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
            ],
          ),
          Gaps.vGap10,
          Text.rich(TextSpan(children: [
            TextSpan(text: '【${getString().gywmwb4}】', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold, color: Colours.themeColor)),
            TextSpan(text: '${getString().gywmwb5}', style: TextStyles.textGrey13.copyWith(color: Color(0xFF555555))),
          ])),
          Gaps.vGap30,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
              Gaps.hGap5,
              Text('${getString().gywmwb6}', style: TextStyles.textBlack16.copyWith(color: Color(0xFF263090), fontWeight: FontWeight.bold)),
              Gaps.hGap5,
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
            ],
          ),
          Gaps.vGap10,
          Text.rich(TextSpan(children: [
            TextSpan(text: '【${getString().gywmwb7}】', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold, color: Colours.themeColor)),
            TextSpan(text: '${getString().gywmwb8}', style: TextStyles.textGrey13.copyWith(color: Color(0xFF555555))),
          ])),
          Gaps.vGap10,
          Text.rich(TextSpan(children: [
            TextSpan(text: '【${getString().gywmwb9}】', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold, color: Colours.themeColor)),
            TextSpan(text: '${getString().gywmwb10}', style: TextStyles.textGrey13.copyWith(color: Color(0xFF555555))),
          ])),
          Gaps.vGap10,
          Text.rich(TextSpan(children: [
            TextSpan(text: '【${getString().gywmwb11}】', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold, color: Colours.themeColor)),
            TextSpan(text: '${getString().gywmwb12}', style: TextStyles.textGrey13.copyWith(color: Color(0xFF555555))),
          ])),
          Gaps.vGap30,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
              Gaps.hGap5,
              Text('${getString().gywmwb13}', style: TextStyles.textBlack16.copyWith(color: Color(0xFF263090), fontWeight: FontWeight.bold)),
              Gaps.hGap5,
              Container(width: adaptationDp(40), height: adaptationDp(0.5), color: Color(0xFF263090)),
            ],
          ),
          Gaps.vGap10,
          Row(children: [
            Expanded(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadAssetImage('u_zc', width: adaptationDp(34)),
                Gaps.vGap5,
                Text('${getString().gywmwb14}', style: TextStyles.textBlack13.copyWith(color: Color(0xFF263090))),
              ],
            ))),
            Expanded(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadAssetImage('u_ql', width: adaptationDp(34)),
                Gaps.vGap5,
                Text('${getString().gywmwb15}', style: TextStyles.textBlack13.copyWith(color: Color(0xFF263090))),
              ],
            ))),
            Expanded(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadAssetImage('u_zy', width: adaptationDp(34)),
                Gaps.vGap5,
                Text('${getString().gywmwb16}', style: TextStyles.textBlack13.copyWith(color: Color(0xFF263090))),
              ],
            ))),
            Expanded(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadAssetImage('u_xt', width: adaptationDp(34)),
                Gaps.vGap5,
                Text('${getString().gywmwb17}', style: TextStyles.textBlack13.copyWith(color: Color(0xFF263090))),
              ],
            ))),
          ]),
        ]));
  }
}
