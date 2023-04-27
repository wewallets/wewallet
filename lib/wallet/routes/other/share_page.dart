import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mars/wallet/common/component_index.dart';

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends BaseState<SharePage> {
  TextEditingController couponController = new TextEditingController();
  String coupon;

  @override
  Widget get appBar => getAppBar('${s.text207}'.toUpperCase());

  @override
  Color get backgroundColor => Colours().white;

  @override
  void initState() {
    super.initState();
    getCoupon();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(dp(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        coupon == null || coupon == '' ? Container() : Text('$coupon', style: TextStyles().textBlack15),
        coupon == null || coupon == '' ? Container() : Gaps.vGap12,
        coupon == null || coupon == '' ? Container() : Lines().line,
        coupon != null && coupon != ''
            ? Container()
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colours().white,
                      child: TextField(
                        autofocus: false,
                        controller: couponController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(color: Colours().textTheme1, fontSize: textDp(16)),
                        cursorColor: Colours().textTheme1,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${s.text428}', hintStyle: TextStyle(color: Colours().colorFFA8A8A8, fontSize: textDp(16))),
                      ),
                    ),
                  ],
                ),
              ),
        Lines().line,
        Expanded(child: Container()),
        coupon != null && coupon != ''
            ? Container()
            :  Buttons.getDetermineButton(
          onPressed: () {
            submit();
          },
          buttonText: '${s.text12}'.toUpperCase(),
        ),
      ]),
    );
  }

  getCoupon() {
    // Net().post(Api.user_parent, null, success: (data) {
    //   coupon = data['coupon'];
    //   setState(() {});
    // });
  }

  submit() {
    // if (couponController.text.length == 0) {
    //   showToast('${s.text429}');
    //   return;
    // }
    // showLoadingContextDialog(context);
    // Net().post(Api.user_bind_parent, {'coupon': couponController.text}, success: (data) {
    //   closeLoadingContextDialog(context);
    //   showToast('${s.text340}');
    //   setState(() {});
    // }, failure: (error) {
    //   closeLoadingContextDialog(context);
    //   showToast(error);
    // });
  }
}
