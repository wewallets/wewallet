import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/pagingLoadNow.dart';
import 'package:mars/models/user_product_income_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//众筹收益记录
class CrowdFundingRecordPage extends StatefulWidget {
  final Bundle bundle;

  CrowdFundingRecordPage(this.bundle);

  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<CrowdFundingRecordPage> {
  PagingLoadNew pagingLoad = PagingLoadNew();
  RefreshController refreshController = RefreshController();

  List<UserProductIncomeEntity> allList = [];
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
        appBar: LayoutUtil.getAppBar(context, '${getString().zf69}'),
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
            child: Column(
              children: [
                Container(
                  color: Colours.white,
                  padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), top: adaptationDp(15), bottom: adaptationDp(15)),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    LoadImage(widget.bundle.getString('icon'), width: adaptationDp(25)),
                    Gaps.hGap10,
                    Text(widget.bundle.getString('title'), style: TextStyles.textBlack15),
                    Expanded(child: Container()),
                  ]),
                ),
                Expanded(
                    child: !pagingLoad.errorNullData
                        ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                        : listViewBuilder(
                            itemBuilder: (context, index) {
                              return buildList(index);
                            },
                            itemCount: allList.length))
              ],
            )));
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
              Text('${allList[index].typeStr}', style: TextStyles.textBlack16),
              Expanded(child: Container()),
              Text('${allList[index].amount.contains('-') ? "" : "+"}${allList[index].amount} ${allList[index].currency.toUpperCase()}', style: TextStyles.textTheme15.copyWith(color: Color(0xFF3250D4))),
            ],
          ),
          Gaps.vGap10,
          Lines.line,
          Gaps.vGap10,
          Row(
            children: [
              Text('${allList[index].createTime}', style: TextStyles.textGrey12),
              Expanded(child: Container()),
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
    map['product_id'] = widget.bundle.getString('product_id');
    pagingLoad.request(
      url: ApiTransaction.user_product_income,
      params: map,
      isFirstPage: isFirstPage,
      refreshController: refreshController,
      setState: setState,
      mounted: mounted,
      firstPage: (data) {
        allList.clear();
        data.forEach((itemJson) {
          allList.add(UserProductIncomeEntity().fromJson(itemJson));
        });
      },
      nextPage: (data) {
        data.forEach((itemJson) {
          allList.add(UserProductIncomeEntity().fromJson(itemJson));
        });
      },
    );
  }
}
