import 'package:flutter/services.dart';
import 'package:mars/wallet/common/component_index.dart';

import '../../mobels/wallet_entity.dart';

//导入钱包
class ImportWalletPage extends StatefulWidget {
  final Bundle bundle;

  ImportWalletPage(this.bundle);

  @override
  _ImportWalletPageState createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends BaseState<ImportWalletPage> with TickerProviderStateMixin, WidgetsBindingObserver {
  WalletEntity walletEntity = WalletEntity();

  AnimationController animationController;
  AnimationController submitAnimationController;
  TextEditingController nameController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool isTop = true;

  @override
  Widget get appBar => null;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1700));
    submitAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    Future.delayed(Duration(milliseconds: 150), () => animationController.forward());
  }

  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        setState(() {
          isTop = false;
        });
      } else {
        setState(() {
          isTop = true;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    nameController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();
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
            !isTop
                ? Container()
                : Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Interval(0.0, 0.4, curve: Curves.ease),
                      )),
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: ScreenUtil().setWidth(280)),
                        child: Text('使用私钥或助记词导入', style: TextStyles().textBlack27),
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
          margin: EdgeInsets.only(top: dp(30)),
          child: Column(
            children: <Widget>[
              Buttons.getDetermineButton(
                  buttonText: '下一步',
                  onPressed: () {
                    submit();
                  }),
              Gaps.vGap50,
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
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60), top: !isTop ? dp(100) : dp(200)),
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
      Text('名称', style: TextStyles().textGrey12),
      Gaps.vGap10,
      Container(
          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
          height: dp(60),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: nameController,
            maxLength: 50,
            maxLines: 1,
            style: TextStyles().textBlack14,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(border: InputBorder.none, counterText: '', fillColor: Colors.transparent, hintText: '输入1-12个字符', hintStyle: TextStyles().textGrey14),
          )),
      Gaps.vGap20,
      Text('创建密码', style: TextStyles().textGrey12),
      Gaps.vGap10,
      Container(
          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
          height: dp(60),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
          child: TextField(
            controller: password1Controller,
            keyboardType: TextInputType.emailAddress,
            style: TextStyles().textBlack14,
            maxLength: 12,
            obscureText: true,
            decoration: InputDecoration(border: InputBorder.none, counterText: '', fillColor: Colors.transparent, hintText: '设置安全密码', hintStyle: TextStyles().textGrey14),
          )),
      Gaps.vGap10,
      Container(
          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
          height: dp(60),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
          child: TextField(
            controller: password2Controller,
            keyboardType: TextInputType.emailAddress,
            maxLength: 12,
            style: TextStyles().textBlack14,
            obscureText: true,
            decoration: InputDecoration(border: InputBorder.none, counterText: '', fillColor: Colors.transparent, hintText: '确认安全密码', hintStyle: TextStyles().textGrey14),
          )),
      Gaps.vGap15,
      Text('安全密码不能为空, 必须是6-12位', style: TextStyles().textTheme12),
      Gaps.vGap10,
      Text('私钥', style: TextStyles().textGrey12),
      Gaps.vGap10,
      Container(
          padding: EdgeInsets.only(left: dp(12), right: dp(12)),
          alignment: Alignment.topLeft,
          height: dp(100),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
          child: TextField(
            controller: codeController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyles().textBlack14,
            obscureText: true,
            decoration: InputDecoration(border: InputBorder.none, counterText: '', fillColor: Colors.transparent, hintText: '输入私钥或助记词', hintStyle: TextStyles().textGrey14),
          )),
    ]);
  }

  submit() {
    if (nameController.text.trim() == '') {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '请输入钱包名称');
      return;
    }
    if (password1Controller.text.trim() == '') {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qsrmm}");
      return;
    }
    if (password1Controller.text.length < 6) {
      showToast('密码长度不能小于6位');
      return;
    }
    if (password2Controller.text != password1Controller.text) {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "${getString().qzrsrxtmm}");
      return;
    }
    if (codeController.text.trim() == '') {
      Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '输入私钥或助记词');
      return;
    }

    walletEntity.name = nameController.text;
    walletEntity.password = password1Controller.text;
    walletEntity.network = widget.bundle.getString('network');

    bool isPropose = false;

    if (codeController.text.split(' ').length == 12) isPropose = true;

    showLoadingDialog();

  }
}
