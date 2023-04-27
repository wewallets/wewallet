import 'package:mars/models/Wallet_address_Log.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:mars/wallet/common/utils/pagingLoad.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransferRecordPage extends StatefulWidget {
  final Bundle bundle;

  TransferRecordPage(this.bundle);

  @override
  _TransferRecordPageState createState() => _TransferRecordPageState();
}

class _TransferRecordPageState extends BaseState<TransferRecordPage> with TickerProviderStateMixin {
  PagingLoad pagingLoad = PagingLoad();
  RefreshController refreshController = RefreshController();

  TabController controller;
  String coinType = '0';
  List<WalletAddressLog> list = [];

  @override
  Widget get appBar => getAppBar('${widget.bundle.getString('coin')}', actions: []);

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 4);

    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: dp(110)),
            child: Column(children: [
              Container(
                width: double.infinity,
                color: Colours().white,
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(22)),
                height: ScreenUtil().setWidth(60),
                child: TabBar(
                  unselectedLabelColor: Colours().textGrey,
                  unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(28)),
                  labelColor: Colours().themeColor,
                  labelStyle: TextStyle(fontSize: ScreenUtil().setSp(28)),
                  controller: controller,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.only(left: dp(20), right: dp(20)),
                  indicatorColor: Colours().themeColor,
                  onTap: (index) {
                    if (index == 0) coinType = '1';
                    if (index == 1) coinType = '2';
                    if (index == 2) coinType = '3';
                    if (index == 4) coinType = '4';

                    getData(isRefresh: true);
                  },
                  tabs: <Widget>[Text('全部'), Text('转出'), Text('转入'), Text('失败')],
                ),
              ),
              Expanded(
                  child: SmartRefresher(
                      controller: refreshController,
                      enablePullUp: false,
                      enablePullDown: true,
                      onRefresh: () {
                        getData(isRefresh: true);
                      },
                      onLoading: () {
                        getData();
                      },
                      child: !pagingLoad.errorNullData
                          ? buildErrorWidget()
                          : list.length == 0
                              ? buildLoadingShadeCustom()
                              : listViewBuilder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return getItem(index);
                                  }))),
            ])),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colours().white, borderRadius: BorderRadius.all(Radius.circular(dp(0))), border: Border.all(width: 0.5, color: Color(0xFFF5F0F5))),
            height: dp(110),
            child: Row(
              children: [
                Gaps.hGap15,
                Expanded(
                    child: inkButton(
                        onPressed: () {
                          navigateTo(PageWalletRouter.collect_money_page);
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(6))), border: Border.all(width: 0.5, color: Color(0xFFF5F0F5))),
                          padding: EdgeInsets.only(top: dp(15), bottom: dp(15)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadImage('zj_sk', width: dp(20)),
                              Text('收款', style: TextStyles().textBlack15),
                            ],
                          ),
                        ))),
                Gaps.hGap15,
                Expanded(
                    child: inkButton(
                  onPressed: () {
                    navigateTo(PageWalletRouter.transfer_page, bundle: Bundle()..putString('coin', widget.bundle.getString('coin')));
                  },
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(6))), border: Border.all(width: 0.5, color: Color(0xFFF5F0F5))),
                      padding: EdgeInsets.only(top: dp(15), bottom: dp(15)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadImage('zj_zz', width: dp(20)),
                          Text('转账', style: TextStyles().textBlack15),
                        ],
                      )),
                )),
                Gaps.hGap15,
              ],
            ),
          ),
        )
      ],
    );
  }

  getItem(index) {
    return inkButton(
        onPressed: () {},
        child: Container(
          margin: EdgeInsets.only(left: dp(15), right: dp(15), bottom: dp(15)),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
          padding: EdgeInsets.all(dp(15)),
          child: Column(
            children: [
              Row(children: [
                Text('${list[index].time}', style: TextStyles().textGrey12),
                Expanded(child: Container()),
                Text('${list[index].status}', style: TextStyles().textGrey13.copyWith(color: Color(0xFF2FB93B))),
              ]),
              Gaps.vGap15,
              Lines().line,
              Gaps.vGap15,
              Row(children: [
                LoadImage(list[index].to == Global.userWallet.wallet.address ? 'zc_zr' : 'zc_zc', width: dp(20), height: dp(20)),
                Gaps.hGap10,
                Text('${list[index].to}', style: TextStyles().textBlack12),
                Expanded(child: Container()),
                Text('${list[index].amount}', style: TextStyles().textGrey13),
              ]),
            ],
          ),
        ));
  }

  getData({isRefresh = false}) {
    Map<String, dynamic> map = Map();
    map['currency'] = widget.bundle.getString('coin');


  }
}
