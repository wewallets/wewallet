import 'dart:async';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/fund_list_entity.dart';
import 'package:mars/models/marketList.dart';
import 'package:mars/socket/market_web_socket.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

///行情分类
class CrowdFundingClassPage extends StatefulWidget {
  final int type;

  CrowdFundingClassPage(this.type);

  @override
  _CrowdFundingClassPageState createState() => _CrowdFundingClassPageState();
}

class _CrowdFundingClassPageState extends State<CrowdFundingClassPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<FundListEntity> _allList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: widget.type == 0 ? Color(0xFFF3F3F3) : Colours.white,
      body: _loading == false
          ? LayoutUtil.getLoadingShadeCustom()
          : _allList.length == 0
              ? LayoutUtil.buildErrorWidget(errorImage: 'zhanwushuju', imageWidth: ScreenUtil().setWidth(220))
              : Column(
                  children: [
                    Lines.line,
                    Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.only(bottom: adaptationDp(15)),
                            itemBuilder: (BuildContext context, int index) {
                              return inkButton(
                                  onPressed: () {
                                    navigatorTransactionContextPush(context, PageTransactionRouter.crowdfunding_detail_page,
                                        bundle: Bundle()
                                          ..putString('productId', _allList[index].wheelId)
                                          ..putInt('type', widget.type), onValue: (data) {
                                      getData();
                                    });
                                  },
                                  child: buildItem(index));
                            },
                            itemCount: _allList.length))
                  ],
                ),
    );
  }

  buildItem(index) {
    return widget.type == 0
        ? Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(adaptationDp(5)), color: Colours.white),
            margin: EdgeInsets.fromLTRB(adaptationDp(15), adaptationDp(15), adaptationDp(15), adaptationDp(0)),
            padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), top: adaptationDp(10)),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LoadImage('${_allList[index].icon}', width: adaptationDp(25), height: adaptationDp(25)),
                  Gaps.hGap5,
                  Text('${getTitleCrowdFunding(_allList[index])}', style: TextStyles.textBlack15),
                  Expanded(child: Container()),
                  Text('${getString().xtj1}', style: TextStyles.textBlack12),
                  Gaps.hGap5,
                  Text(_allList[index].platformBonusAmount + ' ' + _allList[index].currency.toUpperCase(), style: TextStyles.textBlack12.copyWith(color: getTypeColor(2))),
                ],
              ),
              Gaps.vGap10,
              Lines.line,
              Gaps.vGap10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${_allList[index].str}    ${_allList[index].strTime}', style: TextStyles.textBlack12.copyWith(color: getTypeStrColor(_allList[index].status))),
                  Expanded(child: Container()),
                  Container(
                    decoration: BoxDecoration(color: _allList[index].status == '2' ? Color(0x1A666666) : Color(0x1A3250D4), borderRadius: BorderRadius.circular(adaptationDp(5)), border: Border.all(color: _allList[index].status == '2' ? Color(0xFF666666) : Color(0xFF3250D4), width: 0.5)),
                    padding: EdgeInsets.only(left: adaptationDp(13), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(13)),
                    alignment: Alignment.center,
                    child: Text(widget.type == 1 ? '${getString().zf12}' : '${getString().zf13}', style: TextStyles.textBlack12.copyWith(color: _allList[index].status == '2' ? Color(0xFF666666) : Color(0xFF3250D4))),
                  )
                ],
              ),
              Gaps.vGap15,
            ]))
        : Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(adaptationDp(5)), color: Colours.white),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10), top: adaptationDp(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadImage('${_allList[index].icon}', width: adaptationDp(25), height: adaptationDp(25)),
                      Gaps.hGap5,
                      Text(_allList[index].title, style: TextStyles.textBlack15),
                      Expanded(child: Container()),
                      Text('${getString().xtj1}', style: TextStyles.textBlack12),
                      Gaps.hGap5,
                      Padding(padding: EdgeInsets.only(top: adaptationDp(3)), child: Text(_allList[index].platformBonusAmount + ' ' + _allList[index].currency.toUpperCase(), style: TextStyles.textBlack12.copyWith(color: getTypeColor(2)))),
                      Gaps.hGap5,
                      Container(
                        decoration: BoxDecoration(
                            color: _allList[index].status == '2' || _allList[index].isBuy == '1' ? Color(0x1A666666) : Color(0x1A3250D4),
                            borderRadius: BorderRadius.circular(adaptationDp(5)),
                            border: Border.all(color: _allList[index].status == '2' || _allList[index].isBuy == '1' ? Color(0xFF666666) : Color(0xFF3250D4), width: 0.5)),
                        padding: EdgeInsets.only(left: adaptationDp(13), top: adaptationDp(4), bottom: adaptationDp(4), right: adaptationDp(13)),
                        alignment: Alignment.center,
                        child: Text(_allList[index].isBuy == '1' ? '${getString().xtj16}' : '${getString().zf12}', style: TextStyles.textBlack12.copyWith(color: Color(0xFF3250D4))),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15)),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width,
                  animation: true,
                  lineHeight: adaptationDp(8),
                  barRadius: Radius.circular(adaptationDp(5)),
                  backgroundColor: Color(0xFFEAEAEA),
                  animationDuration: 1000,
                  percent: double.parse((double.parse(_allList[index].totaled) / double.parse(_allList[index].total)).toString()),
                  progressColor: Color(0xFF3250D4),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: adaptationDp(10), right: adaptationDp(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${getString().zf14}', style: TextStyles.textBlack12),
                      Gaps.hGap5,
                      Text('${NumUtil.formatNum((double.parse(_allList[index].totaled) / double.parse(_allList[index].total) * 100).toString(), 4)}%', style: TextStyles.textBlack12.copyWith(color: Color(0xFF3250D4))),
                      Expanded(child: Container()),
                      Text('${getString().zf47} ${_allList[index].zoon_number} ${getString().zf27}', style: TextStyles.textBlack12.copyWith(color: getTypeColor(1))),
                    ],
                  )),
              Gaps.vGap20,
              Lines.line,
              Gaps.vGap10,
            ]));
  }

  getTypeStrColor(type) {
    switch (type) {
      case '-1':
        return Color(0xFF3250D4);
      case '0':
        return Color(0xFFFE3937);
      default:
        return Color(0xFF666666);
    }
  }

  getTypeColor(type) {
    switch (type) {
      case 0:
        return Color(0xFFF6AF46);
      case 1:
        return Color(0xFFFE3937);
      case 2:
        return Color(0xFF3250D4);
      default:
        return Color(0xFFF6AF46);
    }
  }

  getTitleCrowdFunding(data) {
    if (SpUtil.getString('locale') == 'zh') {
      return data.title;
    } else if (SpUtil.getString('locale') == 'en') {
      return data.titleEn;
    } else if (SpUtil.getString('locale') == 'ms') {
      return data.titleMs;
    } else if (SpUtil.getString('locale') == 'th') {
      return data.titleTh;
    } else
      return data.title;
  }

  getData() {
    Net().post(ApiTransaction.fund_list, {'type': widget.type == 1 ? 2 : 0}, success: (data) {
      if (_allList.length != 0)
        _allList.clear();
      else
        _allList = [];
      data.forEach((element) {
        _allList.add(FundListEntity().fromJson(element));
      });

      _loading = true;
      if (mounted) setState(() {});
    }, failure: (error) {
      _loading = true;
      if (mounted) setState(() {});
    });
  }
}
