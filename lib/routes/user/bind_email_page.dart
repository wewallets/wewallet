import 'dart:async';
import 'dart:io';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletPropose.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/scan_view_sheet_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

//绑定邮箱
class BindEmailPage extends StatefulWidget {
  @override
  _BindEmailPageState createState() => _BindEmailPageState();
}

class _BindEmailPageState extends State<BindEmailPage> {
  TextEditingController walletTEC = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();

  Timer _timerIndex;
  int _count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().bangdingyx}'),
      body: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(61), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('${getString().duifdiz}', style: TextStyles.textBlack12),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    maxLines: 1,
                    controller: walletTEC,
                    decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().qingshuryouxh}', hintStyle: TextStyles.textB4B4B428),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyles.textBlack15,
                  )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(34)),
                color: Colours.colorEE,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),

              Gaps.vGap10,

              Container(
                child: TextField(
                  autofocus: false,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  controller: _codeController,
                  style: TextStyles.textBlack15,
                  cursorColor: Colours.textBlack,
                  decoration: InputDecoration(
                      counterText: '',
                      suffixIcon: InkWell(
                        child: Container(
                          width: ScreenUtil().setWidth(200),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                          child: Text(_count <= 0 ? '${getString().huoquyanzhengma}' : '${getString().yifasong}${_count}s', style: TextStyles.textTheme12),
                        ),
                        onTap: () {
                          if (_count <= 0) sendSms();
                        },
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      hintText: '${getString().qingshuruyzm}',
                      hintStyle: TextStyles.textGrey16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(34)),
                color: Colours.colorEE,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Gaps.vGap20,
              Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(120)),
                  child: Buttons.getDetermineButton(
                      isUse: true,
                      buttonText: '${getString().qd}',
                      voidCallback: () {
                        activation();
                      })),
            ],
          )),
    );
  }

  void _countdown() {
    if (_timerIndex != null) {
      return;
    }
    _count = 60;
    _timerIndex = Timer.periodic(const Duration(seconds: 1), (timer) {
      _count--;
      if (_count <= 0) {
        //取消定时器，避免无限回调
        timer.cancel();
        timer = null;
      }
      setState(() {});
    });
    setState(() {});
  }

  sendSms() {
    if (walletTEC.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qingshurushoujhao}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(
      ApiTransaction.send_email,
      {'email': walletTEC.text, 'type': 1},
      success: (data) {
        LayoutUtil.closeLoadingDialog(context);
        _timerIndex = null;
        _countdown();
      },
      failure: (error) {
        LayoutUtil.closeLoadingDialog(context);
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
      },
    );
  }

  activation() {
    if (walletTEC.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qingshuryouxh}');
      return;
    }
    if (_codeController.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().qingshuruyzm}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.email_set, {'email': walletTEC.text, 'code': _codeController.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);

      SpUtil.putString('email${GlobalTransaction.walletInfo.account_id}', walletTEC.text);

      GlobalTransaction.refreshWalletAssets();

      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().youxiangbdcg}');
      Navigator.pop(context);
    }, failure: (error) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
      Navigator.pop(context);
    });
  }
}
