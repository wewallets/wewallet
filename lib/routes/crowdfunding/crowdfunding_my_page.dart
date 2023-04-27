import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/pagingLoadNow.dart';
import 'package:mars/models/user_product_entity.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utils/num_util.dart';

//我的众筹
class CrowdFundingMyPage extends StatefulWidget {
  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<CrowdFundingMyPage> {
  PagingLoadNew pagingLoad = PagingLoadNew();
  RefreshController refreshController = RefreshController();

  List<UserProductEntity> allList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getData(isFirstPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
        body: SmartRefresher(
            controller: refreshController,
            enablePullUp: false,
            enablePullDown: false,
            onRefresh: () {
              getData(isFirstPage: true);
            },
            onLoading: () {
              getData();
            },
            child: !pagingLoad.errorNullData
                ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                : listViewBuilder(
                    itemBuilder: (context, index) {
                      return buildList(index);
                    },
                    itemCount: allList.length)));
  }

  buildList(index) {
    return inkButton(
      onPressed: () {
        navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_record_page,
            bundle: Bundle()
              ..putString('product_id', allList[index].productId)
              ..putString('title', getTitleCrowdFunding(allList[index]) + '【${getString().zf55}${allList[index].number}${getString().zf56}】')
              ..putString('icon', allList[index].icon));
      },
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(adaptationDp(5)), color: Colours.white),
          margin: EdgeInsets.fromLTRB(adaptationDp(15), adaptationDp(15), adaptationDp(15), adaptationDp(0)),
          padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), top: adaptationDp(10)),
          child: Column(
            children: [
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: allList[index].raiseStatus == '2' ? Color(0x1A666666) : Color(0x1A3250D4), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: allList[index].raiseStatus == '2' ? Color(0xFF666666) : Color(0xFF3250D4), width: 0.5)),
                    padding: EdgeInsets.only(left: adaptationDp(13), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(13)),
                    alignment: Alignment.center,
                    child: Text('${allList[index].raiseStatusStr}', style: TextStyles.textBlack12.copyWith(color: allList[index].raiseStatus == '2' ? Color(0xFF666666) : Color(0xFF3250D4))),
                  ),
                  Gaps.hGap10,
                  Text('${getTitleCrowdFunding(allList[index])} 【${getString().zf55}${allList[index].number}${getString().zf56}${allList[index].zoon_number != null && allList[index].zoon_number != '' ? (allList[index].zoon_number + getString().xtj34 + getString().zf56) : ''}】',
                      style: TextStyles.textBlack15),
                  Expanded(child: Container()),
                  Padding(
                      padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${getString().zf57} ', style: TextStyles.textGrey612),
                          LoadAssetImage('youjiantou', width: adaptationDp(12)),
                        ],
                      )),
                ],
              )),
              Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Lines.line),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('${getString().xtj1}：', style: TextStyles.textGrey12),
                Text('${allList[index].platformBonusAmount} ${allList[index].currency.toUpperCase()}', style: TextStyles.textGrey12.copyWith(color: Color(0xFF3250D4))),
                Expanded(child: Container()),
                Text('${getString().xtj6}：', style: TextStyles.textGrey12),
                Text('${allList[index].payAmount} ${allList[index].currency.toUpperCase()}', style: TextStyles.textBlack12),
              ]),
              Container(
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15)),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - adaptationDp(50),
                  animation: true,
                  lineHeight: adaptationDp(8),
                  padding: EdgeInsets.zero,
                  backgroundColor: Color(0xFFEAEAEA),
                  animationDuration: 1000,
                  percent: double.parse((double.parse(allList[index].totaled) / double.parse(allList[index].total)).toString()),
                  barRadius: Radius.circular(adaptationDp(5)),
                  progressColor: Color(0xFF3250D4),
                ),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('${getString().zf60} ', style: TextStyles.textGrey12),
                Text('${NumUtil.formatNum((double.parse(allList[index].totaled) / double.parse(allList[index].total) * 100).toString(), 4)}%', style: TextStyles.textGrey612.copyWith(color: Color(0xFF3250D4))),
                Expanded(child: Container()),
                Text('${getString().zf61}：', style: TextStyles.textGrey12),
                Text('${allList[index].total} ${allList[index].currency.toUpperCase()}', style: TextStyles.textGrey12.copyWith(color: Color(0xFF3250D4))),
              ]),
              Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Lines.line),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text('${allList[index].payAmount ?? '0.0'} ${allList[index].currency.toUpperCase()}', style: TextStyles.textGrey15.copyWith(color: Color(0xFF3250D4))),
                    Gaps.vGap10,
                    Text('${getString().zf62}', style: TextStyles.textBlack12),
                  ])),
                  Container(width: adaptationDp(0.5), color: Color(0xFFE6E6E6), height: adaptationDp(30)),
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text('${allList[index].income ?? '0.0'} ${allList[index].currency.toUpperCase()}', style: TextStyles.textBlack15),
                    Gaps.vGap10,
                    Text('${getString().zf63}', style: TextStyles.textBlack12),
                  ])),
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text('${allList[index].startTime}-\n${allList[index].endTime}', style: TextStyles.textBlack10),
                    Gaps.vGap5,
                    Text('${getString().xtj7}', style: TextStyles.textBlack12),
                  ])),
                ],
              ),
              Gaps.vGap15,
            ],
          )),
    );
  }

  getTitleCrowdFunding(data) {
    if (SpUtil.getString('locale') == 'zh') {
      return data.title;
    } else if (SpUtil.getString('locale') == 'en') {
      return data.titleEn;
    } else if (SpUtil.getString('locale') == 'ms') {
      return data.titleMs;
    } else if (SpUtil.getString('locale') == 'th') {
      return data.titleTh;
    } else
      return data.title;
  }

  getTypeStrColor(type) {
    switch (type) {
      case '-1':
        return Color(0xFF3250D4);
      case '0':
        return Color(0xFFFE3937);
      default:
        return Color(0xFF666666);
    }
  }

  getTypeColor(type) {
    switch (type) {
      case 0:
        return Color(0xFFF6AF46);
      case 1:
        return Color(0xFFFE3937);
      case 2:
        return Color(0xFF3250D4);
      default:
        return Color(0xFFF6AF46);
    }
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    pagingLoad.request(
      url: ApiTransaction.user_product,
      params: map,
      isFirstPage: isFirstPage,
      refreshController: refreshController,
      setState: setState,
      mounted: mounted,
      firstPage: (data) {
        allList.clear();
        data.forEach((itemJson) {
          allList.add(UserProductEntity().fromJson(itemJson));
        });
      },
      nextPage: (data) {
        data.forEach((itemJson) {
          allList.add(UserProductEntity().fromJson(itemJson));
        });
      },
    );
  }
}
