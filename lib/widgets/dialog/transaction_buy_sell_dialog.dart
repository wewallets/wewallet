import 'dart:ui';

import 'package:mars/common/transaction_component_index.dart';
import 'base_dialog.dart';

//交易的买入卖出挂单
class TransactionBuySellDialog extends StatelessWidget {
  TransactionBuySellDialog(this.unitPrice, this.number, this.totalPrice, this.minersFee, this.type, this.voidCallback);

  final String unitPrice;
  final String number;
  final String totalPrice;
  final String minersFee;
  final bool type;
  final VoidCallback voidCallback;

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
              width: double.infinity,
              height: ScreenUtil().setWidth(682),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(ScreenUtil().setWidth(14)), topLeft: Radius.circular(ScreenUtil().setWidth(14))), color: Colours.white),
              child: Column(
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
                    child: Text('${type ? '买入挂单详情' : '卖出挂单详情'} ', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.w500)),
                  ),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('价格', style: TextStyles.textGrey12),
                          Text('$unitPrice', style: TextStyles.textBlack14),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('挂单数量', style: TextStyles.textGrey12),
                          Text('$number'),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('交易总额', style: TextStyles.textGrey12),
                          Text('$totalPrice', style: TextStyles.textBlack14),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Container(
                      height: ScreenUtil().setWidth(96),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('矿工费', style: TextStyles.textGrey12),
                          Text('$minersFee', style: TextStyles.textBlack14),
                        ],
                      )),
                  Container(color: Colours.colorEE, height: ScreenUtil().setWidth(1)),
                  Expanded(child: Gaps.vGap25),
                  Buttons.getDetermineButton(isUse: true, voidCallback: voidCallback),
                  Gaps.vGap20,
                ],
              ),
            ),
          ],
        ),
      ),
      entryAnimation: EntryAnimation.DEFAULT,
    );
  }
}
