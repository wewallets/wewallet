import 'dart:math';
import 'dart:ui';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../mobels/BackupItem.dart';
import '../../mobels/wallet_entity.dart';

class MnemonicPage extends StatefulWidget {
  final Bundle bundle;

  MnemonicPage(this.bundle);

  @override
  _MnemonicPageState createState() => _MnemonicPageState();
}

class _MnemonicPageState extends BaseState<MnemonicPage> with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController submitAnimationController;

  //显示提示窗
  bool isHint = true;

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

  int usedIndex;

  WalletEntity walletEntity;

  @override
  Widget get appBar => null;

  @override
  void initState() {
    super.initState();
    walletEntity = widget.bundle.getObject('walletEntity');

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1700));
    submitAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    Future.delayed(Duration(milliseconds: 150), () => animationController.forward());

    List<String> propose = walletEntity.wallet.propose.split(' ');
    for (int i = 0; i < propose.length; i++) {
      selectData.add(BackupItem(content: ''));
      correctData.add(BackupItem(content: propose[i], isUse: true));
    }
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length, (index) => _availableChars[_random.nextInt(_availableChars.length)]).join();

    return randomString;
  }

  @override
  void dispose() {
    animationController.dispose();
    submitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colours().background),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: SlideTransition(
                position: Tween(begin: Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(
                  parent: animationController,
                  curve: Interval(0.0, 0.4, curve: Curves.ease),
                )),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: dp(90)),
                  child: Column(
                    children: [
                      Text(isBegin ? '验证助记词' : '备份助记词', style: TextStyles().textBlack27),
                      Gaps.vGap10,
                      Text('请根据您抄写的助记词, 按顺序选择填充', style: TextStyles().textBlack14),
                    ],
                  ),
                ),
              ),
            ),
            _buildLoginBody(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  child: IconButton(
                    icon: LoadAssetImage('break_left2', height: ScreenUtil().setWidth(44)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), top: ScreenUtil().statusBarHeight + ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(30))),
            ),
            isHint
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Color(0x80000000),
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(height: dp(260)),
                          Text('备份钱包助记词', style: TextStyles().textWhite23),
                          Gaps.vGap20,
                          Text('获得助记词等于拥有钱包资产所有权。', style: TextStyles().textWhite14.copyWith(color: Color(0xCCFFFFFF))),
                          Gaps.vGap5,
                          Text('助记词由英文单词组成，请抄写并妥善保管。', style: TextStyles().textWhite14.copyWith(color: Color(0xCCFFFFFF))),
                          Gaps.vGap5,
                          Text('助记词丢失，无法找回，请务必备份助记词。', style: TextStyles().textWhite14.copyWith(color: Color(0xCCFFFFFF))),
                          Gaps.vGap25,
                          Buttons.getDetermineButton(
                              buttonText: '立即备份',
                              margin: EdgeInsets.only(left: dp(100), right: dp(100)),
                              onPressed: () {
                                isHint = false;
                                setState(() {});
                              }),
                        ],
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return new AnimatedBuilder(
      animation: submitAnimationController,
      builder: (ctx, w) {
        return Container(
          margin: EdgeInsets.only(top: dp(30), bottom: dp(30)),
          child: Column(
            children: <Widget>[
              Buttons.getDetermineButton(
                  buttonText: isBegin ? '完成' : '备份完成，开始验证',
                  color: !isBegin || isUse ? Colours().themeColor : Colours().textGrey,
                  onPressed: () {
                    submit();
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginBody() {
    var cardCurve = CurvedAnimation(parent: animationController, curve: Interval(0, 0.4, curve: Curves.ease));
    var accountCurve = CurvedAnimation(parent: animationController, curve: Interval(0.3, 0.5, curve: Curves.ease));
    var submitCurve = CurvedAnimation(parent: animationController, curve: Interval(0.5, 0.7, curve: Curves.ease));
    return Container(
      child: Center(
        child: SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(cardCurve),
          child: Container(
              height: ScreenUtil().screenHeight,
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60), top: dp(170)),
              child: ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: <Widget>[
                SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(accountCurve),
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(accountCurve),
                      child: _buildContent(),
                    )),
                SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(submitCurve),
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(submitCurve),
                      child: _buildSubmit(),
                    )),
              ])),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.all(dp(12)),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
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
        child: isCorrect ? Text('助记词顺序错误，请检查您抄写的助记词是否正确', style: TextStyles().textWhite12.copyWith(color: Color(0xFFFD3C58))) : Container(),
        decoration: BoxDecoration(color: isCorrect ? Color(0x0AFD3C58) : Colours().transparent, borderRadius: BorderRadius.all(Radius.circular(20))),
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
    ]);
  }

  buildSelectItems(int index, BackupItem data) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: ScreenUtil().setWidth(90),
          decoration: BoxDecoration(color: Color(0x0D6840F7), borderRadius: BorderRadius.all(Radius.circular(8))),
          alignment: Alignment.center,
          child: Stack(children: [
            Center(child: Text(data.content, style: TextStyles().textTheme14)),
            Align(child: Padding(child: Text('${index + 1}', style: TextStyles().textGrey10.copyWith(color: Color(0x806840F7))), padding: EdgeInsets.only(top: ScreenUtil().setWidth(10), left: ScreenUtil().setWidth(16))), alignment: Alignment.topLeft),
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
            decoration: BoxDecoration(color: Colours().white, borderRadius: BorderRadius.all(Radius.circular(8))),
            child: inkButton(
              child: Container(child: Text(data.content, style: TextStyles().textTheme14), height: double.infinity, alignment: Alignment.center),
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
            decoration: BoxDecoration(color: Colours().FFF2F1F8, borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Text(data.content, style: TextStyles().textBlack14.copyWith(color: Colours().colorB4)),
          );
  }

  submit() {
    if (isBegin) {
      if (!isUse) {
        Global.saveWallet(walletEntity);
        navigatorPush(PageWalletRouter.main_page, isPop: true);
        return;
      } else {
        return;
      }
    }

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
  }
}
