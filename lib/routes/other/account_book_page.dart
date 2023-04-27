import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/common/utils/pagingLoad.dart';
import 'package:mars/models/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 账本列表
 */
class AccountBookPage extends StatefulWidget {
  final Bundle bundle;

  AccountBookPage(this.bundle);

  @override
  State<StatefulWidget> createState() => _AccountBookState();
}

class _AccountBookState extends State<AccountBookPage> {
  RefreshController refreshController = RefreshController();
  List<UserLedger> _allList = [];
  PagingLoad pagingLoad = PagingLoad();
  int type;
  String selectType = '全部';

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null) {
      type = widget.bundle.getInt('type');
      selectType = '矿池';
    }
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
        appBar: LayoutUtil.getAppBar(
          context, '${getString().zbb}',
          // actions: [
          // InkResponse(
          //   child: Container(alignment: Alignment.center, padding: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)), child: Text('$selectType', style: TextStyles.text7854D528)),
          //   onTap: () {
          //     showSelect();
          //   },
          // )
          // ]
        ),
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
            ])
        ));
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
                ClipOval(child: LoadImage('${_allList[index].icon}', width: ScreenUtil().setWidth(60), height: ScreenUtil().setWidth(60))),
                Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_allList[index].description}', overflow: TextOverflow.ellipsis, style: TextStyles.textBlack14.copyWith(fontWeight: FontWeight.bold)),
                      Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(16))),
                      Text(
                          _allList[index].validated == '1'
                              ? _allList[index].tx_time == null
                              ? ''
                              : DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(_allList[index].tx_time) * 1000).toString(), format: 'yyyy-MM-dd HH:mm:ss')
                              : '${_allList[index].state_str != null ? _allList[index].state_str : (_allList[index].tx_time == null ? '' : DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(_allList[index].tx_time) * 1000).toString(), format: 'yyyy-MM-dd HH:mm:ss'))}',
                          style: TextStyle(color: Colours.colorFF97A2AF, fontSize: ScreenUtil().setSp(24)))
                    ],
                  ),
                ),
                _allList[index].is_detail == '1' ? LoadImage('icon_goto', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(24)) : Container()
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
      onTap: () {
        if (_allList[index].is_detail == '1') Navigator.pushNamed(context, PageTransactionRouter.account_book_info_page, arguments: Bundle()..putObject('ledgerInfo', _allList[index]));
      },
    );
  }

  showSelect() {
    Pickers.showSinglePicker(context, data: ['全部', '矿池', '转入', '转出', '激活', '交易手续费', '充币', '提币'], selectData: selectType, pickerStyle: ClosePickerStyle(), onConfirm: (p) {
      selectType = p;
      _allList.clear();
      setState(() {});
      pagingLoad.reset();
      getData();
    });
  }

  getData() {
    var map = pagingLoad.getMapPagingLoad();
    switch (selectType) {
      case '全部':
        break;
      case '矿池':
        map['type'] = '1';
        break;
      case '转入':
        map['type'] = '2';
        break;
      case '转出':
        map['type'] = '3';
        break;
      case '激活':
        map['type'] = '4';
        break;
      case '交易手续费':
        map['type'] = '5';
        break;
      case '充币':
        map['type'] = '6';
        break;
      case '提币':
        map['type'] = '7';
        break;
    }

    Net().post(ApiTransaction.USDER_LEDGER, map, success: (data) {
      pagingLoad.loading = false;
      if (pagingLoad.isCurrPage() && data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        _allList.clear();
        data['list'].forEach((element) {
          _allList.add(UserLedger.fromJson(element));
        });
      } else if (data['list'] != null && data['list'].length != 0) {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        data['list'].forEach((element) {
          _allList.add(UserLedger.fromJson(element));
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
