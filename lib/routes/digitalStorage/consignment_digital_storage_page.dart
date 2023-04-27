import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/get_by_account_entity.dart';
import 'package:mars/models/order_hang_list_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/base/base_state.dart';
import '../../common/utils/pagingLoadNow.dart';

class ConsignmentDigitalStoragePage extends StatefulWidget {
  @override
  _ConsignmentDigitalStoragePageState createState() => _ConsignmentDigitalStoragePageState();
}

class _ConsignmentDigitalStoragePageState extends BaseState<ConsignmentDigitalStoragePage> {
  @override
  Widget get appBar => getAppBar('${s.text12}');

  RefreshController refreshController = RefreshController();
  List<OrderHangListEntity> allList = [];
  PagingLoadNew pagingLoad = PagingLoadNew();
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return !pagingLoad.errorNullData
        ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
        : allList.length == 0
            ? buildLoadingShadeCustom()
            : SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () {
                  getData(isFirstPage: true);
                },
                onLoading: () {
                  getData();
                },
                child: listViewBuilder(itemCount: allList.length, itemBuilder: (context, index) => _itemView(index)));
  }

  _itemView(index) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: dp(12), left: dp(12), right: dp(12)),
        height: dp(170),
        padding: EdgeInsets.only(top: dp(12)),
        child: Stack(
          children: [
            LoadImage('${allList[index].productUrl}', height: double.infinity, width: double.infinity, fit: BoxFit.fill),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: EdgeInsets.only(top: dp(90.5), right: dp(12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${s.text15}', style: TextStyles.textBlack13),
                        Gaps.hGap5,
                        Text('${allList[index].keepDays}', style: TextStyles.textBlack20),
                      ],
                    ))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gaps.vGap12,
                        Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${allList[index].hangAmount}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50)))),
                        Gaps.vGap12,
                        Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${s.text53}(${allList[index].payCurrency})', style: TextStyles.textBlack13)),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Gaps.vGap12,
                        Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${allList[index].payAmount}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50)))),
                        Gaps.vGap12,
                        Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${s.text54}(${allList[index].payCurrency})', style: TextStyles.textBlack13)),
                      ],
                    ),
                    Gaps.hGap12,
                  ],
                ),
                inkButton(
                  onPressed: () {
                    currentIndex = index;
                    setState(() {});
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: dp(12), top: dp(12)),
                      width: dp(83),
                      height: dp(31),
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill), borderRadius: BorderRadius.circular(dp(10))),
                      alignment: Alignment.center,
                      child: Text('${s.goumai}', style: TextStyles.textWhite14)),
                ),
                Expanded(child: Container()),
                currentIndex == index
                    ? Row(children: [
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(color: Color(0xFF242140), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(dp(10)))),
                                height: dp(38.5),
                                child: inkButton(
                                    onPressed: () {
                                      currentIndex = -1;
                                      setState(() {});
                                    },
                                    child: Text('${s.qx}', style: TextStyles.textWhite14)))),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('open_button')), fit: BoxFit.fill)),
                                height: dp(38.5),
                                child: inkButton(
                                    onPressed: () {
                                      buy(allList[index].orderId);
                                    },
                                    child: Text('${s.zf21}\n(${allList[index].hangAmount}${allList[index].payCurrency})', style: TextStyles.textWhite12)))),
                      ])
                    : Container(),
              ],
            ),
          ],
        ));
  }

  buy(id) {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.collection_order_hang_pay, {'order_id': id}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('${getString().zfcgclz}');
      getData(isFirstPage: true);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }

  getData({isFirstPage = false}) {
    if (isFirstPage) {
      currentIndex = -1;
    }
    Map<String, dynamic> map = Map();
    // map['type'] = widget.bundle.getString('product_id');
    pagingLoad.request(
        url: ApiTransaction.collection_order_hang_list,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          allList.clear();
          data.forEach((itemJson) {
            allList.add(OrderHangListEntity().fromJson(itemJson));
          });
        },
        nextPage: (data) {
          data.forEach((itemJson) {
            allList.add(OrderHangListEntity().fromJson(itemJson));
          });
        });
  }
}
