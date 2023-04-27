import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/user_promote_entity.dart';

//我的众筹推广记录
class CrowdFundingPromotePage extends StatefulWidget {
  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<CrowdFundingPromotePage> {
  UserPromoteEntity userPromoteEntity;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: userPromoteEntity == null
          ? LayoutUtil.getLoadingShadeCustom()
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    Align(alignment: Alignment.topCenter, child: LoadAssetImage('home_head_bg', width: double.infinity, height: adaptationDp(124), fit: BoxFit.fill)),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          child: Text('${getString().zf64}', style: TextStyles.textWhite18),
                          padding: EdgeInsets.only(top: kToolbarHeight),
                        )),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          child: CupertinoButton(
                            child: LoadAssetImage('break_w', width: ScreenUtil().setWidth(44), fit: BoxFit.contain, color: Colours.white),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.pop(context);
                            },
                          ),
                          padding: EdgeInsets.only(top: kToolbarHeight, left: adaptationDp(10)),
                        )),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LoadAssetImage('tgdj${userPromoteEntity.levelRise == '0' ? '1' : userPromoteEntity.levelRise}', width: adaptationDp(20)),
                              Gaps.hGap10,
                              Text('${userPromoteEntity.levelRise}${getString().zf65}', style: TextStyles.textWhite12),
                            ],
                          ),
                          padding: EdgeInsets.only(top: adaptationDp(79), right: adaptationDp(80)),
                        )),
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(5))),
                  margin: EdgeInsets.all(adaptationDp(15)),
                  padding: EdgeInsets.all(adaptationDp(15)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${userPromoteEntity.childsNumber}', style: TextStyles.textBlack15),
                          Gaps.vGap5,
                          Text('${getString().zf66}', style: TextStyles.textBlack12),
                        ],
                      ))),
                      Container(width: 0.5, height: adaptationDp(20), color: Colours.colorEE),
                      Expanded(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${userPromoteEntity.teamRise}', style: TextStyles.textBlack15),
                            Gaps.vGap5,
                            Text('${getString().xtj8}', style: TextStyles.textBlack12),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                userPromoteEntity == null || userPromoteEntity.childsList == null || userPromoteEntity.childsList.length == 0
                    ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                    : listViewBuilder(
                        isSlide: true,
                        itemBuilder: (context, index) {
                          return buildList(index);
                        },
                        itemCount: userPromoteEntity.childsList.length),
                Gaps.vGap30,
              ],
            ),
    );
  }

  buildList(index) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(adaptationDp(5)), color: Colours.white),
      margin: EdgeInsets.fromLTRB(adaptationDp(15), adaptationDp(15), adaptationDp(15), adaptationDp(0)),
      padding: EdgeInsets.all(adaptationDp(10)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${getString().xtj9}', style: TextStyles.textGrey12),
              Expanded(child: Container()),
              inkButton(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: userPromoteEntity.childsList[index].account));
                    Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                  },
                  child: Text('${userPromoteEntity.childsList[index].account}', style: TextStyles.textGrey612)),
            ],
          ),
          Gaps.vGap10,
          Lines.line,
          Gaps.vGap10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${getString().xtj10}：', style: TextStyles.textGrey12),
              Text('${userPromoteEntity.childsList[index].raisedRise} RISE', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
            ],
          ),
          Gaps.vGap5,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${getString().xtj11}：', style: TextStyles.textGrey12),
              Text('${userPromoteEntity.childsList[index].teamRise} RISE', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
            ],
          ),
        ],
      ),
    );
  }

  getData() {
    Net().post(ApiTransaction.user_promote, null, success: (data) {
      userPromoteEntity = UserPromoteEntity().fromJson(data);
      if (mounted) setState(() {});
    }, failure: (error) {
      if (mounted) setState(() {});
    });
  }
}
