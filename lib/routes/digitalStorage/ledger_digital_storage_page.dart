import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/pagingLoadNow.dart';
import 'package:mars/models/fund_assets_log_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/base/base_state.dart';
import '../../common/utils/dateUtil.dart';

class LedgerDigitalStoragePage extends StatefulWidget {
  final Bundle bundle;

  LedgerDigitalStoragePage(this.bundle);

  @override
  _LedgerDigitalStoragePageState createState() => _LedgerDigitalStoragePageState();
}

class _LedgerDigitalStoragePageState extends BaseState<LedgerDigitalStoragePage> {
  RefreshController refreshController = RefreshController();
  List<FundAssetsLogEntity> _allList = [];
  PagingLoadNew pagingLoad = PagingLoadNew();
  int type;
  String coin = 'USDT';

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null) {
      coin = widget.bundle.getString('coin');
    }
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget get appBar => getAppBar('${s.zbb}', actions: <Widget>[
        inkButton(
          onPressed: () {
            showSelect();
          },
          child: Text('$coin', style: TextStyles.textWhite14),
        ),
        Gaps.hGap15,
      ]);

  @override
  Widget buildContent(BuildContext context) {
    return !pagingLoad.errorNullData
        ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
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
            child: !pagingLoad.errorNullData
                ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
                : _allList.length == 0
                    ? buildLoadingShadeCustom()
                    : listViewBuilder(itemCount: _allList.length, itemBuilder: (context, index) => _itemView(index)));
  }

  _itemView(int index) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          height: ScreenUtil().setWidth(136),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_allList[index].logStr}', overflow: TextOverflow.ellipsis, style: TextStyles.textWhite14.copyWith(fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(16))),
                    Text(DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(_allList[index].createTime) * 1000).toString()), style: TextStyle(color: Colours.textGrey6, fontSize: ScreenUtil().setSp(24)))
                  ],
                ),
              ),
              Text('${_allList[index].amount.contains('-') ? '' : '+'}${_allList[index].amount}', overflow: TextOverflow.ellipsis, style: TextStyles.textWhite14.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          color: Colours.textGrey6,
          height: ScreenUtil().setWidth(1),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        )
      ],
    );
  }

  showSelect() {
    List<String> list = [];
    for (int i = 0; i < GlobalTransaction.digitalStorageAssetsList.length; i++) list.add(GlobalTransaction.digitalStorageAssetsList[i].netCurrencyName);

    Pickers.showSinglePicker(context, data: list, selectData: coin, pickerStyle: RaisedPickerStyle.dark(), onConfirm: (p) {
      coin = p;
      setState(() {});
      getData(isFirstPage: true);
    });
  }

  getData({isFirstPage = false}) {
    Map<String, dynamic> map = Map();
    map['currency'] = coin;
    pagingLoad.request(
        url: ApiTransaction.collection_assets_log,
        params: map,
        isFirstPage: isFirstPage,
        refreshController: refreshController,
        setState: setState,
        mounted: mounted,
        firstPage: (data) {
          _allList.clear();
          data.forEach((itemJson) {
            _allList.add(FundAssetsLogEntity().fromJson(itemJson));
          });
        },
        nextPage: (data) {
          data.forEach((itemJson) {
            _allList.add(FundAssetsLogEntity().fromJson(itemJson));
          });
        });
  }
}
