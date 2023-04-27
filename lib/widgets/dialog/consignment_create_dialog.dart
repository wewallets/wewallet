import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/collection_product_rand_entity.dart';
import 'package:mars/models/product_by_currency_entity.dart';
import '../../models/collection_product_list_entity.dart';
import 'base_dialog.dart';

//
// ignore: must_be_immutable
class ConsignmentCreateDialog extends StatefulWidget {
  int index;
  var voidCallback;

  ConsignmentCreateDialog(this.voidCallback);

  @override
  _ConsignmentCreateDialogState createState() => _ConsignmentCreateDialogState();
}

class _ConsignmentCreateDialogState extends State<ConsignmentCreateDialog> {
  TextEditingController numberController = new TextEditingController();
  List<ProductByCurrencyEntity> productByCurrencyEntityList = [];
  List<String> coinList = [];
  bool isUse;
  String coin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext contexts) {
    return BaseDialog(
      width: double.infinity,
      height: double.infinity,
      widget: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: dp(60), right: dp(60)),
            decoration: BoxDecoration(color: Color(0xFF161427), borderRadius: BorderRadius.all(Radius.circular(dp(10)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(dp(12)), child: Center(child: Text('${s.text12}', style: TextStyles.textWhite14))),
                Padding(padding: EdgeInsets.all(dp(12)), child: Text('寄售价格（USDT）', style: TextStyles.textWhite14)),
                Container(
                    margin: EdgeInsets.only(left: dp(12), right: dp(12), bottom: dp(5)),
                    padding: EdgeInsets.only(left: dp(12), right: dp(12)),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(10))), border: Border.all(width: 0.5, color: Colours.white)),
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
                                  controller: numberController,
                                  style: TextStyles.textWhite14,
                                  cursorColor: Colours.white,
                                  onChanged: (String value) {
                                    setState(() {
                                      if (value == null || value == '')
                                        isUse = false;
                                      else
                                        isUse = true;
                                    });
                                  },
                                  decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.qsrsl}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                                ))),
                      ],
                    )),
                Gaps.vGap12,
                Row(children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(color: Color(0xFF242140), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(dp(10)))),
                          height: dp(38.5),
                          child: inkButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('${s.qx}', style: TextStyles.textWhite14)))),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('open_button')), fit: BoxFit.fill)),
                          height: dp(38.5),
                          child: inkButton(
                              onPressed: () {
                                if (numberController.text.length == 0) {
                                  showToast('${s.qsrsl}');
                                  return;
                                }
                                Navigator.pop(context);
                                widget.voidCallback(numberController.text);
                              },
                              child: Text('${s.queren}', style: TextStyles.textWhite14)))),
                ]),
              ],
            ))
      ]),
      entryAnimation: EntryAnimation.DEFAULT,
    );
  }
}
