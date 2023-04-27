import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:mars/common/utils/num_util.dart';
import 'package:mars/models/userLedger.dart';
import 'package:mars/socket/ripple_web_socket.dart';

/**
 * 账本详情
 */
class AccountBookInfoPage extends StatefulWidget {
  final Bundle bundle;

  AccountBookInfoPage(this.bundle);

  @override
  State<StatefulWidget> createState() => _AccountBookInfoState();
}

class _AccountBookInfoState extends State<AccountBookInfoPage> {
  UserLedger userLedger;
  String status = '';
  String balance;

  @override
  void initState() {
    super.initState();
    userLedger = widget.bundle.getObject('ledgerInfo');
    // getRecord();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, '${getString().zbxq}'),
        body: userLedger == null
            ? Container()
            : Column(
          children: [
            userLedger.state_str == null
                ? Container()
                : Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38), top: ScreenUtil().setWidth(6)),
              height: ScreenUtil().setWidth(94),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getString().ztai}', style: TextStyles.textBlack14),
                  Text('${userLedger.state_str}', style: TextStyles.textGrey12),
                ],
              ),
            ),
            Container(
              color: Colours.color0D000000,
              width: double.infinity,
              height: ScreenUtil().setWidth(1),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38), top: ScreenUtil().setWidth(6)),
              height: ScreenUtil().setWidth(94),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getString().leixin}', style: TextStyles.textBlack14),
                  Text('${userLedger.type}', style: TextStyles.textGrey12),
                ],
              ),
            ),
            Container(color: Colours.color0D000000, width: double.infinity, height: ScreenUtil().setWidth(1), margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30))),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38)),
              height: ScreenUtil().setWidth(94),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getString().sl}', style: TextStyles.textBlack14),
                  Text('${userLedger.amount} ${userLedger.currency}', style: TextStyles.textBlack12),
                ],
              ),
            ),
            Container(
              color: Colours.color0D000000,
              width: double.infinity,
              height: ScreenUtil().setWidth(1),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38)),
              height: ScreenUtil().setWidth(94),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getString().yuee}', style: TextStyles.textBlack14),
                  Text('${userLedger.balance} ${userLedger.currency}', style: TextStyles.textGrey12),
                ],
              ),
            ),
            Container(
              color: Colours.color0D000000,
              width: double.infinity,
              height: ScreenUtil().setWidth(1),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            ),
            // balance == null
            //     ? Container()
            //     : Container(
            //         margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38)),
            //         height: ScreenUtil().setWidth(94),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text('${getString().yuee}', style: TextStyles.textBlack14),
            //             Text('$balance ${userLedger.currency}', style: TextStyles.textGrey12),
            //           ],
            //         ),
            //       ),
            // balance == null
            //     ? Container()
            //     : Container(
            //         color: Colours.color0D000000,
            //         width: double.infinity,
            //         height: ScreenUtil().setWidth(1),
            //         margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            //       ),
            userLedger.destination == null || userLedger.destination == ''
                ? Container()
                : InkWell(
              onTap: () {
                Clipboard.setData(new ClipboardData(text: userLedger.account));
                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
              },
              child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38)),
                  height: ScreenUtil().setWidth(94),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${getString().dfzh}', style: TextStyles.textBlack14),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
                                    child: Text('${userLedger.destination}', textAlign: TextAlign.right, style: TextStyles.textTheme12),
                                  ),
                                ),
                                Align(alignment: Alignment.centerRight, child: LoadImage('icon_ab_copy', width: ScreenUtil().setWidth(22), height: ScreenUtil().setWidth(23)))
                              ],
                            ),
                          ))
                    ],
                  )),
            ),
            Container(
              color: Colours.color0D000000,
              width: double.infinity,
              height: ScreenUtil().setWidth(1),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38)),
              height: ScreenUtil().setWidth(94),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getString().cjsj}', style: TextStyles.textBlack14),
                  userLedger.tx_time == null ? Container() : Text(DateUtil.formatDateFromMillisecondsSinceEpoch((int.parse(userLedger.tx_time) * 1000).toString(), format: 'yyyy-MM-dd HH:mm:ss'), style: TextStyles.textGrey12),
                ],
              ),
            ),
            Container(
              color: Colours.color0D000000,
              width: double.infinity,
              height: ScreenUtil().setWidth(1),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38)),
              height: ScreenUtil().setWidth(94),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getString().sxf}', style: TextStyles.textBlack14),
                  userLedger.fee == null ? Container() : Text('${userLedger.fee}', style: TextStyles.textGrey12),
                ],
              ),
            ),
            Container(
              color: Colours.color0D000000,
              width: double.infinity,
              height: ScreenUtil().setWidth(1),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            ),
            userLedger.hash == ''
                ? Container()
                : InkWell(
                onTap: () {
                  Clipboard.setData(new ClipboardData(text: userLedger.hash));
                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                },
                child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(38)),
                  height: ScreenUtil().setWidth(94),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(child: Text('hash', style: TextStyles.textBlack14), height: ScreenUtil().setWidth(94), alignment: Alignment.topLeft, padding: EdgeInsets.only(top: ScreenUtil().setWidth(15))),
                      Gaps.hGap15,
                      Expanded(child: Text('${userLedger.hash}', style: TextStyles.textGrey12, textAlign: TextAlign.right)),
                      Gaps.hGap5,
                      Align(alignment: Alignment.centerRight, child: LoadAssetImage('icon_ab_copy', width: ScreenUtil().setWidth(22), height: ScreenUtil().setWidth(23), color: Colours.textGrey)),
                    ],
                  ),
                )),
            userLedger.hash == ''
                ? Container()
                : Container(
              color: Colours.color0D000000,
              width: double.infinity,
              height: ScreenUtil().setWidth(1),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            ),
          ],
        ));
  }

  getTransaction() {
    if (userLedger.transaction_type == 'Payment') {
      if (userLedger.description.contains('${getString().zr}')) {
        return '${getString().zr}';
      } else {
        return '${getString().zhaunchu}';
      }
    } else if (userLedger.transaction_type == 'pool_in') {
      return '${getString().kczr}';
    } else if (userLedger.transaction_type == 'pool_out') {
      return '${getString().kczc}';
    } else {
      return '${getString().qt}';
    }
  }
}
