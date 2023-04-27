import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:mars/models/index.dart';
import 'package:mars/models/poolunder_entity.dart';
import 'package:mars/models/swap_miner_list_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//矿工列表
class SwapListOfMinersPage extends StatefulWidget {
  @override
  _SwapListOfMinersPageState createState() => _SwapListOfMinersPageState();
}

class _SwapListOfMinersPageState extends State<SwapListOfMinersPage> {
  RefreshController refreshController = RefreshController();
  List<SwapMinerListEntity> minersList = new List();
  PagingLoad pagingLoad = PagingLoad();
  var poolInfo;

  @override
  void initState() {
    super.initState();
    getData();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(
          context, '${getString().kuanggonglieb}',
//             actions: <Widget>[
//           InkResponse(
//             child: Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.only(right: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(30)),
//                 child: Row(children: [
//                   Text('${Global.coin}', style: TextStyles.text7854D528.copyWith(color: Colours.themeColor)),
//                   // Gaps.hGap5,
//                   // LoadImage('xiajiantou', width: ScreenUtil().setWidth(20)),
//                 ])),
//             onTap: () {
// //               showModalBottomSheet(
// //                   context: context,
// //                   isScrollControlled: true,
// //                   backgroundColor: Colors.transparent,
// //                   builder: (context) {
// // //                  return AddressSortPanel(0);
// //                     return SwitchCurrencyPanel();
// //                   });
//             },
//           )
//         ]
        ),
        body: poolInfo == null
            ? buildLoadingShadeCustom(top: dp(200))
            : SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () {
                  pagingLoad.reset();
                  getList();
                },
                onLoading: () {
                  getList();
                },
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('lasdtb')), fit: BoxFit.fill)),
                      padding: EdgeInsets.only(),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(64), bottom: ScreenUtil().setWidth(70)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${poolInfo['totle_miner']}', style: TextStyles.textWhite25.copyWith(fontWeight: FontWeight.bold)),
                                      Gaps.vGap20,
                                      Text('${getString().text95}', style: TextStyles.textWhite14),
                                      Gaps.vGap15,
                                      Text('${getString().text96}:M${poolInfo['level']}', style: TextStyles.textWhite14),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(height: ScreenUtil().setWidth(20), color: Color(0xFFF5F5F5)),
                    Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(36)),
                        child: Text('${getString().wodekujanggonglieb}', style: TextStyle(color: Color(0xFF3C3224), fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(28)))),
                    minersList.length == 0 || pagingLoad.loading
                        ? pagingLoad.loading
                            ? LayoutUtil.getLoadingShadeCustom()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Gaps.vGap50,
                                  Gaps.vGap25,
                                  LoadImage('kglb_kong', width: ScreenUtil().setWidth(378)),
                                  Gaps.vGap50,
                                  Padding(
                                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(145), right: ScreenUtil().setWidth(145)),
                                      child: Buttons.getDetermineButton(
                                          isUse: true,
                                          buttonText: '${getString().yaoiqingzhifu}',
                                          voidCallback: () {
                                            Navigator.pushNamed(context, PageTransactionRouter.share_page);
                                          })),
                                ],
                              )
                        : ListView.builder(
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(18), right: ScreenUtil().setWidth(18)),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildItem(index);
                            },
                            itemCount: minersList.length),
                  ],
                ),
              ));
  }

  Widget buildItem(int index) {
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(35), bottom: ScreenUtil().setWidth(25)),
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('assets_item_bg')), fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: adaptationDp(15)), child: Text('${minersList[index].nickName ?? '${minersList[index].account.substring(0, 4)}'}', style: TextStyles.textBlack18)),
              Gaps.hGap15,
              Text('${minersList[index].account ?? ''}', style: TextStyles.textBlack10),
            ],
          ),
          Gaps.vGap10,
          Lines.line,
          Gaps.vGap10,
          InkWell(
              onTap: () {
                // Clipboard.setData(new ClipboardData(text: minersList[index].address));
                // Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.hGap15,
                  Text('${s.text97} ', style: TextStyles.textGrey10),
                  Text('${minersList[index].userPledgeUsdt ?? '0.0'}(USDT)', style: TextStyles.textGrey610),
                  Expanded(child: Container()),
                  Text(' ${s.text98} ', style: TextStyles.textGrey10),
                  Text('${minersList[index].teamPledgeUsdt ?? '0.0'}(USDT)', style: TextStyles.textGrey610),
                  Gaps.hGap15,
                  // Gaps.hGap5,
                  // LoadImage('icon_ab_copy', width: ScreenUtil().setWidth(22)),
                ],
              )),
          Gaps.vGap10,
          // Expanded(child: Container()),
          // Container(
          //     decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('kuangongleibbg')), fit: BoxFit.fill)),
          //     padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
          //     height: ScreenUtil().setWidth(116),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text('累计收益', style: TextStyles.textGrey12.copyWith(color: Color(0x99FFFFFF))),
          //             Gaps.vGap5,
          //             Text('${minersList[index].totle_income}', style: TextStyles.textWhite14),
          //           ],
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text('持币算力', style: TextStyles.textGrey12.copyWith(color: Color(0x99FFFFFF))),
          //             Gaps.vGap5,
          //             Text('${minersList[index].coin_power}', style: TextStyles.textWhite14),
          //           ],
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text('推广算力', style: TextStyles.textGrey12.copyWith(color: Color(0x99FFFFFF))),
          //             Gaps.vGap5,
          //             Text('${minersList[index].genera_power}', style: TextStyles.textWhite14),
          //           ],
          //         ),
          //       ],
          //     ))
        ],
      ),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(12)),
    );
  }

  getData() {
    Net().post(ApiTransaction.swap_pool_info, null, success: (data) {
      poolInfo = data;
      setState(() {});
    });
  }

  getList() {
    var map = pagingLoad.getMapPagingLoad();
    map['currency'] = GlobalTransaction.coin;
    map['account'] = GlobalTransaction.walletInfo.account_id;
    Net().post(ApiTransaction.swap_miner_list, map, success: (data) {
      pagingLoad.loading = false;
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        minersList.clear();
        data['list'].forEach((element) {
          minersList.add(SwapMinerListEntity().fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          minersList.add(SwapMinerListEntity().fromJson(element));
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
