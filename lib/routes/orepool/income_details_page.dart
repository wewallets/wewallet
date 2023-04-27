import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:mars/models/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//收益明细
class IncomeDetailsPage extends StatefulWidget {
  @override
  _IncomeDetailsPageState createState() => _IncomeDetailsPageState();
}

class _IncomeDetailsPageState extends State<IncomeDetailsPage> {
  RefreshController refreshController = RefreshController();
  List<RewardLog> _allList = [];
  PagingLoad pagingLoad = PagingLoad();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, '${s.text73}'),
        body: _allList.length == 0 || pagingLoad.loading
            ? pagingLoad.loading
                ? LayoutUtil.getLoadingShadeCustom()
                : LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
            : SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () {
                  pagingLoad.reset();
                  getData();
                },
                onLoading: () {
                  getData();
                },
                child: CustomScrollView(slivers: <Widget>[
                  SliverList(
                    delegate: new SliverChildBuilderDelegate((ctx, index) {
                      return _itemView(index);
                    }, childCount: _allList.length),
                  )
                ])));
  }

  _itemView(int index) {
    return InkWell(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            height: ScreenUtil().setWidth(136),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(25)), child: ClipOval(child: LoadImage('mr_head', width: ScreenUtil().setWidth(60), height: ScreenUtil().setWidth(60)))),
                Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_allList[index].type == '1' ? '推广收益 +${_allList[index].amount}' : '持币收益 +${_allList[index].amount}'} ${GlobalTransaction.coin}', overflow: TextOverflow.ellipsis, style: TextStyles.textBlack14.copyWith(fontWeight: FontWeight.bold)),
                      Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(16))),
                      Text('${_allList[index].day}', style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24)))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colours.colorEE,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          )
        ],
      ),
      onTap: () {},
    );
  }

  getData() {
    var map = pagingLoad.getMapPagingLoad();
    map['address'] = GlobalTransaction.walletInfo.account_id;
    Net().post(ApiTransaction.REWARD_LOG, map, success: (data) {
      pagingLoad.loading = false;
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        _allList.clear();
        data['list'].forEach((element) {
          _allList.add(RewardLog.fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          _allList.add(RewardLog.fromJson(element));
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
