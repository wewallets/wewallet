import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/collection_product_rand_entity.dart';
import 'package:mars/models/product_by_currency_entity.dart';
import '../../models/collection_product_list_entity.dart';
import 'base_dialog.dart';

// ignore: must_be_immutable
class ConsignmentCancelDialog extends StatefulWidget {
  String title;
  String content;
  var voidCallback;

  ConsignmentCancelDialog(this.title,this.content, this.voidCallback);

  @override
  _ConsignmentCancelDialogState createState() => _ConsignmentCancelDialogState();
}

class _ConsignmentCancelDialogState extends State<ConsignmentCancelDialog> {
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
                Padding(padding: EdgeInsets.all(dp(12)), child: Center(child: Text('${widget.title}', style: TextStyles.textWhite14))),
                Lines.line,
                Padding(padding: EdgeInsets.all(dp(12)), child: Text('${widget.content}', style: TextStyles.textWhite14)),
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
                                Navigator.pop(context);
                                widget.voidCallback();
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
