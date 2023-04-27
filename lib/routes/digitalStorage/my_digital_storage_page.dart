import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/get_by_account_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/base/base_state.dart';
import '../../common/utils/pagingLoadNow.dart';
import '../../models/userLedger.dart';
import '../../widgets/dialog/consignment_cancel_dialog.dart';
import '../../widgets/dialog/consignment_create_dialog.dart';

class MyDigitalStoragePage extends StatefulWidget {
  final Bundle bundle;

  MyDigitalStoragePage(this.bundle);

  @override
  _MyDigitalStoragePageState createState() => _MyDigitalStoragePageState();
}

class _MyDigitalStoragePageState extends BaseState<MyDigitalStoragePage> {
  @override
  Widget get appBar => getAppBar('${s.text2}');
  RefreshController refreshController = RefreshController();
  List<GetByAccountEntity> allList = [];
  PagingLoadNew pagingLoad = PagingLoadNew();

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
        height: dp(211),
        padding: EdgeInsets.only(top: dp(12)),
        child: Stack(
          children: [
            LoadImage('${allList[index].productUrl}', height: double.infinity, width: double.infinity, fit: BoxFit.fill),
            // Align(
            //     alignment: Alignment.topRight,
            //     child: Padding(
            //         padding: EdgeInsets.only(top: dp(85.5), right: dp(12)),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text('${s.text15}', style: TextStyles.textBlack13),
            //             Gaps.hGap5,
            //             Text('${allList[index].keepDays}', style: TextStyles.textBlack20),
            //           ],
            //         ))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gaps.vGap12,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gaps.hGap12,
                    Text('${s.text15}', style: TextStyles.textBlack13),
                    Gaps.hGap5,
                    Text('${allList[index].keepDays}', style: TextStyles.textBlack20),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${allList[index].payAmount}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50)))),
                Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${s.text11}(${allList[index].payCurrency})', style: TextStyles.textBlack13)),
                Container(width: double.infinity, height: 0.5, color: Colours.white, margin: EdgeInsets.only(top: dp(12), bottom: dp(12))),
                Row(children: [
                  Gaps.hGap12,
                  allList[index].income.length < 1 ? Container() : Text('${allList[index].income[0].income} ${allList[index].income[0].currency}', style: TextStyles.textBlack20),
                  Expanded(child: Container()),
                  allList[index].income.length < 2 ? Container() : Text('${allList[index].income[1].income} ${allList[index].income[1].currency}', style: TextStyles.textBlack20),
                  Gaps.hGap12,
                ]),
                Container(width: double.infinity, height: 0.5, color: Colours.white, margin: EdgeInsets.only(top: dp(12))),
                Row(
                  children: [
                    inkButton(
                      onPressed: () {
                        if (allList[index].type == '1') {
                          cancel(index);
                        } else if (allList[index].type == '0') {
                          create(index);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: dp(12), top: dp(12)),
                          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                          height: dp(31),
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill), borderRadius: BorderRadius.circular(dp(10))),
                          alignment: Alignment.center,
                          child: Text('${getStatusStr(allList[index].type)}', style: TextStyles.textWhite14)),
                    ),
                    // allList[index].buyBack == '1' 暂时隐藏回购功能
                    //     ? inkButton(
                    //         onPressed: () {
                    //           buy(index);
                    //         },
                    //         child: Container(
                    //             margin: EdgeInsets.only(left: dp(12), top: dp(12)),
                    //             padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                    //             height: dp(31),
                    //             decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill), borderRadius: BorderRadius.circular(dp(10))),
                    //             alignment: Alignment.center,
                    //             child: Text('回购', style: TextStyles.textWhite14)),
                    //       )
                    //     : Container(),
                    Expanded(child: Container()),
                    allList[index].type == '1'
                        ? Container(
                            margin: EdgeInsets.only(left: dp(12), top: dp(12)),
                            padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                            height: dp(31),
                            decoration: BoxDecoration(border: Border.all(color: Colours.textBlack, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.center,
                            child: Text('${s.text55}', style: TextStyles.textBlack14))
                        : Container(),
                    Gaps.hGap12,
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  getStatusStr(type) {
    if (type == '0') {
      return '${s.text12}';
    } else if (type == '1') {
      return '${s.text56}';
    } else if (type == '2') {
      return '${s.text57}';
    }
  }

  buy(index) {
    showDialog(
        context: context,
        builder: (_) => ConsignmentCancelDialog('回购', '您确定要回购吗？\n', () {
              LayoutUtil.showLoadingDialog(context);
              Net().post(ApiTransaction.collection_order_buy_back, {'order_id': allList[index].orderId}, success: (data) {
                LayoutUtil.closeLoadingDialog(context);
                showToast('回购成功');
                getData(isFirstPage: true);
              }, failure: (error) {
                LayoutUtil.closeLoadingDialog(context);
                showToast('$error');
              });
            }));
  }

  cancel(index) {
    showDialog(
        context: context,
        builder: (_) => ConsignmentCancelDialog('${s.text56}', '${s.text58} ${allList[index].payAmount}${allList[index].payCurrency} ${s.text59}', () {
              LayoutUtil.showLoadingDialog(context);
              Net().post(ApiTransaction.collection_order_hang_cancel, {'order_id': allList[index].orderId}, success: (data) {
                LayoutUtil.closeLoadingDialog(context);
                showToast('${s.text60}');
                getData(isFirstPage: true);
              }, failure: (error) {
                LayoutUtil.closeLoadingDialog(context);
                showToast('$error');
              });
            }));
  }

  create(index) {
    showDialog(
        context: context,
        builder: (_) => ConsignmentCreateDialog((amount) {
              LayoutUtil.showLoadingDialog(context);
              Net().post(ApiTransaction.collection_order_hang_create, {'order_id': allList[index].orderId, 'hang_amount': amount}, success: (data) {
                LayoutUtil.closeLoadingDialog(context);
                showToast('${s.text61}');
                getData(isFirstPage: true);
              }, failure: (error) {
                LayoutUtil.closeLoadingDialog(context);
                showToast('$error');
              });
            }));
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    // map['type'] = widget.bundle.getString('product_id');
    pagingLoad.request(
        url: ApiTransaction.collection_get_by_account,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          allList.clear();
          data.forEach((itemJson) {
            allList.add(GetByAccountEntity().fromJson(itemJson));
          });
        },
        nextPage: (data) {
          data.forEach((itemJson) {
            allList.add(GetByAccountEntity().fromJson(itemJson));
          });
        });
  }
}
