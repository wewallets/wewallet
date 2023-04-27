import 'package:mars/common/transaction_component_index.dart';

//申请上币
class OperatedSubscriptionPage extends StatefulWidget {
  @override
  _OperatedSubscriptionPageState createState() => _OperatedSubscriptionPageState();
}

class _OperatedSubscriptionPageState extends State<OperatedSubscriptionPage> {
  TextEditingController text1Controller = new TextEditingController();
  TextEditingController text2Controller = new TextEditingController();
  TextEditingController text3Controller = new TextEditingController();
  TextEditingController text4Controller = new TextEditingController();
  TextEditingController text5Controller = new TextEditingController();
  TextEditingController text6Controller = new TextEditingController();
  TextEditingController text7Controller = new TextEditingController();
  TextEditingController text8Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: LayoutUtil.getAppBar(context, '上币申请'),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/bitianbg.png'))),
            child: Text('*号为必填项', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22))),
            height: ScreenUtil().setWidth(34),
          ),
          Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gaps.vGap20,
                  Row(children: [Text('联系人姓名', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text1Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入姓名', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Row(children: [Text('联系人手机号', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text2Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入手机号', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Row(children: [Text('币种中(英)文名称', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text3Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入币种名称', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Row(children: [Text('总发行量', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text4Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入发行量', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Row(children: [Text('市场已流通', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text5Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入已流通币种数量', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Row(children: [Text('社区用户量', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text6Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入已有社区用户量', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Row(children: [Text('营销预算', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text7Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入预算', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Row(children: [Text('官网或钱包地址', style: TextStyles.textBlack14), Text('*', style: TextStyle(color: Color(0xFFFFC01B), fontSize: ScreenUtil().setWidth(22)))]),
                  Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all(width: 0.5, color: Color(0x26000000))),
                      height: ScreenUtil().setWidth(80),
                      child: TextField(
                        controller: text8Controller,
                        style: TextStyles.textBlack14,
                        cursorColor: Colours.textBlack,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入地址', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
                      )),
                  Gaps.vGap25,
                  Buttons.getDetermineButton(
                      isUse: true,
                      buttonText: '提交',
                      voidCallback: () {
                        submit();
                      }),
                  Gaps.vGap50,
                ],
              )),
        ],
      ),
    );
  }

  submit() {
    if (text1Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入姓名');
      return;
    }
    if (text2Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入手机号');
      return;
    }
    if (text3Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入币种名称');
      return;
    }
    if (text4Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入发行量');
      return;
    }
    if (text5Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入已流通币种数量');
      return;
    }
    if (text6Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入已有社区用户量');
      return;
    }
    if (text7Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入预算');
      return;
    }
    if (text8Controller.text.length == 0) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请输入地址');
      return;
    }
    Net().post(ApiTransaction.WALLET_APPLY, {
      'contact_name': text1Controller.text,
      'telphone': text2Controller.text,
      'currency_name': text3Controller.text,
      'subscribe_total': text4Controller.text,
      'market_total': text5Controller.text,
      'community_user': text6Controller.text,
      'market_budget': text7Controller.text,
      'web_address': text8Controller.text,
    }, success: (data) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '申请成功，等待审核。');
      Navigator.pop(context);
    }, failure: (error) {
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
    });
  }
}
