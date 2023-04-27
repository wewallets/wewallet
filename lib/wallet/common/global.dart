import 'dart:convert';

import 'package:mars/wallet/mobels/Network_list.dart';
import 'package:provider/provider.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:mars/wallet/mobels/wallet_entity.dart';

import '../../common/global.dart';
import '../mobels/ThemeModel.dart';
import '../mobels/assets_entity.dart';
import '../mobels/user_info_entity.dart';
import 'utils/spUtil.dart';

//全局变量
class Global {
  /// 手动控制是否为release版 false:测试 true:正式
  static bool get isManualRelease => false;

  /// 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// 是否登录 true已登录 false 未登陆
  static get isLogin => SpWalletUtil.getBool('isLogin') ?? false;

  static String encryptionSHA1 = 'millhavemoneyok';

  static BuildContext getContext;

  //系统主题
  static bool themeMode = SpWalletUtil.getBool('themeMode') ?? true;

  static Map<String, Color> themeColorMap = {'white': Colors.white, 'black': Colours().textTheme1};

  static WalletEntity get userWallet => SpWalletUtil?.getObj('userWallet', (v) => WalletEntity().fromJson(v)) ?? null;

  static List<WalletEntity> get walletList => SpWalletUtil?.getObjList('walletList', (v) => WalletEntity().fromJson(v)) ?? [];

  static List<NetworkList> networkList = SpWalletUtil?.getObjList('networkList', (v) => NetworkList.fromJson(v)) ?? [];

  static String coupon = '';

  //切换主题
  static switchTheme(BuildContext context, bool themeMode) {
    Global.themeMode = themeMode;
    var model = Provider.of<ThemeModel>(context, listen: false);
    var brightness = Global.themeMode ? Brightness.dark : Brightness.light;
    model.switchRandomTheme(brightness: brightness);
    SpWalletUtil.putBool('themeMode', Global.themeMode);
  }

  static logout(context) {
    SpWalletUtil.putBool('isLogin', false);
    SpWalletUtil.remove('userWallet');
    SpWalletUtil.putObjectList('walletList', []);
    // Net().post(Api.userlogout, null);
  }

  static saveWallet(WalletEntity wallet) {
    if (!isLogin) SpWalletUtil.putBool('isLogin', true);
    List<WalletEntity> list = [];

    if (walletList != null && walletList != [] && walletList.length != 0) list = walletList;

    if (list.length == 0) {
      switchWallet(wallet);
    }

    if (wallet.wallet.privateKey == null) wallet.wallet.privateKey = '';
    if (wallet.wallet.propose == null) wallet.wallet.propose = '';

    list.add(wallet);
    SpWalletUtil.putObjectList('walletList', list);
  }

  static switchWallet(WalletEntity wallet) {
    SpWalletUtil.putObject('userWallet', wallet);

    GlobalTransaction.saveWallet(walletName: wallet.name, accountId: wallet.wallet.address, masterKey: wallet.wallet.privateKey, masterSeed: wallet.wallet.propose, password: wallet.password);

    EventBus().send('switchWallet');
  }

  //根据币名获取资产信息
  static AssetsCurrencyList getAssetsWalletInfo(String icon) {
    if (isLogin) {
      List<AssetsCurrencyList> currencyList = getCurrencyList();
      if (currencyList == null) return null;
      for (int i = 0; i < currencyList.length; i++) {
        if (currencyList[i].currencyName == icon.toUpperCase()) {
          return currencyList[i];
        }
      }
      return null;
    }
    return null;
  }

  static refreshWalletAssets({isRefresh = false}) {
    SpWalletUtil.putObjectList('walletList', []);

    EventBus().send('switchWallet');


  }

  static getNetworkListIndex() {
    for (int i = 0; i < networkList.length; i++) {
      if (Global.userWallet.network == networkList[i].name) return i;
    }
    return 0;
  }

  static getCurrencyList() {
    List<AssetsCurrencyList> currencyList = SpWalletUtil?.getObjList('currencyList' + userWallet.wallet.address, (v) => AssetsCurrencyList().fromJson(v)) ?? [];
    return currencyList;
  }

  static saveCurrencyList(List<AssetsCurrencyList> wallet) {
    SpWalletUtil.putObjectList('currencyList' + userWallet.wallet.address, wallet);
  }

  static saveNetworkList(List<NetworkList> list) {
    SpWalletUtil.putObjectList('networkList', list);
  }

  static initNetWorkList() {

  }
}
