import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/fund_detail_entity.dart';
import 'package:mars/widgets/dialog/input_address_dialog.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';

import '../../models/product_detail_entity.dart';
import '../../models/wheel_detail_entity.dart';

//众筹详情
class CrowdFundingBuyDetailPage extends StatefulWidget {
  final Bundle bundle;

  CrowdFundingBuyDetailPage(this.bundle);

  @override
  _CrowdFundingDetailState createState() => _CrowdFundingDetailState();
}

class _CrowdFundingDetailState extends State<CrowdFundingBuyDetailPage> {
  ProductDetailEntity fundDetailEntity;

  TextEditingController numberController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fundDetailEntity = widget.bundle.getObject('productDetailEntity');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().zf15}'),
      body: fundDetailEntity == null
          ? LayoutUtil.getLoadingShadeCustom()
          : ListView(children: [
              Container(
                  padding: EdgeInsets.all(adaptationDp(15)),
                  child: Row(
                    children: [
                      LoadImage('${fundDetailEntity.icon}', width: adaptationDp(50)),
                      Gaps.hGap10,
                      Text('${getTitleCrowdFunding(fundDetailEntity).toUpperCase()}', style: TextStyles.textBlack18),
                      Expanded(child: Container()),
                    ],
                  )),
              Container(width: double.infinity, height: adaptationDp(10), color: Color(0xFFF3F3F3)),
              Gaps.vGap5,
              Padding(
                  padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(10)),
                  child: Row(
                    children: [
                      Text('${getString().xtj3}：', style: TextStyles.textGrey612),
                      Text('${getString().zf55}${fundDetailEntity.number}${getString().zf56}', style: TextStyles.textBlack12.copyWith(color: Color(0xFF3250D4))),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(10)),
                  child: Row(
                    children: [
                      Text('${getString().zf17}：', style: TextStyles.textGrey612),
                      Text('${fundDetailEntity.total} ${fundDetailEntity.currency.toUpperCase()}', style: TextStyles.textGrey612),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(10)),
                  child: Row(
                    children: [
                      Text('${getString().zf18}：', style: TextStyles.textGrey612),
                      Text('${fundDetailEntity.payMin}～${fundDetailEntity.payMax} ${fundDetailEntity.currency.toUpperCase()}', style: TextStyles.textGrey612),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: adaptationDp(15), bottom: adaptationDp(10)),
                  child: Row(
                    children: [
                      Text('${getString().zf19}：', style: TextStyles.textGrey612),
                      Text('${fundDetailEntity.totaled} ${fundDetailEntity.currency.toUpperCase()}', style: TextStyles.textGrey612),
                    ],
                  )),
              fundDetailEntity.status == '0' ? buildCrowdFunding() : Container(),
            ]),
    );
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

  buildCrowdFunding() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(width: double.infinity, height: adaptationDp(10), color: Color(0xFFF3F3F3)),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('认筹', style: TextStyles.textBlack15)),
      Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(70)),
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          decoration: BoxDecoration(
            color: Colours.FFF2F1F8,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(width: 0.5, color: Color(0xFFD9D5DC)),
          ),
          height: ScreenUtil().setWidth(80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                      child: TextField(
                        controller: numberController,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().zf20}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      ))),
              Text('${fundDetailEntity.currency.toUpperCase()}', style: TextStyles.textBlack12.copyWith(color: Color(0xFF3250D4))),
            ],
          )),
      Gaps.vGap50,
      Padding(
          padding: EdgeInsets.only(left: adaptationDp(20), right: adaptationDp(20)),
          child: Buttons.getDetermineButton(
              isUse: fundDetailEntity.isBuy == '1' ? false : true,
              color: Color(0xFF3250D4),
              borderRadius: 10,
              buttonText: fundDetailEntity.isBuy == '1' ? '${getString().xtj16}' : '${getString().xtj2}',
              voidCallback: () {
                if (fundDetailEntity.isBuy == '1') return;
                if (numberController.text.length == 0) {
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qsrtbsl}");
                  return;
                }

                buy(numberController.text);
              })),
    ]);
  }

  buy(amount) {
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.order_add, {'zoon_id': fundDetailEntity.zoonId, 'amount': amount}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      EventBus().send('CrowdFundingDetail', true);
      showToast('${getString().zf22}');
      if (mounted) setState(() {});
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }
}
