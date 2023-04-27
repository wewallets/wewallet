import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:event/src/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mars/common/global.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:mars/wallet/mobels/assets_entity.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import '../../../common/router/pageRouter.dart';
import '../../../common/utils.dart' as transactionUtils;
import '../../common/utils/sign_client_constants.dart';
import '../../widgets/dialog/choose_wallet_dialog.dart';
import '../../widgets/dialog/select_country_dialog.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseAliveState<HomePage> {
  RefreshController refreshController = RefreshController();
  AssetsEntity assetsEntity;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (Global.isLogin) getData(isRefresh: true);

    EventBus().on('switchWallet', ({arg}) {
      isLoading = true;
      setState(() {});

      getData(isRefresh: false);
    });
    initWeb3Wallet();
  }

  @override
  void dispose() {
    EventBus().off('switchWallet');
    super.dispose();
  }

  @override
  Color get backgroundColor => Color(0xFF6840F7);

  @override
  Widget get appBar =>
      !Global.isLogin
          ? null
          : getAppBar('钱包', colors: Color(0xFF6840F7),
          leading: 'home_gd',
          onPressed: () {},
          textColor: Colours().white,
          actions: [
            Row(
              children: [
                inkButton(
                    child: LoadImage('home_erweima', width: dp(24)),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (Platform.isAndroid) {
                        await Permission.camera.request().then((value) {
                          if (value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
                            Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${s.text66}');
                            return;
                          }
                        });
                      }
                      showDialog(
                          context: context,
                          builder: (context) =>
                              SelectCountryDialog(0, (data) async {
                                var rest;
                                try {
                                  if (data == '相机') {
                                    final result = await BarcodeScanner.scan();
                                    if (result.rawContent == '' || result.rawContent == null) return;
                                    rest = result.rawContent;
                                  } else {
                                    var image = await ImagePicker().getImage(source: ImageSource.gallery);
                                    if (image == null) return;
                                    if (await FlutterQrReader.imgScan(image.path) == '') return;
                                    rest = await FlutterQrReader.imgScan(image.path);
                                  }
                                  if (rest != null && rest != '') {
                                    if (isLogin()) {
                                      //wc:cbed9f9b-1206-4303-9cb1-afc07bb460e1@1?bridge=https%3A%2F%2F5.bridge.walletconnect.org&key=987474adcbdbc066c98571a1047cffea0f64c4c85c473bfff289e36c9cd1a874
                                      // web3ScanCode(rest);
                                      walletConnect(rest);
                                    }
                                  } else {
                                    showToast('加载失败 ' + rest);
                                  }
                                } catch (e) {
                                  showToast('加载失败');
                                }
                              }, ['相机', '相册']));
                      return;

                      FocusScope.of(context).requestFocus(FocusNode());
                      if (Platform.isAndroid) {
                        await Permission.camera.request().then((value) {
                          if (value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
                            Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '${s.text66}');
                            return;
                          }
                        });
                      }
                      // if (Platform.isAndroid) {
                      //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                      //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                      //   if (androidInfo.version.sdkInt <= 23) {
                      //     showDialog(
                      //         context: context,
                      //         builder: (context) =>
                      //             ScanViewSheetDialog((data) {
                      //               if (data != null && data != '') getSpellCheck(data);
                      //             }));
                      //     return;
                      //   }
                      // }

                      showDialog(
                          context: context,
                          builder: (context) =>
                              SelectCountryDialog(0, (data) async {
                                var rest;
                                try {
                                  if (data == '${s.text68}') {
                                    final result = await BarcodeScanner.scan();
                                    if (result.rawContent == '' || result.rawContent == null) return;
                                    rest = result.rawContent;
                                  } else {
                                    var image = await ImagePicker().getImage(source: ImageSource.gallery);
                                    if (image == null) return;
                                    if (await FlutterQrReader.imgScan(image.path) == '') return;
                                    rest = await FlutterQrReader.imgScan(image.path);
                                  }
                                  if (rest != null && rest != '') {
                                    var spellId = rest;
                                    if (isLogin()) navigateTo(PageWalletRouter.transfer_page);
                                  } else {
                                    showToast('${s.text69}' + rest);
                                  }
                                } catch (e) {
                                  showToast('${s.text70}');
                                }
                              }, ['${s.text68}', '${s.text71}']));
                    }),
                Gaps.hGap15,
              ],
            )
          ]);

  @override
  Widget buildContent(BuildContext context) {
    return Global.isLogin
        ? SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: true,
        onRefresh: () {
          if (Global.isLogin) getData(isRefresh: true);
        },
        child: ListView(padding: EdgeInsets.zero, children: [
          buildWallet,
          // buildModular,
          buildModularNew,
          buildAssets,
        ]))
        : Container(
      padding: EdgeInsets.only(top: dp(160), left: dp(25), right: dp(25)),
      color: Colours().background,
      child: Column(
        children: [
          LoadImage('error_myqb', width: dp(285)),
          Gaps.vGap50,
          Gaps.vGap50,
          inkButton(
              onPressed: () {
                navigateToContext(context, PageWalletRouter.select_chain_page, bundle: Bundle()
                  ..putInt('type', 1));
              },
              child: Container(
                decoration: BoxDecoration(color: Colours().themeColor, borderRadius: BorderRadius.circular(dp(30))),
                width: double.infinity,
                height: dp(60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadImage('home_qbxs', width: dp(20), height: dp(20)),
                    Gaps.hGap8,
                    Text('我有钱包', style: TextStyles().textWhite16),
                  ],
                ),
              )),
          Gaps.vGap20,
          inkButton(
              onPressed: () {
                navigateToContext(context, PageWalletRouter.select_chain_page, bundle: Bundle()
                  ..putInt('type', 0));
              },
              child: Container(
                decoration: BoxDecoration(color: Color(0xFF071E56), borderRadius: BorderRadius.circular(dp(30))),
                width: double.infinity,
                height: dp(60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadImage('home_qbxs', width: dp(20), height: dp(20)),
                    Gaps.hGap8,
                    Text('我没有钱包', style: TextStyles().textWhite16),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  get buildWallet {
    return Container(
        margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
        padding: EdgeInsets.all(dp(18)),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('home_head_bg')), fit: BoxFit.fill)),
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
          inkButton(
              onPressed: Global.isLogin
                  ? null
                  : () {
                if (isLogin()) navigateTo(PageWalletRouter.wallet_management_page);
              },
              child: Row(
                children: [
                  Global.getCurrencyList() == null || Global
                      .getCurrencyList()
                      .length == 0 ? Container() : LoadImage('${Global.getCurrencyList()[0].icon}', width: dp(40), height: dp(40)),
                  Gaps.hGap10,
                  Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(Global.isLogin ? '${Global.userWallet.name}' : '未绑定钱包', style: TextStyles().textBlack14),
                    Gaps.vGap3,
                    GestureDetector(
                        onLongPress: !Global.isLogin
                            ? null
                            : () {
                          Clipboard.setData(new ClipboardData(text: Global.userWallet.wallet.address));
                          showToast('复制成功');
                        },
                        child: inkButton(
                            onPressed: () {
                              Clipboard.setData(new ClipboardData(text: Global.userWallet.wallet.address));
                              showToast('复制成功');
                            },
                            child: Row(
                              children: [
                                Text(Global.isLogin ? '${Global.userWallet.wallet.address}' : '', style: TextStyles().textGrey10),
                                Gaps.hGap2,
                                LoadImage('home_fz', width: dp(13)),
                              ],
                            ))),
                  ]),
                  Expanded(child: Container()),
                  inkButton(
                      onPressed: () {
                        if (isLogin()) showDialog(context: context, builder: (context) => ChooseWalletDialog());
                      },
                      child: LoadImage('home_qhqb', width: dp(20))),
                ],
              )),
          Gaps.vGap30,
          Text('钱包总资产', style: TextStyles().textGrey14.copyWith(color: Color(0xFF9497A4))),
          Gaps.vGap10,
          Row(
            children: [
              Text('¥ ${assetsEntity == null ? '0.00' : assetsEntity.total.totalCny}', style: TextStyles().textBlack22.copyWith(fontWeight: FontWeight.bold)),
              Expanded(child: Container()),
              // LoadImage('home_biyan', width: dp(20)),
            ],
          )
        ]));
  }

  get buildModularNew {
    return Container(
        margin: EdgeInsets.all(dp(15)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(bottom: dp(18), top: dp(18)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (isLogin()) navigateTo(PageWalletRouter.transfer_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_zz', width: dp(60), height: dp(60)),
                              Text('转账', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (isLogin()) navigateTo(PageWalletRouter.collect_money_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_sk', width: dp(60), height: dp(60)),
                              Text('收款', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (Global.userWallet.network != GlobalTransaction.coin) {
                                showToast('暂时只支持YISE链');
                                return;
                              }
                              navigateTo(PageWalletRouter.miner_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_kc', width: dp(60), height: dp(60)),
                              Text('资源管理', style: TextStyles().textBlack12),
                            ])))),
              ])),
        ]));
  }

  get buildModular {
    return Container(
        margin: EdgeInsets.all(dp(15)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(bottom: dp(18), top: dp(18)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (isLogin()) navigateTo(PageWalletRouter.transfer_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_zz', width: dp(51), height: dp(51)),
                              Text('转账', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (isLogin()) navigateTo(PageWalletRouter.collect_money_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_sk', width: dp(51), height: dp(51)),
                              Text('收款', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (Global.userWallet.network != GlobalTransaction.coin) {
                                showToast('暂时只支持YISE链');
                                return;
                              }
                              navigateTo(PageWalletRouter.miner_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_kc', width: dp(51), height: dp(51)),
                              Text('矿工', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              showToast('暂未开放');
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_hz', width: dp(51), height: dp(51)),
                              Text('划转', style: TextStyles().textBlack12),
                            ])))),
              ])),
          Padding(
              padding: EdgeInsets.only(bottom: dp(18)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (Global.userWallet.network != GlobalTransaction.coin) {
                                showToast('暂时只支持YISE链');
                                return;
                              }
                              transactionUtils.navigatorTransactionContextPush(context, PageTransactionRouter.main_page);
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_bb', width: dp(51), height: dp(51)),
                              Text('币币', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              showToast('暂未开放');
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_hy', width: dp(51), height: dp(51)),
                              Text('合约', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              showToast('暂未开放');
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_jd', width: dp(51), height: dp(51)),
                              Text('借贷', style: TextStyles().textBlack12),
                            ])))),
                Expanded(
                    child: Container(
                        child: inkButton(
                            onPressed: () {
                              if (Global.userWallet.network != GlobalTransaction.coin) {
                                showToast('暂时只支持YISE链');
                                return;
                              }
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      SelectCountryDialog(0, (data) async {
                                        if (data == '定期质押')
                                          navigateTo(PageWalletRouter.pledge_page, bundle: Bundle()
                                            ..putInt('type', 0));
                                        else
                                          navigateTo(PageWalletRouter.pledge_page, bundle: Bundle()
                                            ..putInt('type', 1));
                                      }, ['定期质押', '活期质押']));
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                              LoadImage('home_sc', width: dp(51), height: dp(51)),
                              Text('质押', style: TextStyles().textBlack12),
                            ])))),
              ])),
        ]));
  }

  get buildAssets {
    List<AssetsCurrencyList> currencyList = Global.getCurrencyList();
    return isLoading && (currencyList == null || currencyList.length == 0)
        ? Container(decoration: BoxDecoration(color: Colours().background), child: buildLoadingShadeCustom(), height: dp(300))
        : Container(
        decoration: BoxDecoration(color: Colours().white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(padding: EdgeInsets.all(dp(18)), child: Text('资产', style: TextStyles().textBlack20)),
          Lines().line,
          currencyList == null
              ? buildErrorWidget(topHeight: 100)
              : listViewBuilder(
              isSlide: true,
              padding: EdgeInsets.only(bottom: dp(200)),
              itemBuilder: (BuildContext context, int index) {
                return inkButton(
                    onPressed: () {
                      navigateTo(PageWalletRouter.transfer_record_page, bundle: Bundle()
                        ..putString('coin', currencyList[index].currencyName));
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: dp(15), right: dp(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gaps.vGap15,
                            Container(
                                child: Row(children: [
                                  LoadImage('${currencyList[index].icon}', width: dp(30), height: dp(30)),
                                  Gaps.hGap10,
                                  Text('${currencyList[index].currencyName}', style: TextStyles().textBlack16),
                                  Expanded(child: Container()),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('${currencyList[index].value}', style: TextStyles().textBlack16),
                                      Gaps.vGap2,
                                      Text('≈ ${currencyList[index].cnyValue}', style: TextStyles().textGrey12),
                                    ],
                                  )
                                ])),
                            Gaps.vGap15,
                            Lines().line,
                          ],
                        )));
              },
              itemCount: currencyList.length)
        ]));
  }

  Web3Wallet wcClient;
  int id;

  initWeb3Wallet() async {
    wcClient = await Web3Wallet.createInstance(
      relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
      projectId: '09ee486e6e6a95fc61505af06521db77',
      metadata: PairingMetadata(
        name: 'ME Wallet',
        description: 'ME Wallet',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
    );

// For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.

// dApp 发出事件
//     await wcClient.emitSessionEvent(
//       topic: '',
//       chainId: 'eip155:1',
//       event: SessionEventParams(
//         name: 'chainChanged',
//         data: 'a message!',
//       ),
//     );

//dApp 断开连接
//     await wcClient.disconnectSession(
//       topic: pairing.topic,
//       reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
//     );
//   }
  }

  String TEST_ETHEREUM_CHAIN = 'eip155:1';
  String TEST_PRIVATE_KEY_EIP191 = '0x8fd5843634d0034bd70f44c98ed23dbcfef90ef1bd14ae3a87e3ccef913a870d';
  String TEST_ADDRESS_EIP191 = '0x4739f5894122F1CE8fa979efEDa6E295619CfEDd';
  SessionData session;

  web3ScanCode(url) async {
    String TEST_ISSUER_EIP191 = 'did:pkh:$TEST_ETHEREUM_CHAIN:$TEST_ADDRESS_EIP191';

    // Listen for a auth request
    Completer signCompleter = Completer();
    Map<String, Namespace> workingNamespaces = TEST_NAMESPACES;
    wcClient.onSessionProposal.subscribe((SessionProposalEvent args) async {
      ApproveResponse response = await wcClient.approveSession(id: args.id, namespaces: workingNamespaces);
      session = response.session;
      signCompleter.complete();
      // if (sessionB == null) {
      //   print('session b was set to null');
      // }
    });

// Also setup the methods and chains that your wallet supports
    final kadenaSignV1RequestHandler = (String topic, dynamic parameters) async {
      final parsedResponse = parameters;

      bool userApproved = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign Transaction'),
            content: SizedBox(
              width: 300,
              height: 350,
              child: Text(parsedResponse.toString()),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Accept'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Reject'),
              ),
            ],
          );
        },
      );

      if (userApproved) {
        return 'Signed!';
      } else {
        throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
      }
    };
    wcClient.registerRequestHandler(
      chainId: '1001',
      method: 'kadena_sign_v1',
      handler: kadenaSignV1RequestHandler,
    );

    final authHandler = (AuthRequest args) async {
      String message = wcClient.formatAuthMessage(iss: TEST_PRIVATE_KEY_EIP191, cacaoPayload: CacaoRequestPayload.fromPayloadParams(args.payloadParams));

      String sig = EthSigUtil.signPersonalMessage(
        message: Uint8List.fromList(message.codeUnits),
        privateKey: TEST_PRIVATE_KEY_EIP191,
      );

      await wcClient.respondAuthRequest(
        id: args.id,
        iss: TEST_PRIVATE_KEY_EIP191,
        signature: CacaoSignature(t: CacaoSignature.EIP191, s: sig),
      );

      signCompleter.complete();
    };
    wcClient.onAuthRequest.subscribe(authHandler);

    // final walletNamespaces = {
    //   'eip155': Namespace(
    //     accounts: ['eip155:1:abc'],
    //     methods: ['eth_signTransaction'],
    //   ),
    //   'kadena': Namespace(
    //     accounts: ['kadena:mainnet01:abc'],
    //     methods: ['kadena_sign_v1', 'kadena_quicksign_v1'],
    //     events: ['kadena_transaction_updated'],
    //   ),
    // };
    // await wcClient.rejectSession(id: id, reason: Errors.getSdkError(Errors.USER_REJECTED_SIGN));

    final PairingInfo pairing = await wcClient.pair(uri: Uri.parse(url));
    wcClient.pairings.get(pairing.topic);
    // await wcClient.approveSession(id: id, namespaces: walletNamespaces);

  }

  walletConnect(url) async {
    final connector = WalletConnect(
      uri: url,
      clientMeta: PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: ['https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'],
      ),
    );
    // Subscribe to events
    connector.on('connect', (session) => print(session));
    connector.on('session_request', (payload) => print(payload));
    connector.on('disconnect', (session) => print(session));

    await connector.approveSession(chainId: 56, accounts: [TEST_PRIVATE_KEY_EIP191]);
    // await connector.rejectSession(message: 'Optional error message');

  }

//   walletConnectTest(scannedUriString) async {
//     Web3Wallet wcClient = await Web3Wallet.createInstance(
//       relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
//       projectId: '123',
//       metadata: PairingMetadata(
//         name: 'Wallet (Responder)',
//         description: 'A wallet that can be requested to sign transactions',
//         url: 'https://walletconnect.com',
//         icons: ['https://avatars.githubusercontent.com/u/37784886'],
//       ),
//     );
//
// // For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
//     int id;
//     wcClient.onSessionProposal.subscribe((SessionProposalEvent args) async {
//       id = args.id;
//     });
//
// // Also setup the methods and chains that your wallet supports
//     final kadenaSignV1RequestHandler = (String topic, dynamic parameters) async {
//       // Handling Steps
//       // 1. Parse the request, if there are any errors thrown while trying to parse
//       // the client will automatically respond to the requester with a
//       // JsonRpcError.invalidParams error
//       final parsedResponse = parameters;
//
//       // 2. Show a modal to the user with the signature info: Allow approval/rejection
//       bool userApproved = await showDialog( // This is an example, you will have to make your own changes to make it work.
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Sign Transaction'),
//             content: SizedBox(
//               width: 300,
//               height: 350,
//               child: Text(parsedResponse.toString()),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 child: Text('Accept'),
//               ),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: Text('Reject'),
//               ),
//             ],
//           );
//         },
//       );
//
//       // 3. Respond to the dApp based on user response
//       if (userApproved) {
//         // Returned value must by a primitive, or a JSON serializable object: Map, List, etc.
//         return 'Signed!';
//       }
//       else {
//         // Throw an error if the user rejects the request
//         throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
//       }
//     };
//     wcClient.registerRequestHandler(
//       method: 'kadena_sign_v1',
//       handler: kadenaSignV1RequestHandler,
//     );
//
// // Setup the auth handling
//     wcClient.onAuthRequest.subscribe((AuthRequest args) async {
//       // This is where you would
//       // 1. Store the information to be signed
//       // 2. Display to the user that an auth request has been received
//
//       // You can create the message to be signed in this manner
//     //   String message = wcClient.formatAuthMessage(
//     //     iss: TEST_ISSUER_EIP191,
//     //     cacaoPayload: CacaoRequestPayload.fromPayloadParams(
//     //       args.payloadParams,
//     //     ),
//     //   );
//     // });
//
// // Then, scan the QR code and parse the URI, and pair with the dApp
// // On the first pairing, you will immediately receive onSessionProposal and onAuthRequest events.
//     Uri uri = Uri.parse(scannedUriString);
//     final PairingInfo pairing = await wcClient.pair(uri: uri);
//
// // Present the UI to the user, and allow them to reject or approve the proposal
//     final walletNamespaces = {
//       'eip155': Namespace(
//         accounts: ['eip155:1:abc'],
//         methods: ['eth_signTransaction'],
//       ),
//       'kadena': Namespace(
//         accounts: ['kadena:mainnet01:abc'],
//         methods: ['kadena_sign_v1', 'kadena_quicksign_v1'],
//         events: ['kadena_transaction_updated'],
//       ),
//     }
//     await wcClient.approveSession(
//         id: id,
//         namespaces: walletNamespaces // This will have the accounts requested in params
//     );
// // Or to reject...
// // Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
//     await wcClient.rejectSession(
//       id: id,
//       reason: Errors.getSdkError(Errors.USER_REJECTED_SIGN),
//     );
//
// // For auth, you can do the same thing: Present the UI to them, and have them approve the signature.
// // Then respond with that signature. In this example I use EthSigUtil, but you can use any library that can perform
// // a personal eth sign.
//     String message = wcClient.formatAuthMessage(iss: TEST_PRIVATE_KEY_EIP191, cacaoPayload: CacaoRequestPayload.fromPayloadParams(args.payloadParams));
//
//     String sig = EthSigUtil.signPersonalMessage(
//       message: Uint8List.fromList(message.codeUnits),
//       privateKey: 'PRIVATE_KEY',
//     );
//     await wcClient.respondAuthRequest(
//       id: id,
//       iss: 'did:pkh:eip155:1:ETH_ADDRESS',
//       signature: CacaoSignature(t: CacaoSignature.EIP191, s: sig),
//     );
// // Or rejected
// // Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
//     await wcClient.respondAuthRequest(
//       id: id,
//       error: Errors.getSdkError(Errors.USER_REJECTED_AUTH),
//     );
//
// // You can also emit events for the dApp
// //     await wcClient.emitSessionEvent(
// //       topic: sessionTopic,
// //       chainId: 'eip155:1',
// //       event: SessionEventParams(
// //         name: 'chainChanged',
// //         data: 'a message!',
// //       ),
// //     );
//
// // Finally, you can disconnect
// //     await wcClient.disconnectSession(
// //       topic: pairing.topic,
// //       reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
// //     );
//   }

  getData({isRefresh = false}) {
    // if (!isRefresh) showLoadingDialog();
  }
}
