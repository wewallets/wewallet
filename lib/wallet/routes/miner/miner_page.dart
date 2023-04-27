import 'package:flutter/services.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:mars/wallet/common/global.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/global.dart';
import '../../../common/http/api.dart';
import '../../../common/utils/pagingLoad.dart';
import '../../../models/poolunder_entity.dart';

class MinerPage extends StatefulWidget {
  final Bundle bundle;

  MinerPage(this.bundle);

  @override
  _MinerPageState createState() => _MinerPageState();
}

class _MinerPageState extends BaseState<MinerPage> {
  RefreshController refreshController = RefreshController();
  List<PoolunderEntity> minersList = new List();
  TextEditingController nameController = TextEditingController();
  PagingLoad pagingLoad = PagingLoad();
  String minerCount = '0';

  @override
  Widget get appBar => getAppBar('矿工', actions: [
        inkButton(
            onPressed: () {
              navigateTo(PageWalletRouter.bind_superior_page);
            },
            child: Text('绑定上级', style: TextStyles().textBlack14)),
        Gaps.hGap15,
      ]);

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  void initState() {
    super.initState();
    if (Global.coupon == null)
      Future.delayed(Duration(milliseconds: 0), () async {
        getCoupon();
      });

    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.all(dp(18)),
          width: double.infinity,
          height: dp(100),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('dqzy_bg')), fit: BoxFit.fill)),
          child: Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('矿工总量', style: TextStyles().textWhite14),
                Gaps.vGap8,
                Text('$minerCount', style: TextStyles().textWhite23),
              ]),
              Expanded(child: Container()),
              inkButton(
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: Global.coupon));
                    showToast('复制成功');
                  },
                  child: Text('我的推荐码：${Global.coupon ?? ''}', style: TextStyles().textWhite14)),
            ],
          )),
      minerCount == '0'
          ? Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(padding: EdgeInsets.only(top: dp(20), left: dp(15)), child: Text('矿工列表', style: TextStyles().textGrey14)),
              Container(margin: EdgeInsets.only(top: dp(62)), alignment: Alignment.center, child: LoadImage('kg_error', width: dp(127), height: dp(84))),
              Expanded(child: Container()),
              Buttons.getDetermineButton(buttonText: '邀请矿工', margin: EdgeInsets.all(dp(15)), onPressed: () {}),
              Gaps.vGap40,
            ]))
          : Expanded(
              child: SmartRefresher(
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
                  child: ListView.builder(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(18), right: ScreenUtil().setWidth(18)),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildItem(index);
                      },
                      itemCount: minersList.length))),
    ]);
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
              Padding(padding: EdgeInsets.only(left: dp(15)), child: Text('${minersList[index].nickName ?? '${minersList[index].address.substring(0, 4)}'}', style: TextStyles().textBlack18)),
              Gaps.hGap15,
              Text('${minersList[index].address ?? ''}', style: TextStyles().textBlack10),
            ],
          ),
          Gaps.vGap10,
          Lines().line,
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
                  Text('${GlobalTransaction.coin} ', style: TextStyles().textGrey10),
                  Text('${minersList[index].assets_THC ?? '0.0'}', style: TextStyles().textGrey610),
                  Expanded(child: Container()),
                  Text(' ${getString().kgrd} ', style: TextStyles().textGrey10),
                  Text('${minersList[index].team_money ?? '0.0'}', style: TextStyles().textGrey610),
                  Gaps.hGap15,
                ],
              )),
          Gaps.vGap10,
        ],
      ),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(12)),
    );
  }

  getCoupon() {
    showLoadingDialog();

  }

  getData() {
    var map = pagingLoad.getMapPagingLoad();
    map['currency'] = GlobalTransaction.coin;

    Net().post(ApiTransaction.MINER_LIST, map, success: (data) {
      pagingLoad.loading = false;
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        minerCount = data['page']['totalCount'].toString();
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        minersList.clear();
        data['list'].forEach((element) {
          minersList.add(PoolunderEntity().fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          minersList.add(PoolunderEntity().fromJson(element));
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
