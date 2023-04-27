import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/user_income_entity.dart';

//我的众筹奖励
class CrowdFundingAwardPage extends StatefulWidget {
  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<CrowdFundingAwardPage> {
  UserIncomeEntity userIncomeEntity;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: LayoutUtil.getAppBar(context, '${getString().zf1}', actions: [
        InkResponse(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(30)),
              child: Row(children: [
                Text('${getString().zf2}', style: TextStyles.text7854D528.copyWith(color: Color(0xFF3250D4))),
                // Gaps.hGap5,
                // LoadImage('xiajiantou', width: ScreenUtil().setWidth(20)),
              ])),
          onTap: () {
            navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_award_record_page);
          },
        )
      ]),
      body: userIncomeEntity == null
          ? LayoutUtil.getLoadingShadeCustom()
          : ListView(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(5))),
                  margin: EdgeInsets.all(adaptationDp(15)),
                  padding: EdgeInsets.all(adaptationDp(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${getString().zf3}', style: TextStyles.textBlack15),
                      Gaps.vGap15,
                      Lines.line,
                      Gaps.vGap15,
                      Row(
                        children: [
                          Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${userIncomeEntity.incomeDynamic} RISE', style: TextStyles.textGrey12.copyWith(color: Color(0xFF3250D4))),
                            Gaps.vGap5,
                            Text('${getString().zf4}', style: TextStyles.textBlack12),
                          ])),
                          Container(width: adaptationDp(0.5), color: Color(0xFFE6E6E6), height: adaptationDp(30)),
                          Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${userIncomeEntity.incomeStatic} RISE', style: TextStyles.textGrey12.copyWith(color: Color(0xFF3250D4))),
                            Gaps.vGap5,
                            Text('${getString().zf5}', style: TextStyles.textBlack12),
                          ])),
                          Container(width: adaptationDp(0.5), color: Color(0xFFE6E6E6), height: adaptationDp(30)),
                          Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${userIncomeEntity.incomeDividend} RISE', style: TextStyles.textGrey12.copyWith(color: Color(0xFF3250D4))),
                            Gaps.vGap5,
                            Text('${getString().zf6}', style: TextStyles.textBlack12),
                          ])),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(5))),
                  margin: EdgeInsets.only(bottom: adaptationDp(15), right: adaptationDp(15), left: adaptationDp(15)),
                  padding: EdgeInsets.all(adaptationDp(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LoadImage('ggxiaolicon', width: adaptationDp(25)),
                          Gaps.hGap5,
                          Text('YISE', style: TextStyles.textBlack15),
                          Expanded(child: Container()),
                          inkButton(
                              onPressed: () {
                                Navigator.pushNamed(context, PageTransactionRouter.crowdfunding_transfer_page, arguments: Bundle()..putString('assetsRise', userIncomeEntity.assetsRise)).then((value) {
                                  getData();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFF3250D4), borderRadius: BorderRadius.circular(adaptationDp(5))),
                                padding: EdgeInsets.only(left: adaptationDp(20), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(20)),
                                alignment: Alignment.center,
                                child: Text('${getString().zf7}', style: TextStyles.textWhite12),
                              )),
                        ],
                      ),
                      Gaps.vGap15,
                      Lines.line,
                      Gaps.vGap15,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${getString().zf8} ', style: TextStyles.textBlack14),
                          Text('${userIncomeEntity.assetsRise} RISE', style: TextStyles.textBlack14.copyWith(color: Color(0xFF3250D4))),
                          Expanded(child: Container()),
                          Gaps.hGap15,
                        ],
                      ),
                      Gaps.vGap10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${getString().dongjie} ', style: TextStyles.textBlack14),
                          Text('${userIncomeEntity.freeze} RISE', style: TextStyles.textBlack14.copyWith(color: Color(0xFF3250D4))),
                          Expanded(child: Container()),
                          Gaps.hGap15,
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(5))),
                  margin: EdgeInsets.only(bottom: adaptationDp(15), right: adaptationDp(15), left: adaptationDp(15)),
                  padding: EdgeInsets.all(adaptationDp(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LoadAssetImage('jifenlog', width: adaptationDp(25)),
                          Gaps.hGap5,
                          Text('${getString().zf9}', style: TextStyles.textBlack14),
                          Expanded(child: Container()),
                        ],
                      ),
                      Gaps.vGap15,
                      Lines.line,
                      Gaps.vGap15,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${getString().zf10} ', style: TextStyles.textBlack14),
                          Text('${userIncomeEntity.consumRise}', style: TextStyles.textBlack14.copyWith(color: Color(0xFF3250D4))),
                          Expanded(child: Container()),
                          Gaps.hGap15,
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(5))),
                  margin: EdgeInsets.only(bottom: adaptationDp(15), right: adaptationDp(15), left: adaptationDp(15)),
                  padding: EdgeInsets.all(adaptationDp(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LoadImage('ggxiaoliconai', width: adaptationDp(25)),
                          Gaps.hGap5,
                          Text('${getString().xtj33}', style: TextStyles.textBlack15),
                          Expanded(child: Container()),
                          inkButton(
                              onPressed: () {
                                Navigator.pushNamed(context, PageTransactionRouter.crowdfunding_transfer_page,
                                    arguments: Bundle()
                                      ..putString('assetsRise', userIncomeEntity.assetsAiRise)
                                      ..putInt('type', 4))
                                    .then((value) {
                                  getData();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFF3250D4), borderRadius: BorderRadius.circular(adaptationDp(5))),
                                padding: EdgeInsets.only(left: adaptationDp(20), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(20)),
                                alignment: Alignment.center,
                                child: Text('${getString().zhaunchu}', style: TextStyles.textWhite12),
                              )),
                          Gaps.hGap12,
                          inkButton(
                              onPressed: () {
                                Navigator.pushNamed(context, PageTransactionRouter.crowdfunding_transfer_page,
                                        arguments: Bundle()
                                          ..putString('assetsRise', userIncomeEntity.assetsRise)
                                          ..putInt('type', 3))
                                    .then((value) {
                                  getData();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFF3250D4), borderRadius: BorderRadius.circular(adaptationDp(5))),
                                padding: EdgeInsets.only(left: adaptationDp(20), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(20)),
                                alignment: Alignment.center,
                                child: Text('${getString().zf7}', style: TextStyles.textWhite12),
                              )),
                        ],
                      ),
                      Gaps.vGap15,
                      Lines.line,
                      Gaps.vGap15,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${getString().zf8} ', style: TextStyles.textBlack14),
                          Text('${userIncomeEntity.assetsAiRise} RISE', style: TextStyles.textBlack14.copyWith(color: Color(0xFF3250D4))),
                          Expanded(child: Container()),
                          Gaps.hGap15,
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  getData() {
    Net().post(ApiTransaction.user_income, null, success: (data) {
      userIncomeEntity = UserIncomeEntity().fromJson(data);
      if (mounted) setState(() {});
    }, failure: (error) {
      if (mounted) setState(() {});
    });
  }
}
