import 'package:flutter/cupertino.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/pagingLoadNow.dart';
import 'package:mars/models/assets_log_entity.dart';
import 'package:mars/models/noticeList.dart';
import 'package:mars/models/user_product_income_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//帮助中心
class HelpCenterListPage extends StatefulWidget {
  final int type;

  HelpCenterListPage(this.type);

  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<HelpCenterListPage> {
  PagingLoadNew pagingLoad = PagingLoadNew();
  RefreshController refreshController = RefreshController();

  List<NoticeList> allList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getData(isFirstPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.white,
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
                : Container(
                    margin: EdgeInsets.all(adaptationDp(15)),
                    padding: EdgeInsets.only(bottom: adaptationDp(15)),
                    decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(5))),
                    child: listViewBuilder(
                        itemBuilder: (context, index) {
                          return inkButton(
                              child: buildList(index),
                              onPressed: () {
                                Navigator.pushNamed(context, PageTransactionRouter.webview_page,
                                    arguments: Bundle()
                                      ..putString('titleName', '${getString().zf78}${getString().xq}')
                                      ..putString('url', '${ApiTransaction.BASE_URL}explorer/notice_detail/${allList[index].id}.html'));
                              });
                        },
                        itemCount: allList.length))));
  }

  buildList(index) {
    return Container(
      padding: EdgeInsets.only(top: adaptationDp(15)),
      child: Column(
        children: [
          Row(children: [
            Text('${allList[index].title}', style: TextStyles.textBlack13),
            Expanded(child: Container()),
            LoadImage('youjiantou', width: adaptationDp(22)),
          ]),
          Gaps.vGap15,
          Lines.line,
        ],
      ),
    );
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    map['flag'] = '11';
    pagingLoad.request(
      url: ApiTransaction.agreement,
      params: map,
      isFirstPage: isFirstPage,
      refreshController: refreshController,
      setState: setState,
      mounted: mounted,
      firstPage: (data) {
        allList.clear();
        data.forEach((itemJson) {
          allList.add(NoticeList.fromJson(itemJson));
        });
      },
      nextPage: (data) {
        data.forEach((itemJson) {
          allList.add(NoticeList.fromJson(itemJson));
        });
      },
    );
  }
}
