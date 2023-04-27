import 'dart:io';

import 'package:mars/common/transaction_component_index.dart';

import '../../common/whiteBase/base_state.dart';
import '../../models/pledge_list_entity.dart';

class ProductDetailsPage extends StatefulWidget {
  final Bundle bundle;

  ProductDetailsPage(this.bundle);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends BaseState<ProductDetailsPage> {
  PledgeListEntity pledgeListEntity;
  TextEditingController number1Controller = new TextEditingController();

  @override
  Color get backgroundColor => Colours.white;

  @override
  void initState() {
    super.initState();
    pledgeListEntity = widget.bundle.getObject('pledgeListEntity');
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget get appBar => getAppBar('产品详情', actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            inkButton(
                onPressed: () {
                  navigateTo(PageTransactionRouter.my_product_page);
                },
                child: LoadImage('ic_all_flag', width: dp(15), height: dp(15))),
            Gaps.hGap15,
          ],
        )
      ]);

  @override
  Widget buildContent(BuildContext context) {
    return ListView(children: [
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        LoadImage('${pledgeListEntity.icon}', width: dp(25), height: dp(25)),
        Gaps.hGap5,
        Text('${pledgeListEntity.title}', style: TextStyles.textBlack15),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text79}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.rate}%', style: TextStyles.textBlack14.copyWith(color: Color(0xFFE74561))),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('投资期限：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.day}${s.tian}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text80}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.rulesUnlock}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text81}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.payTotaled}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text82}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.startTime}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Container(height: dp(12), width: double.infinity, color: Color(0xFFF8F8FC)),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text83}', style: TextStyles.textBlack15),
      ]),
      Gaps.vGap12,
      Lines.line,
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text83}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.rulesTrading}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text85}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.rulesInterest}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text86}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.rulesDividend}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text80}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.rulesUnlock}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text88}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.paymentDate}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Container(height: dp(12), width: double.infinity, color: Color(0xFFF8F8FC)),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text89}', style: TextStyles.textBlack15),
      ]),
      Gaps.vGap12,
      Lines.line,
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${pledgeListEntity.intro}', style: TextStyles.textBlack13),
        Gaps.hGap12,
      ]),
      Gaps.vGap12,
      Container(height: dp(12), width: double.infinity, color: Color(0xFFF8F8FC)),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text71}', style: TextStyles.textBlack15),
      ]),
      Gaps.vGap12,
      Lines.line,
      Gaps.vGap12,
      Container(
          margin: EdgeInsets.only(bottom: dp(5), left: dp(12), right: dp(12)),
          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(5))), color: Color(0xFFF8F8FC)),
          height: dp(49),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                      child: TextField(
                        keyboardType: Platform.isIOS ? TextInputType.emailAddress : TextInputType.number,
                        controller: number1Controller,
                        style: TextStyles.textBlack14,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.sl}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                      ))),
            ],
          )),
      Row(children: [
        Gaps.hGap12,
        Text('${s.text40}${GlobalTransaction.getSwapAssets(pledgeListEntity.payCurrency)?.value ?? '0'} ${pledgeListEntity.payCurrency}', style: TextStyles.textGrey12),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text91}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.payMin} ${pledgeListEntity.payCurrency}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Row(children: [
        Gaps.hGap12,
        Text('${s.text92}：', style: TextStyles.textGrey12),
        Gaps.hGap5,
        Text('${pledgeListEntity.payMax} ${pledgeListEntity.payCurrency}', style: TextStyles.textBlack14),
      ]),
      Gaps.vGap12,
      Container(height: dp(30), width: double.infinity, color: Color(0xFFF8F8FC)),
      Container(
          color: Color(0xFFF8F8FC),
          padding: EdgeInsets.only(bottom: dp(12)),
          child: Row(children: [
            Gaps.hGap12,
            Expanded(
                child: inkButton(
                    onPressed: () {
                      if (GlobalTransaction.swapProductListData.productList != null && GlobalTransaction.swapProductListData.productList.length != 0)
                        navigateTo(PageTransactionRouter.independent_swap_page, bundle: Bundle()..putObject('swapProductListEntity', GlobalTransaction.swapProductListData.productList[0]));
                      else
                        pop();
                    },
                    child: Container(
                      width: double.infinity,
                      height: dp(45),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(5)), color: Color(0xFF05ABBA)),
                      alignment: Alignment.center,
                      child: Text('${s.text93}', style: TextStyles.textWhite16),
                    ))),
            Gaps.hGap12,
            Expanded(
                child: inkButton(
              onPressed: () {
                submit();
              },
              child: Container(
                width: double.infinity,
                height: dp(45),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(5)), color: Color(0xFFE74561)),
                alignment: Alignment.center,
                child: Text('${s.zf12}', style: TextStyles.textWhite16),
              ),
            )),
            Gaps.hGap12,
          ]))
    ]);
  }

  submit() {
    if (number1Controller.text.length == 0) {
      showToast('${s.qsrsl}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.swap_pledge_order_add, {'pledge_id': pledgeListEntity.pledgeId, 'pay_amount': number1Controller.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('${s.text49}');
      pop();
      navigateTo(PageTransactionRouter.my_product_page);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }

  getData() {}
}
