import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/public_offerings_entity.dart';
import 'base_dialog.dart';

//交易的买入卖出挂单
class TransactionContractDialog extends StatefulWidget {
  TransactionContractDialog(this.contractListEntity, this.voidCallback);

  final PublicOfferingsEntity contractListEntity;
  final voidCallback;

  @override
  _TransactionContractDialogState createState() => _TransactionContractDialogState();
}

class _TransactionContractDialogState extends State<TransactionContractDialog> {

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      cornerRadius: 0.0,
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      widget: Container(
        color: Colours.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: ScreenUtil().setWidth(750),
              width: double.infinity,
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(ScreenUtil().setWidth(14)), topLeft: Radius.circular(ScreenUtil().setWidth(14))), color: Colours.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: InkResponse(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(child: LoadImage(Images.combined_shape_26671, width: ScreenUtil().setWidth(30)), padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30))),
                      )),
                  Center(
                    child: Text('${getString().gm17}', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.w500)),
                  ),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${getString().gm18}', style: TextStyles.textGrey12),
                          Text('${widget.contractListEntity.productPayCurrency}', style: TextStyles.textBlack14),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${getString().gm19}', style: TextStyles.textGrey12),
                          Text('${widget.contractListEntity.orderPayAmount}', style: TextStyles.textBlack14),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${getString().gm20}', style: TextStyles.textGrey12),
                          Text('${widget.contractListEntity.productCurrency}', style: TextStyles.textBlack14),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${getString().gm21}', style: TextStyles.textGrey12),
                          Text('${widget.contractListEntity.orderAmount}', style: TextStyles.textBlack14),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Expanded(child: Gaps.vGap25),
                  Buttons.getDetermineButton(
                      isUse: true,
                      buttonText: '${getString().qd}',
                      voidCallback: () {
                        widget.voidCallback();
                      }),
                  Gaps.vGap20,
                ],
              ),
            ),
          ],
        ),
      ),
      entryAnimation: EntryAnimation.BOTTOM,
    );
  }
}
