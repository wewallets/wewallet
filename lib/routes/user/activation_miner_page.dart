import 'dart:async';
import 'dart:io';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/walletPropose.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/scan_view_sheet_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

//激活矿工
class ActivationMinerPage extends StatefulWidget {
  final Bundle bundle;

  ActivationMinerPage(this.bundle);

  @override
  _ActivationMinerPageState createState() => _ActivationMinerPageState();
}

class _ActivationMinerPageState extends State<ActivationMinerPage> {
  TextEditingController walletTEC = new TextEditingController();
  bool isLegal = false;
  String area = 'A';
  bool isA = true;
  bool isB = true;
  bool isC = true;
  int type = 0;

  @override
  void initState() {
    super.initState();
    // getArea();
    //if (widget.bundle!=null&&widget.bundle.isContainsKey('type')) type = widget.bundle.getInt('type');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '${getString().jhkg}', actions: [
        InkResponse(
          child: Container(alignment: Alignment.center, padding: EdgeInsets.only(right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)), child: Text('${getString().kuanggonglieb}', style: TextStyles.text7854D528)),
          onTap: () {
            if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.list_of_miners_page);
          },
        )
      ]),
      body: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(61), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${getString().duifdiz}', style: TextStyles.textBlack12),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    maxLines: 1,
                    controller: walletTEC,
                    onChanged: (v) {
                      checkPage();
                    },
                    decoration: InputDecoration(border: InputBorder.none, hintText: '${getString().qsrdfqbdz}', hintStyle: TextStyles.textB4B4B428),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyles.textBlack15,
                  )),
                  InkResponse(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (Platform.isAndroid) {
                          await Permission.camera.request().then((value) {
                            if ( value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
                              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().kqxjqxsb}');
                              return;
                            }
                          });
                        }
                        FocusScope.of(context).requestFocus(FocusNode());
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colours.transparent,
                            context: context,
                            builder: (builder) {
                              return ScanViewSheetDialog((data) {
                                walletTEC.text = data;
                                isLegal = true;
                                setState(() {});
                              });
                            });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                        child: LoadImage('icon_sao', width: ScreenUtil().setWidth(32), height: ScreenUtil().setWidth(32)),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(34)),
                color: Colours.colorEE,
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
              ),
              Gaps.vGap10,
              // !isA ? Container() : Text('激活区域', style: TextStyles.textBlack12),
              // !isA ? Container() : Gaps.vGap10,
              // Row(
              //   children: <Widget>[
              //     !isA
              //         ? Container()
              //         : InkWell(
              //             onTap: () {
              //               area = 'A';
              //               setState(() {});
              //             },
              //             child: Container(
              //               alignment: Alignment.center,
              //               width: ScreenUtil().setWidth(154),
              //               height: ScreenUtil().setWidth(60),
              //               decoration: BoxDecoration(
              //                 color: area == 'A' ? Colours.themeColor : Colours.white,
              //                 borderRadius: BorderRadius.all(Radius.circular(3)),
              //                 border: Border.all(width: 0.5, color: Colours.themeColor),
              //               ),
              //               child: Text('A区', style: area == 'A' ? TextStyles.textWhite13 : TextStyles.textTheme13),
              //             )),
              //     !isB ? Container() : Gaps.hGap12,
              //     !isB
              //         ? Container()
              //         : InkWell(
              //             onTap: () {
              //               area = 'B';
              //               setState(() {});
              //             },
              //             child: Container(
              //               alignment: Alignment.center,
              //               width: ScreenUtil().setWidth(154),
              //               height: ScreenUtil().setWidth(60),
              //               decoration: BoxDecoration(
              //                 color: area == 'B' ? Colours.themeColor : Colours.white,
              //                 borderRadius: BorderRadius.all(Radius.circular(3)),
              //                 border: Border.all(width: 0.5, color: Colours.themeColor),
              //               ),
              //               child: Text('B区', style: area == 'B' ? TextStyles.textWhite13 : TextStyles.textTheme13),
              //             )),
              //     !isC ? Container() : Gaps.hGap12,
              //     !isC
              //         ? Container()
              //         : InkWell(
              //             onTap: () {
              //               area = 'C';
              //               setState(() {});
              //             },
              //             child: Container(
              //               alignment: Alignment.center,
              //               width: ScreenUtil().setWidth(154),
              //               height: ScreenUtil().setWidth(60),
              //               decoration: BoxDecoration(
              //                 color: area == 'C' ? Colours.themeColor : Colours.white,
              //                 borderRadius: BorderRadius.all(Radius.circular(3)),
              //                 border: Border.all(width: 0.5, color: Colours.themeColor),
              //               ),
              //               child: Text('C区', style: area == 'C' ? TextStyles.textWhite13 : TextStyles.textTheme13),
              //             )),
              //   ],
              // ),
              // Gaps.vGap10,
              Text.rich(TextSpan(children: [
                TextSpan(text: '${getString().jhxyxh} ', style: TextStyles.textGrey612),
                TextSpan(text: '0.01 ${GlobalTransaction.coin}', style: TextStyles.text7854D524),
              ])),
              Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(120)),
                  child: Buttons.getDetermineButton(
                      isUse: isLegal,
                      buttonText: '${getString().qd}',
                      voidCallback: () {
                        activation();
                      })),
            ],
          )),
    );
  }

  switchArea(type) {}

  checkPage() {
    if (walletTEC.text.length == 0) {
      isLegal = false;
    } else {
      isLegal = true;
    }
    if (mounted) setState(() {});
  }

  getArea() {
    Net().post(ApiTransaction.USER_AREA, null, success: (data) {
      isA = data['A'] != '';
      isB = data['B'] != '';
      isC = data['C'] != '';

      setState(() {});
    }, failure: (error) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }

  activation() {
    if (isLegal) {
      if (walletTEC.text == GlobalTransaction.walletInfo.account_id) {
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().bnjhzj}');
        return;
      }
      LayoutUtil.showLoadingDialog(context);
      Net().post(type == 1 ? ApiTransaction.POOL_ACTIVATE : ApiTransaction.PAYMENT_ACTIVE, {'to': walletTEC.text, 'area': area}, success: (data) {
        LayoutUtil.closeLoadingDialog(context);

        GlobalTransaction.refreshWalletAssets();

        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().jhcg}');
        Navigator.pop(context);
      }, failure: (error) {
        Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
        Navigator.pop(context);
      });
    }
  }
}
