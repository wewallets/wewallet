import 'dart:io';

import 'package:mars/common/transaction_component_index.dart';

import '../../common/base/base_state.dart';

class BindingDigitalStoragePage extends StatefulWidget {
  final Bundle bundle;

  BindingDigitalStoragePage(this.bundle);

  @override
  _BindingDigitalStoragePageState createState() => _BindingDigitalStoragePageState();
}

class _BindingDigitalStoragePageState extends BaseState<BindingDigitalStoragePage> {
  TextEditingController couponController = new TextEditingController();

  @override
  Widget get appBar => getAppBar('${s.text4}');
  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.all(dp(12)), child: Text('${s.text5}', style: TextStyles.textWhite14)),
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
                          controller: couponController,
                          style: TextStyles.textWhite14,
                          cursorColor: Colours.white,
                          decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.text6}', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textWhite14),
                        ))),
              ],
            )),
        Padding(padding: EdgeInsets.all(dp(12)), child: Text('${s.text8}', style: TextStyles.textWhite14)),
        Padding(
            padding: EdgeInsets.only(left: dp(12)),
            child: Text('${s.text7}', style: TextStyles.textGrey612)),
        Expanded(child: Container()),
        inkButton(
          onPressed: () {
            submit();
          },
          child: Container(
              margin: EdgeInsets.only(bottom: dp(30),left: dp(12),right: dp(12)), width: double.infinity, decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill)), height: dp(60), alignment: Alignment.center, child: Text('确认提交', style: TextStyles.textBlack18)),
        )
      ],
    );
  }

  submit() {
    if (couponController.text.length == 0) {
      showToast('${s.text6}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.collection_bind, {'coupon': couponController.text}, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      Navigator.pop(context);
      showToast('${s.text9}');
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }
}
