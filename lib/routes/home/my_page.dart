import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/appConfig.dart';
import 'package:mars/widgets/dialog/system_update_dialog.dart';
import 'package:package_info/package_info.dart';

//我的
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  String version = '';

  @override
  void initState() {
    super.initState();
    initEvent();
    getVersion();
  }

  initEvent() async {
    //判断如果没激活就查用户更新状态
    if (GlobalTransaction.walletInfo == null || GlobalTransaction.walletInfo.is_activation != '1') {
      EventBus().on('isActivation', ({arg}) {
        setState(() {});
      });
      EventBus().on('refreshMy', ({arg}) {
        getIsActivation();
      });
      getIsActivation();
    }
  }

  //获取是否激活
  getIsActivation() {
    if (mounted) setState(() {});
    Net().post(ApiTransaction.ACCOUNTS_BALANCE, {'accounts': GlobalTransaction.walletInfo.account_id}, success: (data) {
      data['accounts'].forEach((element) {
        if (element['address'] == '') return;
        GlobalTransaction.setWalletInfo(element['address'], isActivation: element['is_active'], balance: element['value']);
      });
      if (mounted) setState(() {});
    }, failure: (error) {});
    // if (LayoutUtil.isLogin(context, isShowLogin: false)) {
    //   RippleWebSocket.on(({arg}) {
    //     if (!mounted) return;
    //     if (arg['id'] == 'my_account_info') {
    //       if (arg['status'] != 'error') {
    //         Global.setWalletInfo(Global.walletInfo.account_id, isActivation: '1');
    //         setState(() {});
    //       }
    //     }
    //   });
    //
    //   RippleWebSocket().accountInfo(Global.walletInfo.account_id, id: 'my_account_info');
    // }
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + ScreenUtil().setWidth(64)),
              // padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight + ScreenUtil().setWidth(10), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('my_waves')), fit: BoxFit.fill)),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        if (!GlobalTransaction.isLogin) {
                          Navigator.pushNamed(context, PageTransactionRouter.login_Page);
                        }
                      },
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              InkResponse(
                                  onTap: () {
                                    if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.address_manage_page);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(24)),
                                    child: ClipOval(child: LoadImage('ic_launcher2', width: ScreenUtil().setWidth(100), height: ScreenUtil().setWidth(100))),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GlobalTransaction.isLogin
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(GlobalTransaction.walletInfo.wallet_name, style: TextStyles.textWhite18.copyWith(fontWeight: FontWeight.bold)),
                                            Gaps.hGap8,
                                            InkWell(
                                              child: Row(mainAxisSize: MainAxisSize.min, children: [LoadImage('icon_am_copy', width: ScreenUtil().setWidth(22)), Gaps.hGap2, Text('复制地址', style: TextStyles.textWhite11)]),
                                              onTap: () {
                                                Clipboard.setData(new ClipboardData(text: GlobalTransaction.walletInfo.account_id));
                                                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                                              },
                                            ),
                                          ],
                                        )
                                      : Text('请先创建地址', style: TextStyles.textWhite18.copyWith(fontWeight: FontWeight.bold)),
                                  Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(17))),
                                  Text(GlobalTransaction.isLogin ? GlobalTransaction.walletInfo.account_id : '${getString().zwsj}', style: TextStyles.textWhite11),
                                ],
                              )
                            ],
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: InkResponse(
                                  onTap: () {
                                    if (LayoutUtil.isLogin(context, isShowLogin: true)) LayoutUtil.isActivation(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: ScreenUtil().setWidth(48),
                                    width: ScreenUtil().setWidth(170),
                                    decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage(!GlobalTransaction.isLogin || GlobalTransaction.walletInfo.is_activation != '1' ? 'assets/yijihuo.png' : 'assets/weijihuo.png'))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        LoadImage('icon_activation', width: ScreenUtil().setWidth(28), height: ScreenUtil().setWidth(30)),
                                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(16))),
                                        Text(!GlobalTransaction.isLogin || GlobalTransaction.walletInfo.is_activation != '1' ? '未激活' : '已激活', style: TextStyles.textWhite12)
                                      ],
                                    ),
                                  )))
                        ],
                      )),
                  // Gaps.vGap15,
                  // Global.walletInfo == null || Global.walletInfo.is_activation == '1'
                  //     ? Container()
                  //     : Container(
                  //         padding: EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60)),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //                 child: GestureDetector(
                  //                     onTap: () {
                  //                       Clipboard.setData(new ClipboardData(text: Global.walletInfo.account_id));
                  //                       Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '地址已${getString().fzcg}，快去发送给朋友吧！');
                  //                     },
                  //                     child: Container(
                  //                       alignment: Alignment.center,
                  //                       margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                  //                       decoration: BoxDecoration(color: Color(0xFFD5A44B), borderRadius: BorderRadius.circular(6)),
                  //                       height: ScreenUtil().setWidth(60),
                  //                       child: Text('找朋友激活', style: TextStyles.textWhite12),
                  //                     ))),
                  //             Gaps.hGap30,
                  //             Expanded(
                  //                 child: GestureDetector(
                  //               child: Container(
                  //                 // alignment: Alignment.center,
                  //                 // margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                  //                 // decoration: BoxDecoration(color: Color(0xFF3C3224), borderRadius: BorderRadius.circular(6)),
                  //                 // height: ScreenUtil().setWidth(60),
                  //                 // child: Text('系统激活', style: TextStyles.textWhite12),
                  //               ),
                  //               onTap: () {
                  //                 // LayoutUtil.showLoadingDialog(context);
                  //                 // Net().post(Api.PAYMENT_ACTIVE, {'type': 2, 'to': Global.walletInfo.account_id}, success: (data) {
                  //                 //   Global.walletInfo.is_activation = '1';
                  //                 //   Global.setWalletInfo(Global.walletInfo.account_id, isActivation: '1');
                  //                 //   setState(() {});
                  //                 //   LayoutUtil.closeLoadingDialog(context);
                  //                 //
                  //                 //   Global.refreshWalletAssets();
                  //                 //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '激活成功');
                  //                 // }, failure: (error) {
                  //                 //   LayoutUtil.closeLoadingDialog(context);
                  //                 //   Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                  //                 // });
                  //               },
                  //             ))
                  //           ],
                  //         )),
                  Gaps.vGap10,
                ],
              )),
          Container(
            color: Colours.colorF5,
            height: ScreenUtil().setWidth(16),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(4)),
              height: ScreenUtil().setWidth(92),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [LoadImage('icon_activation_miner', width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40)), Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))), Text('激活矿工', style: TextStyles.textBlack14)],
                  ),
                  LoadImage(
                    'icon_goto',
                    width: ScreenUtil().setWidth(25),
                    height: ScreenUtil().setWidth(24),
                  )
                ],
              ),
            ),
            onTap: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.activation_miner_page);
            },
          ),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
          InkWell(
              onTap: () {
                if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.list_of_miners_page);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [LoadImage('icon_miner_list', width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40)), Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))), Text('矿工列表', style: TextStyles.textBlack14)],
                    ),
                    LoadImage('icon_goto', width: ScreenUtil().setWidth(25), height: ScreenUtil().setWidth(24))
                  ],
                ),
              )),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(4)),
              height: ScreenUtil().setWidth(92),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [LoadImage('icon_wallet_manage', width: ScreenUtil().setWidth(40), height: ScreenUtil().setWidth(40)), Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))), Text('钱包账户管理', style: TextStyles.textBlack14)],
                  ),
                  LoadImage('icon_goto', width: ScreenUtil().setWidth(25), height: ScreenUtil().setWidth(24))
                ],
              ),
            ),
            onTap: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.address_manage_page);
            },
          ),
          Container(
            color: Colours.colorF5,
            height: ScreenUtil().setWidth(16),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(4)),
              height: ScreenUtil().setWidth(92),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LoadImage(
                        'icon_modify_pwd',
                        width: ScreenUtil().setWidth(40),
                        height: ScreenUtil().setWidth(40),
                      ),
                      Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                      Text('修改钱包密码', style: TextStyles.textBlack14)
                    ],
                  ),
                  LoadImage(
                    'icon_goto',
                    width: ScreenUtil().setWidth(25),
                    height: ScreenUtil().setWidth(24),
                  )
                ],
              ),
            ),
            onTap: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.modify_wallet_pwd_page);
            },
          ),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(4)),
              height: ScreenUtil().setWidth(92),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LoadImage(
                        'icon_reset_pwd',
                        width: ScreenUtil().setWidth(40),
                        height: ScreenUtil().setWidth(40),
                      ),
                      Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                      Text('重置钱包密码', style: TextStyles.textBlack14)
                    ],
                  ),
                  LoadImage(
                    'icon_goto',
                    width: ScreenUtil().setWidth(25),
                    height: ScreenUtil().setWidth(24),
                  )
                ],
              ),
            ),
            onTap: () {
              if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.reset_wallet_pwd_page);
            },
          ),
          Container(
            color: Colours.colorF5,
            height: ScreenUtil().setWidth(16),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageTransactionRouter.webview_page, arguments: Bundle()..putString('titleName', '客服')..putString('url', 'http://kefu.eaec.ink/addons/kefu/index/mobile?fixed_csr=0'));
            },
            child: Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(4)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadAssetImage(
                          'my_kefu',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                          color: Colours.themeColor,
                          format: 'jpg',
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                        Text('客服', style: TextStyles.textBlack14)
                      ],
                    ),
                    Row(
                      children: [
                        Text('', style: TextStyles.text757CB224),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                        LoadImage(
                          'icon_goto',
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setWidth(24),
                        ),
                      ],
                    )
                  ],
                )),
          ),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, PageRouter.webview_page, arguments: Bundle()..putString('titleName', 'THC官网')..putString('url', 'https://www.eaec.ink/'));
              Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '敬请期待');
            },
            child: Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(4)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadImage(
                          'icon_gw',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                        Text('官网', style: TextStyles.textBlack14)
                      ],
                    ),
                    Row(
                      children: [
                        Text('', style: TextStyles.text757CB224),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                        LoadImage(
                          'icon_goto',
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setWidth(24),
                        ),
                      ],
                    )
                  ],
                )),
          ),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
          InkWell(
              onTap: () {
                // Navigator.pushNamed(context, PageRouter.webview_page, arguments: Bundle()..putString('titleName', '区块链浏览器')..putString('url', '${Api.BASE_URL}explorer/index.html'));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadImage(
                          'icon_browser',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                        Text('区块链浏览器', style: TextStyles.textBlack14)
                      ],
                    ),
                    Row(
                      children: [
                        Text('', style: TextStyles.text757CB224),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                        LoadImage(
                          'icon_goto',
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setWidth(24),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageTransactionRouter.share_page);
              },
              child: Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(4)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadImage(
                          'icon_app_download',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                        Text('APP下载', style: TextStyles.textBlack14)
                      ],
                    ),
                    LoadImage(
                      'icon_goto',
                      width: ScreenUtil().setWidth(25),
                      height: ScreenUtil().setWidth(24),
                    )
                  ],
                ),
              )),
          Container(
            color: Colours.colorF5,
            height: ScreenUtil().setWidth(16),
          ),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageTransactionRouter.webview_page, arguments: Bundle()..putString('titleName', '开源地址')..putString('url', 'https://github.com/thclabopensource/THCChain'));
                // Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '敬请期待');
              },
              child: Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(4)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadImage(
                          'icon_open_source',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                        Text('开源地址', style: TextStyles.textBlack14)
                      ],
                    ),
                    Row(
                      children: [
                        Text('', style: TextStyles.text757CB224),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                        LoadImage(
                          'icon_goto',
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setWidth(24),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
          InkWell(
              onTap: () {
                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '敬请期待');
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadImage(
                          'icon_community',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                        Text('开发者部落', style: TextStyles.textBlack14)
                      ],
                    ),
                    Row(
                      children: [
                        Text('', style: TextStyles.text757CB224),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                        LoadImage(
                          'icon_goto',
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setWidth(24),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Container(
            color: Colours.color0D000000,
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          ),
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
                      showToast('该版本已是最新版本');
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
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(4)),
                height: ScreenUtil().setWidth(92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadImage(
                          'icon_version',
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                        Text('版本号', style: TextStyles.textBlack14)
                      ],
                    ),
                    Text('$version', style: TextStyles.textGrey14),
                  ],
                ),
              )),
        ],
      ),
      backgroundColor: Colours.background,
    );
  }
}
