import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/index.dart';
import 'package:mars/socket/ripple_web_socket.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';
import 'package:mars/widgets/dialog/save_QR_code_dialog.dart';
import 'package:mars/widgets/loading_shade_custom.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

//备份助记词
class MnemonicBackupPage extends StatefulWidget {
  final Bundle bundle;

  MnemonicBackupPage(this.bundle);

  @override
  _MnemonicBackupPageState createState() => _MnemonicBackupPageState();
}

class _MnemonicBackupPageState extends State<MnemonicBackupPage> {
  //0第一次创建 1新建地址 2备份 3旧地址导入
  int type = 0;

  //是否开始
  bool isBegin = false;

  //选中数据
  List<BackupItem> selectData = [];

  //待选中
  List<BackupItem> usedData = [];

  //正确
  List<BackupItem> correctData = [];

  //选中下一个坐标
  int selectIndex = 0;

  //是否可以确定
  bool isUse = false;

  //是否出现错误
  bool isCorrect = false;
  WalletPropose walletPropose;
  int usedIndex;

  //备份的钱包数据
  WalletInfo walletInfo;

  bool isBackup = false;

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('type')) type = widget.bundle.getInt('type');
    if (widget.bundle != null && widget.bundle.isContainsKey('isBackup')) isBackup = widget.bundle.getBool('isBackup');

    if (type == 2) {
      walletInfo = widget.bundle.getObject('walletPropose');
      List<String> masterKetList = walletInfo.master_key.split(' ');
      for (int i = 0; i < masterKetList.length; i++) {
        selectData.add(BackupItem(content: ''));
        correctData.add(BackupItem(content: masterKetList[i], isUse: true));
      }
      setState(() {});
    } else if (type == 1 || type == 3) {
      walletPropose = widget.bundle.getObject('walletPropose');
      List<String> masterKetList = walletPropose.master_key.split(' ');
      for (int i = 0; i < masterKetList.length; i++) {
        selectData.add(BackupItem(content: ''));
        correctData.add(BackupItem(content: masterKetList[i], isUse: true));
      }
      setState(() {});
    } else {
      generate();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  generate() {
    Net().post(ApiTransaction.CREATE_ADDRESS, null, success: (data) {
      walletPropose = WalletPropose();
      walletPropose.account_id = data['address'];
      walletPropose.master_seed = RESUtil.decrypt(data['secret']);
      walletPropose.master_key = RESUtil.decrypt(data['propose']);
      List<String> masterKetList = walletPropose.master_key.split(' ');
      for (int i = 0; i < masterKetList.length; i++) {
        selectData.add(BackupItem(content: ''));
        correctData.add(BackupItem(content: masterKetList[i], isUse: true));
      }
      if (mounted) setState(() {});
    }, failure: (error) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: error);
    });
    // RippleWebSocket.on(({arg}) {
    //   if (!mounted) return;
    //   if (arg['id'] == 'wallet_propose') {
    //     walletPropose = WalletPropose.fromJson(arg['result']);
    //     List<String> masterKetList = walletPropose.master_key.split(' ');
    //     for (int i = 0; i < masterKetList.length; i++) {
    //       selectData.add(BackupItem(content: ''));
    //       correctData.add(BackupItem(content: masterKetList[i], isUse: true));
    //     }
    //     setState(() {});
    //   }
    // });
    // RippleWebSocket().walletPropose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colours.white,
        appBar: LayoutUtil.getAppBar(context, '${getString().bwzjc}', onPressed: () {
          if (isBegin) {
            isBegin = false;
            setState(() {});
          } else {
            Navigator.pop(context);
          }
        }
            // , actions: [
            //   type == 0 || isBackup == true
            //       ? Container()
            //       : InkResponse(
            //           child: Container(
            //               alignment: Alignment.center,
            //               padding: EdgeInsets.only(right: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(30)),
            //               child: Row(children: [
            //                 Text('跳过', style: TextStyles.text7854D528.copyWith(color: Colours.themeColor)),
            //               ])),
            //           onTap: () {
            //             EventBus().send('refreshAddressManage', true);
            //             Navigator.pop(context);
            //           },
            //         )
            // ]
            ),
        body: walletPropose == null && walletInfo == null
            ? LayoutUtil.getLoadingShadeCustom(text: '${getString().zzchuangjdiz}')
            : ListView(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(50)),
                children: <Widget>[
                  Text(isBegin ? '${getString().zjcsxsm1}' : '${getString().zjcsxsm2}', style: TextStyles.textGrey614),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                      decoration: BoxDecoration(color: Colours.FFF2F1F8, borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      child: WaterfallFlow.builder(
                        padding: EdgeInsets.zero,
                        itemCount: isBegin ? selectData.length : correctData.length,
                        itemBuilder: (BuildContext context, int index) => buildSelectItems(index, isBegin ? selectData[index] : correctData[index]),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: ScreenUtil().setWidth(30),
                          mainAxisSpacing: ScreenUtil().setWidth(30),
                          lastChildLayoutTypeBuilder: (index) => index == correctData.length ? LastChildLayoutType.foot : LastChildLayoutType.none,
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                    height: isCorrect && isBegin ? ScreenUtil().setWidth(74) : 0,
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(25), bottom: ScreenUtil().setWidth(25)),
                    alignment: Alignment.centerLeft,
                    child: isCorrect ? Text('${getString().zjcsxw}', style: TextStyles.textWhite12.copyWith(color: Color(0xFFFD3C58))) : Container(),
                    decoration: BoxDecoration(color: isCorrect ? Color(0x0AFD3C58) : Colours.transparent, borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  isBegin
                      ? WaterfallFlow.builder(
                          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(120)),
                          itemCount: usedData.length,
                          itemBuilder: (BuildContext context, int index) => buildItems(index, usedData[index]),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: ScreenUtil().setWidth(24),
                            mainAxisSpacing: ScreenUtil().setWidth(24),
                            lastChildLayoutTypeBuilder: (index) => index == usedData.length ? LastChildLayoutType.foot : LastChildLayoutType.none,
                          ),
                        )
                      : Container(),
                  isBegin
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('${getString().qiejitis1}', style: TextStyles.textWhite16.copyWith(color: Colours.FFBD2A39, fontWeight: FontWeight.bold)),
                            Gaps.vGap10,
                            Text('${getString().qiejitis2}', style: TextStyles.textWhite14.copyWith(color: Colours.FFBD2A39)),
                            Gaps.vGap10,
                            Text('${getString().qiejitis3}', style: TextStyles.textWhite14.copyWith(color: Colours.FFBD2A39)),
                            Gaps.vGap10,
                            Text('${getString().qiejitis4}', style: TextStyles.textWhite14.copyWith(color: Colours.FFBD2A39)),
                            Gaps.vGap10,
                            Text('${getString().qiejitis5}', style: TextStyles.textWhite14.copyWith(color: Colours.FFBD2A39)),
                            Gaps.vGap30,
                          ],
                        ),
                  type == 2
                      ? Container()
                      : isBegin
                          ? Buttons.getDetermineButton(
                              isUse: isUse,
                              buttonText: '${getString().queren}',
                              voidCallback: () {
                                //保存钱包信息
                                if (isUse) {
                                  if (type == 0 || (type == 3 && isBackup == true) || (type == 1 && isBackup == true)) {
                                    GlobalTransaction.saveWallet(walletName: widget.bundle.isContainsKey('name') ? widget.bundle.getString('name') : '', accountId: walletPropose.account_id, masterKey: walletPropose.master_key, masterSeed: walletPropose.master_seed);
                                    GlobalTransaction.saveWalletPassword(widget.bundle.getString('pwd'));

                                    Navigator.pushReplacementNamed(context, PageTransactionRouter.main_page);
                                    Net().post(ApiTransaction.ADDRESS_INFO_EDIT, {'account': walletPropose.account_id, 'nick_name': '${widget.bundle.isContainsKey('name') ? widget.bundle.getString('name') : ''}'}, isLogin: false);
                                  } else {
                                    // Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                  EventBus().send('refreshAddressManage', true);
                                }
                              })
                          : Buttons.getDetermineButton(
                              isUse: true,
                              buttonText: '${getString().beifwanc}',
                              voidCallback: () {
                                isBegin = true;
                                for (int i = 0; i < correctData.length; i++) {
                                  correctData[i].isUse = true;
                                  selectData[i].content = '';
                                  selectData[i].isUse = true;
                                  isCorrect = false;
                                  selectIndex = 0;
                                  isUse = false;
                                }
                                usedData.clear();
                                usedData.addAll(correctData);
                                usedData.shuffle();

                                setState(() {});
                              }),
                  Gaps.vGap15,
                  type == 2
                      ? Container()
                      : isBegin
                          ? Container()
                          : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                              InkWell(
                                child: Text('${getString().fuzhizhujic}', style: TextStyles.textWhite14.copyWith(color: Colours.themeColor)),
                                onTap: () {
                                  Clipboard.setData(new ClipboardData(text: walletPropose.master_key));
                                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                                },
                              ),
                              InkWell(
                                child: Text('${getString().baocerweima}', style: TextStyles.textWhite14.copyWith(color: Colours.themeColor)),
                                onTap: () {
                                  showDialog(context: context, builder: (_) => SaveQRCodeDialog(walletPropose.master_key, '${getString().zhujicesm}'));
                                },
                              ),
                            ]),
                  type == 2
                      ? Buttons.getDetermineButton(
                          isUse: true,
                          buttonText: '${getString().sczzjewm}',
                          voidCallback: () {
                            showDialog(context: context, builder: (_) => SaveQRCodeDialog(walletInfo.master_key, '${getString().zhujicesm}'));
                          })
                      : Container(),
                  type == 2 ? Gaps.vGap15 : Container(),
                  type == 2
                      ? GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                            decoration: BoxDecoration(color: Color(0xFFF4EFFC), borderRadius: BorderRadius.circular(6)),
                            height: ScreenUtil().setWidth(88),
                            child: Text(
                              '${getString().fuzhizhujic}',
                              style: TextStyles.textWhite16.copyWith(color: Colours.themeColor),
                            ),
                          ),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: walletInfo.master_key));
                            Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                          },
                        )
                      : Container()
                ],
              ),
      ),
      onWillPop: () async {
        if (isBegin) {
          isBegin = false;
          setState(() {});
          return new Future.value(false);
        }
        return new Future.value(true);
      },
    );
  }

  buildSelectItems(int index, BackupItem data) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: ScreenUtil().setWidth(90),
          decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(4))),
          alignment: Alignment.center,
          child: Stack(children: [
            Center(child: Text(data.content, style: TextStyles.textBlack14)),
            Align(child: Padding(child: Text('${index + 1}', style: TextStyles.textGrey10), padding: EdgeInsets.only(top: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10))), alignment: Alignment.topRight),
          ]),
        ),
        data.isUse == false && isBegin
            ? Align(
                alignment: Alignment.topRight,
                child: InkResponse(
                  child: LoadImage('backup_del', width: ScreenUtil().setWidth(34)),
                  onTap: () {
                    selectData[index].content = '';
                    selectData[index].isUse = true;
                    isCorrect = false;
                    selectIndex--;
                    usedData[usedIndex].isUse = true;
                    setState(() {});
                  },
                ))
            : Container(),
      ],
    );
  }

  buildItems(int index, BackupItem data) {
    return data.isUse
        ? Container(
            height: ScreenUtil().setWidth(90),
            width: double.infinity,
            decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(width: 0.5, color: Colours.colorB8B1CF)),
            child: inkButton(
              padding: EdgeInsets.zero,
              child: Container(child: Text(data.content, style: TextStyles.textBlack14), height: double.infinity, alignment: Alignment.center),
              onPressed: () {
                if (isCorrect == true) return;
                usedIndex = index;
                selectData[selectIndex].content = data.content;
                selectData[selectIndex].isUse = correctData[selectIndex].content == selectData[selectIndex].content;
                isCorrect = !selectData[selectIndex].isUse;
                data.isUse = false;

                if (selectIndex == 11 && selectData[selectIndex].isUse) {
                  isUse = true;
                } else {
                  selectIndex++;
                }

                setState(() {});
              },
            ))
        : Container(
            height: ScreenUtil().setWidth(90),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colours.FFF2F1F8, borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Text(data.content, style: TextStyles.textBlack14.copyWith(color: Colours.colorB4)),
          );
  }
}

class BackupItem {
  //内容
  String content;

  //是否顺序错误
  bool isCorrect = false;

  //是否可以选择
  bool isUse = false;

  BackupItem({this.content, this.isCorrect, this.isUse});
}
