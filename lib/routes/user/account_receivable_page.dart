import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:qr_flutter/qr_flutter.dart';

//收账
class AccountReceivablePage extends StatefulWidget {
  final Bundle bundle;

  AccountReceivablePage(this.bundle);

  @override
  _AccountReceivablePageState createState() => _AccountReceivablePageState();
}

class _AccountReceivablePageState extends State<AccountReceivablePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LoadImage('account_bg', fit: BoxFit.fill, width: double.infinity, height: double.infinity),
          ListView(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(200)),
            children: [
              Container(
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('account_zg_bg')), fit: BoxFit.fill)),
                height: ScreenUtil().setWidth(850),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Gaps.vGap25,
                    Text('${getString().smxwfk}', style: TextStyles.textBlack18.copyWith(fontWeight: FontWeight.w500)),
                    Gaps.vGap25,
                    Center(child: QrImage(padding: EdgeInsets.zero, data: '${GlobalTransaction.walletInfo.account_id}', size: ScreenUtil().setWidth(440), backgroundColor: Colors.white)),
                    Gaps.vGap50,
                    Text('${GlobalTransaction.walletInfo.account_id}', style: TextStyles.textBlack12),
                    Gaps.vGap10,
                    InkWell(
                        onTap: () {
                          Clipboard.setData(new ClipboardData(text: GlobalTransaction.walletInfo.account_id));
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colours.themeColor,borderRadius: BorderRadius.all(Radius.circular(44))),
                          alignment: Alignment.center,
                          height: ScreenUtil().setWidth(70),
                          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                          margin: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
                          child: Text('${getString().fzskm}', style: TextStyles.textWhite12),
                        ))
                  ],
                ),
              ),
              Gaps.vGap25,
              Container(
                decoration: BoxDecoration(color: Colours.colorF6, borderRadius: BorderRadius.all(Radius.circular(6))),
                height: ScreenUtil().setWidth(88),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadImage('logo_x', width: ScreenUtil().setWidth(40)),
                    Gaps.hGap8,
                    Expanded(
                        child: InkWell(
                      child: Text('${getString().skljl}', style: TextStyles.textGrey614),
                      onTap: () {
                        Navigator.pushNamed(context, PageTransactionRouter.account_book_page);
                      },
                    )),
                    LoadImage('y_break', width: ScreenUtil().setWidth(24), height: ScreenUtil().setWidth(30)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight, right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(10)),
              child: Stack(
                children: [
                  CupertinoButton(
                    child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(44), fit: BoxFit.contain, color: Colours.white),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pop(context);
                    },
                  ),
                  Align(alignment: Alignment.topCenter, child: Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(15)), child: Text('${getString().skm}', style: Styles.textTitle.copyWith(fontWeight: FontWeight.w500, color: Colours.white)))),
                  // GestureDetector(
                  //   child: Text('', style: TextStyles.textWhite16),
                  //   onTap: () {
                  //   },
                  // ),
                ],
              )),
        ],
      ),
    );
  }
}
