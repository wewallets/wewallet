import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mars/models/miner_list_entity.dart';

class OreMyTeamPage extends StatefulWidget {
  final Bundle bundle;

  OreMyTeamPage(this.bundle);

  @override
  _OreMyTeamPageState createState() => _OreMyTeamPageState();
}

class _OreMyTeamPageState extends State<OreMyTeamPage> {
  RefreshController refreshController = RefreshController();
  PagingLoad pagingLoad = PagingLoad();
  List<MinerListEntity> minerList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LayoutUtil.getAppBar(context, '我的矿工'),
        body: SmartRefresher(
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
            child: ListView(
              padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), top: adaptationDp(25)),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container(child: Text('地址', style: TextStyles.textBlack15.copyWith(color: Color(0xFFA7855B))))),
                    Expanded(child: Container(child: Text('个人矿池', style: TextStyles.textBlack15.copyWith(color: Color(0xFFA7855B))))),
                    Expanded(child: Container(child: Text('矿工矿池', style: TextStyles.textBlack15.copyWith(color: Color(0xFFA7855B))))),
                    Expanded(child: Container(alignment: Alignment.centerRight, child: Text('本期产量', style: TextStyles.textBlack15.copyWith(color: Color(0xFFA7855B))))),
                  ],
                ),
                Gaps.vGap10,
                Container(color: Color(0xFFEEEEEE), height: 0.5, width: double.infinity, margin: EdgeInsets.only(top: adaptationDp(15))),
                minerList.length == 0
                    ? LayoutUtil.buildErrorWidget(topHeight: 100)
                    : listViewBuilder(
                        isSlide: true,
                        itemCount: minerList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.only(top: adaptationDp(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Container(child: Text('${minerList[index].address}', style: TextStyles.textBlack10))),
                                  Expanded(child: Container(child: Text('${minerList[index].investmentCurrent}', style: TextStyles.textBlack15))),
                                  Expanded(child: Container(child: Text('${minerList[index].balanceTotal}', style: TextStyles.textBlack15))),
                                  Expanded(child: Container(alignment: Alignment.centerRight, child: Text('${minerList[index].revenueCurrent}', style: TextStyles.textBlack15))),
                                ],
                              ));
                        })
              ],
            )));
  }

  getData() {
    var map = pagingLoad.getMapPagingLoad();
    map['product_id'] = widget.bundle.getString('id');
    Net().post(ApiTransaction.POOL_MINER_LIST, map, success: (data) {
      pagingLoad.loading = false;
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        minerList.clear();
        data['list'].forEach((element) {
          minerList.add(MinerListEntity().fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          minerList.add(MinerListEntity().fromJson(element));
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
