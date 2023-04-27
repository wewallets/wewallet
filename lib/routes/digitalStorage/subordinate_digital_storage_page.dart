import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/child_list_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/base/base_state.dart';
import '../../common/utils/pagingLoadNow.dart';

class SubordinateDigitalStoragePage extends StatefulWidget {
  final Bundle bundle;

  SubordinateDigitalStoragePage(this.bundle);

  @override
  _SubordinateDigitalStoragePageState createState() => _SubordinateDigitalStoragePageState();
}

class _SubordinateDigitalStoragePageState extends BaseState<SubordinateDigitalStoragePage> {
  RefreshController refreshController = RefreshController();
  PagingLoadNew pagingLoad = PagingLoadNew();
  List<ChildListEntity> allList = [];
  String coupon;
  String childTotal;
  bool isData = true;

  @override
  Widget get appBar => getAppBar('${s.text16}', actions: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          LoadImage('bangd_icon', width: dp(15), height: dp(15)),
          Gaps.hGap5,
          inkButton(
              onPressed: () {
                navigateTo(PageTransactionRouter.binding_digital_storage_page);
              },
              child: Text('${s.text17}', style: TextStyles.textWhite14))
        ]),
        Gaps.hGap15,
      ]);

  @override
  void initState() {
    super.initState();

    getData();
    getInfo();
  }

  @override
  Widget buildContent(BuildContext context) {
    return SmartRefresher(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(dp(12)),
                width: double.infinity,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('assets_bgs')), fit: BoxFit.fill)),
                padding: EdgeInsets.all(dp(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      Text('${childTotal ?? '0.0'}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50))),
                      Expanded(child: Container()),
                      inkButton(
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(text: coupon));
                            Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().fzcg}');
                          },
                          child: Text('${coupon ?? ''}', style: TextStyles.textBlack22.copyWith(fontSize: ScreenUtil().setSp(50)))),
                      LoadAssetImage('icon_am_copy', width: adaptationDp(15), color: Colours.textBlack),
                    ]),
                    Gaps.vGap12,
                    Row(children: [
                      Text('${s.text18}', style: TextStyles.textBlack13),
                      Expanded(child: Container()),
                      Text('${s.text19}', style: TextStyles.textBlack13),
                    ]),
                  ],
                )),
            Padding(padding: EdgeInsets.only(left: dp(12)), child: Text('${s.text20}', style: TextStyles.textWhite13)),
            Gaps.vGap20,
            Expanded(
                child: !pagingLoad.errorNullData
                    ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                    : allList.length == 0
                        ? buildLoadingShadeCustom()
                        : listViewBuilder(
                            itemCount: allList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(left: dp(12), right: dp(12), bottom: dp(12)),
                                  width: double.infinity,
                                  padding: EdgeInsets.only(bottom: dp(12)),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text('${allList[index].nickName ?? allList[index].account.substring(allList[index].account.length - 4, allList[index].account.length)}', style: TextStyles.textWhite14),
                                        Expanded(child: Container()),
                                        Text('${allList[index].account}', style: TextStyles.textWhite12),
                                      ]),
                                      Container(width: double.infinity, height: 0.5, color: Colours.textGrey6, margin: EdgeInsets.only(top: dp(15))),
                                    ],
                                  ));
                            })),
          ],
        ));
  }

  getInfo() {
    Net().post(ApiTransaction.collection_child_info, null, success: (data) {
      coupon = data['coupon'];
      childTotal = data['child_total'];
      setState(() {});
    });
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    pagingLoad.request(
        url: ApiTransaction.collection_child_list,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          allList.clear();
          data.forEach((itemJson) {
            allList.add(ChildListEntity().fromJson(itemJson));
          });
        },
        nextPage: (data) {
          data.forEach((itemJson) {
            allList.add(ChildListEntity().fromJson(itemJson));
          });
        });
  }
}
