import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/http/api.dart';
import 'package:mars/common/http/net.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:mars/models/poolcontribution_entity.dart';
import 'package:mars/models/poolunder_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//矿池贡献
class OreContributionPage extends StatefulWidget {
  @override
  _OreContributionPageState createState() => _OreContributionPageState();
}

class _OreContributionPageState extends State<OreContributionPage> with TickerProviderStateMixin {
  RefreshController refreshController = RefreshController();

  String currency = 'THC';

  PoolcontributionEntity profit;
  PagingLoad pagingLoad = PagingLoad();
  List<PoolunderEntity> _allList = [];

  String poolUnderTotalCount = '0';

  @override
  void initState() {
    super.initState();
    getData();
    getLedger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LayoutUtil.getAppBar(context, '贡献展示'),
        body: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: () {
              pagingLoad.reset();
              getData();
              getLedger();
            },
            onLoading: () {
              getLedger();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: adaptationDp(30), bottom: adaptationDp(35), left: adaptationDp(30), right: adaptationDp(30)),
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('ore_card')), fit: BoxFit.fill)),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text('团队持币量', style: TextStyles.textWhite12.copyWith(color: Color(0x99FFFFFF))),
                                    Gaps.vGap8,
                                    Text('${profit?.teamAmount}', style: TextStyles.textWhite14),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text('推广算力', style: TextStyles.textWhite12.copyWith(color: Color(0x99FFFFFF))),
                                    Gaps.vGap8,
                                    Text('${profit?.generaPower}', style: TextStyles.textWhite14),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                )),
                              ],
                            ),
                            Container(height: adaptationDp(0.5), color: Color(0x1AFFFFFF), width: double.infinity, margin: EdgeInsets.only(bottom: adaptationDp(15), top: adaptationDp(15))),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text('累计持币收益', style: TextStyles.textWhite12.copyWith(color: Color(0x99FFFFFF))),
                                    Gaps.vGap8,
                                    Text('${profit?.processAward}', style: TextStyles.textWhite14),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text('累计推广收益', style: TextStyles.textWhite12.copyWith(color: Color(0x99FFFFFF))),
                                    Gaps.vGap8,
                                    Text('${profit?.generaAward}', style: TextStyles.textWhite14),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                              ],
                            ),
                            Container(height: adaptationDp(0.5), color: Color(0x1AFFFFFF), width: double.infinity, margin: EdgeInsets.only(bottom: adaptationDp(15), top: adaptationDp(15))),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text('直推矿工总数', style: TextStyles.textWhite12.copyWith(color: Color(0x99FFFFFF))),
                                    Gaps.vGap8,
                                    Text('$poolUnderTotalCount', style: TextStyles.textWhite14),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text('团队矿工总数', style: TextStyles.textWhite12.copyWith(color: Color(0x99FFFFFF))),
                                    Gaps.vGap8,
                                    Text('${profit?.minersTeam}', style: TextStyles.textWhite14),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(color: Colours.colorEE, height: ScreenUtil().setWidth(16)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(29), vertical: ScreenUtil().setWidth(34)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('矿工列表', style: TextStyles.textBlack16.copyWith(fontWeight: FontWeight.bold)),
                            Gaps.vGap15,
                            Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: [
                              LoadImage('ore_zjsy', width: adaptationDp(30)),
                              Gaps.hGap5,
                              Text('最佳持币:', style: TextStyles.textBlack14.copyWith(color: Color(0xFF0B97E4))),
                              Text('${profit?.bestKeepLimit ?? 0.0}（TH+THC）', style: TextStyles.textWhite14.copyWith(color: Color(0xFF0B97E4))),
                            ]),
                            Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: [
                              Gaps.hGap30,
                              Gaps.hGap5,
                              Text('最低持币:', style: TextStyles.textBlack14.copyWith(color: Color(0xFF05C0B5))),
                              Text('${profit?.minKeepLimit ?? 0.0}（TH+THC）', style: TextStyles.textWhite14.copyWith(color: Color(0xFF05C0B5))),
                            ]),
                          ],
                        ),
                      ),
                      profit == null ? LayoutUtil.getLoadingShadeCustom(top: 200) : Container(),
                      _allList.length == 0 || pagingLoad.loading
                          ? pagingLoad.loading
                              ? LayoutUtil.getLoadingShadeCustom()
                              : LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                          : Container(
                              decoration: BoxDecoration(color: Colours.colorF5, borderRadius: BorderRadius.circular(adaptationDp(25))),
                              padding: EdgeInsets.only(top: adaptationDp(6.5), bottom: adaptationDp(6.5)),
                              child: Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text('账户名', style: TextStyles.textGrey12),
                                        Text('团队持币', style: TextStyles.textGrey12),
                                      ])),
                                  listViewBuilder(
                                      itemCount: _allList.length,
                                      isSlide: true,
                                      padding: EdgeInsets.all(adaptationDp(15)),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(top: index == 0 ? 0.0 : adaptationDp(20)),
                                          child: Row(
                                            children: [
                                              Text('${_allList[index].nickName}', style: TextStyles.textBlack15),
                                              Expanded(child: Container()),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('TH ${_allList[index].total_assets_TH}', style: TextStyles.textBlack13),
                                                  Text('THC ${_allList[index].total_assets_THC}', style: TextStyles.textBlack13),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ))
                    ],
                  ),
                ]))
              ],
            )));
  }

  getData({isLoading = false}) {
    if (SpUtil.hasKey('poolcontribution$currency')) {
      profit = SpUtil.getObj('poolcontribution$currency', (v) => PoolcontributionEntity().fromJson(v));
      if (mounted) setState(() {});
    }
    if (isLoading) showLoadingContextDialog(context);

    Net().post(ApiTransaction.MPOOL_POOL_CONTRIBUTION, {'currency': currency}, success: (data) {
      profit = PoolcontributionEntity().fromJson(data);
      SpUtil.putObject('poolcontribution$currency', profit);

      if (mounted) setState(() {});
    });
  }

  getLedger() {
    var map = pagingLoad.getMapPagingLoad();
    map['type'] = '1';

    Net().post(ApiTransaction.MPOOL_POOLLUNDER, map, success: (data) {
      pagingLoad.loading = false;
      poolUnderTotalCount = data['page']['totalCount'];
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        _allList.clear();
        data['list'].forEach((element) {
          _allList.add(PoolunderEntity().fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          _allList.add(PoolunderEntity().fromJson(element));
        });
      } else {
        pagingLoad.reduce();
        refreshController.refreshCompleted();
        refreshController.loadNoData();
      }
      if (mounted) setState(() {});
    }, failure: (error) {
      pagingLoad.reduce();
      pagingLoad.loading = false;

      if (mounted) setState(() {});
    });
  }
}
