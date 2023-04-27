import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/pagingLoadNow.dart';
import 'package:mars/models/assets_log_entity.dart';
import 'package:mars/models/user_product_income_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//众筹收益记录
class CrowdFundingAwardRecordPage extends StatefulWidget {
  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<CrowdFundingAwardRecordPage> {
  PagingLoadNew pagingLoad = PagingLoadNew();
  RefreshController refreshController = RefreshController();

  List<AssetsLogEntity> allList = [];
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
        appBar: LayoutUtil.getAppBar(context, '${getString().zf11}'),
        body: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            enablePullDown: true,
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
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(adaptationDp(5)), color: Colours.white),
      margin: EdgeInsets.fromLTRB(adaptationDp(15), adaptationDp(15), adaptationDp(15), adaptationDp(0)),
      padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), top: adaptationDp(10)),
      child: Column(
        children: [
          Row(
            children: [
              Text('${allList[index].amount.contains('-') ? "" : "+"}${allList[index].amount} ${allList[index].currency.toUpperCase()}', style: TextStyles.textBlack15.copyWith(color: Color(0xFF3250D4))),
              Expanded(child: Container()),
              Text('${allList[index].logStr}', style: TextStyles.textBlack15),
            ],
          ),
          Gaps.vGap10,
          Lines.line,
          Gaps.vGap10,
          Row(
            children: [
              allList[index].number == null
                  ? Container()
                  : Text(getTitleCrowdFunding(allList[index]) + '${getString().zf55}${allList[index].number}${getString().zf56}${allList[index].zoon_number != null && allList[index].zoon_number != '' ? (allList[index].zoon_number + getString().xtj34 + getString().zf56) : ''}',
                      style: TextStyles.textBlack15),
              Expanded(child: Container()),
              Text('${allList[index].createDate}', style: TextStyles.textGrey12),
            ],
          ),
          Gaps.vGap10,
        ],
      ),
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

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    pagingLoad.request(
      url: ApiTransaction.assets_log,
      params: map,
      isFirstPage: isFirstPage,
      refreshController: refreshController,
      setState: setState,
      mounted: mounted,
      hierarchy: 'list',
      firstPage: (data) {
        allList.clear();
        data.forEach((itemJson) {
          allList.add(AssetsLogEntity().fromJson(itemJson));
        });
      },
      nextPage: (data) {
        data.forEach((itemJson) {
          allList.add(AssetsLogEntity().fromJson(itemJson));
        });
      },
    );
  }
}
