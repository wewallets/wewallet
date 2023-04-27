import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:mars/models/index.dart';

//投票上币
class OperatedCoinPage extends StatefulWidget {
  @override
  _OperatedCoinPageState createState() => _OperatedCoinPageState();
}

class _OperatedCoinPageState extends State<OperatedCoinPage> {
  List<WalletActivityList> operatedList = [];
  WalletActivityInfo operatedInfo;
  WalletActivityList selectItem;
  String ip;
  String device;

  @override
  void initState() {
    super.initState();
    getDevice();
    getIp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LoadImage('shenqi_load_bg', fit: BoxFit.fill, width: double.infinity, height: double.infinity),
          Container(
            child: LoadImage('xtbj_bga', width: ScreenUtil().setWidth(230)),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: kToolbarHeight + ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(55)),
          ),
          operatedInfo == null
              ? LayoutUtil.getLoadingShadeCustom()
              : ListView(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(180), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                  children: [
                    Text('BITCHEN', style: TextStyles.textWhite23),
                    Text('${operatedInfo.title}', style: TextStyles.textWhite14),
                    Gaps.vGap5,
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(5), bottom: ScreenUtil().setWidth(5)),
                            child: Text('投票结束时间：${operatedInfo.ac_end_time}', style: TextStyles.textWhite12),
                            decoration: BoxDecoration(color: Colours.themeColor, borderRadius: BorderRadius.all(Radius.circular(6))))
                      ],
                    ),
                    Gaps.vGap20,
                    Container(
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            Text('币种/发行总量', style: TextStyles.textBlack13),
                            Text('票数', style: TextStyles.textBlack13),
                            Text('选择', style: TextStyles.textBlack13),
                          ]),
                          ListView.builder(
                              itemCount: operatedList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(30)),
                              itemBuilder: (BuildContext context, int index) {
                                if (operatedInfo.status == '4' && operatedList[index].have_vote == '1') {
                                  selectItem = operatedList[index];
                                }
                                return InkWell(
                                    onTap: () {
                                      if (operatedInfo.status == '1') {
                                        selectItem = operatedList[index];
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage(operatedList[index].have_vote == '1' || selectItem == operatedList[index] ? 'assets/item_bg_tbsc2.png' : 'assets/item_bg_tbsc1.png'))),
                                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    LoadImage('${operatedList[index].icon}', width: ScreenUtil().setWidth(35), height: ScreenUtil().setWidth(35)),
                                                    Gaps.hGap5,
                                                    Text('${operatedList[index].base_currency_name}', style: TextStyles.textBlack12),
                                                  ],
                                                ),
                                                Gaps.vGap7,
                                                Text('${operatedList[index].subscribe_total}', style: TextStyles.textBlack11),
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text('${operatedList[index].vote_num}', style: TextStyles.textBlack14),
                                                // Gaps.vGap5,
                                                // ActivityProgressBarWidget(70, ''),
                                              ],
                                            ),
                                          ),
                                          Container(child: LoadImage(operatedList[index].have_vote == '1' || selectItem == operatedList[index] ? 'choice' : 'no_choice', width: ScreenUtil().setWidth(22)), margin: EdgeInsets.only(right: ScreenUtil().setWidth(30))),
                                        ],
                                      ),
                                    ));
                              }),
                        ],
                      ),
                    ),
                    Gaps.vGap30,
                    getDetermineButton(),
                    Gaps.vGap15,
                    Text('说明：投票不消耗矿工费，每个用户每期只有一次投票机会。', style: TextStyles.textWhite12),
                  ],
                ),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight, right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(44), fit: BoxFit.contain, color: Colours.white),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pop(context);
                    },
                  ),
                  Text('', style: Styles.textTitle.copyWith(fontWeight: FontWeight.w500, color: Colours.white)),
                  InkResponse(
                    child: Container(
                      width: ScreenUtil().setWidth(145),
                      height: ScreenUtil().setWidth(45),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/shangbishenqi.png'))),
                      child: Text('上币申请', style: TextStyles.textWhite12),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, PageTransactionRouter.operated_subscription_page);
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }

  getDetermineButton() {
    if (operatedInfo.status == '1')
      return Buttons.getDetermineButton(
          isUse: selectItem != null,
          buttonText: '确定',
          voidCallback: () {
            LayoutUtil.showLoadingDialog(context);
            Net().post(ApiTransaction.WALLET_VOTE, {'activity': selectItem.active_id, 'currency': selectItem.base_currency_name, 'currency_id': selectItem.base_currency_id, 'app_dev_no': device, 'ip': ip}, success: (data) {
              LayoutUtil.closeLoadingDialog(context);

              selectItem = null;
              getData();
            }, failure: (error) {
              LayoutUtil.closeLoadingDialog(context);

              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
            });
          });
    else if (operatedInfo.status == '4')
      return Buttons.getDetermineButton(
          isUse: true,
          buttonText: '开始认购',
          voidCallback: () {
            Navigator.pushNamed(
              context,
              PageTransactionRouter.operated_apply_page,
              arguments: Bundle()..putString('activity', selectItem.active_id)..putString('base_currency_id', selectItem.base_currency_id)..putString('device', device)..putString('ip', ip),
            )..then((value) => getData());
          });
    else if (operatedInfo.status == '7')
      return Buttons.getDetermineButton(isUse: false, buttonText: '已结束');
    else if (operatedInfo.status == '5')
      return Buttons.getDetermineButton(isUse: false, buttonText: '申购成功');
    else if (operatedInfo.status == '3')
      return Buttons.getDetermineButton(isUse: false, buttonText: '已投票');
    else if (operatedInfo.status == '6')
      return Buttons.getDetermineButton(isUse: false, buttonText: '等待投票结束');
    else if (operatedInfo.status == '2')
      return Buttons.getDetermineButton(isUse: false, buttonText: '确定');
    else if (operatedInfo.status == '9')
      return Buttons.getDetermineButton(isUse: false, buttonText: '账号未激活');
    else
      return Buttons.getDetermineButton(isUse: false, buttonText: '未开始');
  }

  getIp() async {
    ip = await Ipify.ipv4();
    getData();
  }

  getDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      device = iosDeviceInfo.identifierForVendor;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.id;
    }
  }

  getData() {
    Net().post(ApiTransaction.WALLET_ACTIVITY, {'app_dev_no': device, 'ip': ip}, success: (data) {
      operatedInfo = WalletActivityInfo.fromJson(data['info']);
      operatedList.clear();
      data['list'].forEach((element) {
        operatedList.add(WalletActivityList.fromJson(element));
      });
      if (mounted) setState(() {});
    });
  }
}
