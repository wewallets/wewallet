import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/generated/l10n.dart';
import 'package:mars/models/appConfig.dart';
import 'package:mars/widgets/dialog/system_update_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> with TickerProviderStateMixin {
  String version = '';
  String coupon;

  @override
  void initState() {
    super.initState();
    getEmail();
    getVersion();
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      body: ListView(
        padding: EdgeInsets.only(bottom: adaptationDp(50)),
        children: <Widget>[
          Container(
            height: adaptationDp(159),
            width: double.infinity,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/cc1_waves.png'))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gaps.vGap20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gaps.hGap10,
                    LoadImage('menu_head', width: adaptationDp(60)),
                    Gaps.hGap10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${GlobalTransaction.walletInfo == null ? '${getString().qingxiandenglu}' : 'HI,${GlobalTransaction.walletInfo.wallet_name}'}', style: TextStyles.textWhite14),
                        !GlobalTransaction.isLogin
                            ? Container()
                            : inkButton(
                                onPressed: () {
                                  Clipboard.setData(new ClipboardData(text: GlobalTransaction.walletInfo.account_id));
                                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().fzcg}');
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(top: adaptationDp(10), bottom: adaptationDp(10)),
                                    child: Row(children: [Text('${GlobalTransaction.walletInfo == null ? '' : GlobalTransaction.walletInfo.account_id}', style: TextStyles.textWhite10), Gaps.hGap2, LoadAssetImage('icon_am_copy', width: ScreenUtil().setWidth(22), color: Colours.white)]))),
                        coupon == null || coupon == ''
                            ? Container()
                            : inkButton(
                                onPressed: () {
                                  Clipboard.setData(new ClipboardData(text: coupon));
                                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().fzcg}');
                                },
                                child: Padding(padding: EdgeInsets.only(bottom: adaptationDp(10)), child: Row(children: [Text('$coupon', style: TextStyles.textWhite10), Gaps.hGap2, LoadAssetImage('icon_am_copy', width: ScreenUtil().setWidth(22), color: Colours.white)])))
                      ],
                    ),
                  ],
                ),
                Gaps.vGap10,
                GlobalTransaction.walletInfo == null || GlobalTransaction.walletInfo.is_activation == '1'
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)),
                        height: adaptationDp(30),
                        child: Row(children: [
                          inkButton(
                              onPressed: () {
                                Clipboard.setData(new ClipboardData(text: GlobalTransaction.walletInfo.account_id));
                                Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${getString().fzcg}');
                              },
                              child: Container(
                                width: adaptationDp(120),
                                height: adaptationDp(30),
                                decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(3))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LoadAssetImage('pyjh', width: adaptationDp(22)),
                                    Gaps.hGap5,
                                    Text('${getString().zhaopengyoujihuo}', style: TextStyles.textBlack15.copyWith(color: Color(0xFF1B308F))),
                                  ],
                                ),
                              )),
                          Gaps.hGap15,
                          Container(),
                          // inkButton(
                          //     onPressed: () {
                          //       LayoutUtil.showLoadingDialog(context);
                          //       Net().post(Api.PAYMENT_ACTIVE, {'type': 2, 'to': Global.walletInfo.account_id}, success: (data) {
                          //         Global.walletInfo.is_activation = '1';
                          //         Global.setWalletInfo(Global.walletInfo.account_id, isActivation: '1');
                          //         setState(() {});
                          //         LayoutUtil.closeLoadingDialog(context);
                          //
                          //         Global.refreshWalletAssets();
                          //         Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().jhcg}');
                          //       }, failure: (error) {
                          //         LayoutUtil.closeLoadingDialog(context);
                          //         Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                          //       });
                          //     },
                          //     child: Container(
                          //       width: adaptationDp(120),
                          //       height: adaptationDp(30),
                          //       decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.circular(adaptationDp(3))),
                          //       child: Row(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           LoadAssetImage('ptjh', width: adaptationDp(22)),
                          //           Gaps.hGap5,
                          //           Text('${getString().pingtaijihuo}', style: TextStyles.textBlack15.copyWith(color: Color(0xFF1B308F))),
                          //         ],
                          //       ),
                          //     ))
                        ])),
              ],
            ),
          ),
          inkButton(
            onPressed: () {
              if (!GlobalTransaction.isLogin || GlobalTransaction.email == null || GlobalTransaction.email.length == 0) if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.bind_email_page);
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_gywm', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().bangdingyx}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    (!GlobalTransaction.isLogin || (GlobalTransaction.email == null || GlobalTransaction.email.length == 0)) ? LoadAssetImage('youjiantou', width: adaptationDp(22)) : Text('${getString().yibangd}', style: TextStyles.textGrey13),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true))
                Navigator.pushNamed(context, PageTransactionRouter.address_manage_page).then((value) {
                  setState(() {});
                });
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_qbgl', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().qianbaogli}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.subordinate_digital_storage_page);
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_kglb', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${s.text16}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.modify_wallet_pwd_page);
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_xgmm', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().xgqbmm}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.reset_wallet_pwd_page);
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_czmm', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().czqbmm}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () async {
              if (Platform.isIOS) {
                await launch('${ApiTransaction.BASE_URL}explorer/index.html');
                // Navigator.pushNamed(context, PageRouter.webview_page,
                //     arguments: Bundle()
                //       ..putString('titleName', '${getString().qklllq}')
                //       ..putString('url', '${Api.BASE_URL}explorer/index.html')
                //       ..putString('type', '1'));
              } else {
                Navigator.pushNamed(context, PageTransactionRouter.webview2_page,
                    arguments: Bundle()
                      ..putString('titleName', '${getString().qklllq}')
                      ..putString('url', '${ApiTransaction.BASE_URL}explorer/index.html')
                      ..putString('type', '1'));
              }
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_qkllq', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().qklllq}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              switchLanguage();
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_qhyy', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().yuyan}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              Navigator.pushNamed(context, PageTransactionRouter.share_page);
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_xza', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().appxz}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              showLoadingContextDialog(context);
              Net().post(ApiTransaction.GET_APP_CONFIG, null, success: (data) async {
                closeLoadingContextDialog(context);

                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                var appConfig = AppConfig.fromJson(data);
                if (Platform.isAndroid) {
                  if (appConfig.version_no != null && double.parse(appConfig.version_no) > double.parse(packageInfo.buildNumber)) {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return SystemUpdateDialog(appConfig);
                        });
                  } else {
                    showToast('${getString().gaibbyjzxbb}');
                  }
                } else if (Platform.isIOS) {
                  if (appConfig.ios_version_no != null && double.parse(appConfig.ios_version_no) > double.parse(packageInfo.buildNumber)) {
                    // showDialog(
                    //     context: context,
                    //     builder: (builder) {
                    //       return VersionUpdateDialog(appConfig.forced_update, appConfig.ios_version, appConfig.tiltle, appConfig.content, appConfig.android_addr, appConfig.ios_addr);
                    //     });
                  }
                }
              }, failure: (error) {
                closeLoadingContextDialog(context);
                showToast('$error');
              });
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_dqbb', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().dangqbbh} $version', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
          inkButton(
            onPressed: () {
              GlobalTransaction.isWsOnHttp = !GlobalTransaction.isWsOnHttp;
              SpUtil.putBool('isWsOnHttp', GlobalTransaction.isWsOnHttp);
              Navigator.pushReplacementNamed(context, PageTransactionRouter.new_main_page);
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: adaptationDp(15), bottom: adaptationDp(15), left: adaptationDp(15)),
                child: Row(
                  children: [
                    LoadAssetImage('h_xza', width: adaptationDp(22)),
                    Gaps.hGap10,
                    Text('${getString().xtj14}', style: TextStyles.textGrey616.copyWith(color: Color(0xFF97A2AF))),
                    Expanded(child: Container()),
                    Text('${getString().xtj15}${GlobalTransaction.isWsOnHttp ? 1 : 2}', style: TextStyles.textBlack14),
                    LoadAssetImage('youjiantou', width: adaptationDp(22)),
                    Gaps.hGap10,
                  ],
                )),
          ),
          Container(height: adaptationDp(0.5), color: Color(0xFFF2F2F2), width: double.infinity),
        ],
      ),
    );
  }

  switchLanguage() {
    List<String> list = ['简体中文', 'English', 'ไทย', 'Bahasa Melayu'];
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext contexts) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  Expanded(
                      child: new GestureDetector(
                    child: new Container(),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(child: Container(alignment: Alignment.center, padding: EdgeInsets.only(left: 20), child: Text('${getString().qxzyy}', style: TextStyles.textBlack18))),
                            InkResponse(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                child: LoadAssetImage(Images.combined_shape_26671, width: ScreenUtil().setWidth(30)),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    switch (index) {
                                      case 0:
                                        S.load(Locale('zh'));
                                        SpUtil.putString('locale', 'zh');
                                        break;
                                      case 1:
                                        S.load(Locale('en'));
                                        SpUtil.putString('locale', 'en');
                                        break;
                                      case 2:
                                        S.load(Locale('th'));
                                        SpUtil.putString('locale', 'th');
                                        break;
                                      case 3:
                                        S.load(Locale('ms'));
                                        SpUtil.putString('locale', 'ms');
                                        break;
                                    }
                                    Navigator.pushReplacementNamed(context, PageTransactionRouter.new_main_page);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                    alignment: Alignment.center,
                                    child: Text(list[index], style: TextStyles.textBlack14),
                                  ));
                            },
                            itemCount: list.length)
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  getEmail() {
    if (!GlobalTransaction.isLogin) return;
    Net().post(ApiTransaction.email_info, {}, success: (data) {
      SpUtil.putString('email${GlobalTransaction.walletInfo.account_id}', data['email']);
      setState(() {});
    });
    Net().post(ApiTransaction.collection_child_info, {}, success: (data) {
      coupon = data['coupon'];
      setState(() {});
    });
  }
}
