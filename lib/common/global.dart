import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/acc_info_entity.dart';
import 'package:mars/models/collection_balance_entity.dart';
import 'package:mars/models/index.dart';

import '../models/swap_product_list_entity.dart';
import 'http/api.dart';
import 'http/net.dart';
import 'utils/spUtil.dart';

//全局变量
class GlobalTransaction {
  /// 手动控制是否为release版 false:测试 true:正式 如果Release版本就强制设置正式
  static bool get isManualRelease => false;

  /// 自动控制是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// 是否登录 true已登录 false 未登陆
  static get isLogin => SpUtil.getBool('isLogin') ?? false;

  //当前默认钱包
  static WalletInfo get walletInfo => SpUtil?.getObj('currentWalletInfos', (v) => WalletInfo.fromJson(v));

  //当前钱包密码
  static String get walletPassword => SpUtil?.getString('wallet_password') != null ? SpUtil?.getString('wallet_password').toString().replaceAll('"', '') : '';

  //全部钱包
  static List<WalletInfo> get walletInfoList => SpUtil?.getObjList('walletInfoList', (v) => WalletInfo.fromJson(v));

  static String get email => SpUtil?.getString('email${GlobalTransaction.walletInfo.account_id}') != null ? SpUtil?.getString('email${GlobalTransaction.walletInfo.account_id}').toString().replaceAll('"', '') : '';

  //默认币种
  static String coin = 'YISE';

  //交易刷新状态
  static bool isNewsTimer = true;

  //true ws false http
  static bool isWsOnHttp = false;

  static BuildContext context;

  static String imUrl = SpUtil?.getString('imUrl') != null ? SpUtil?.getString('imUrl').toString().replaceAll('"', '') : 'https://t26.bianncee.com';

  static List<CollectionBalanceCurrencyList> digitalStorageAssetsList = [];
  static List<CollectionBalanceCurrencyList> swapAssetsList = [];
  static SwapProductListEntity swapProductListData;

  //保存登录凭证
  static saveToken(token) {
    SpUtil.putString('token', token);
    SpUtil.putBool('isLogin', true);
  }

  //切换钱包或更新数据
  static switchWallet(WalletInfo walletInfo) {
    SpUtil.putObject('currentWalletInfos', walletInfo);
  }

  //保存钱包密码默认登录状态
  static saveWalletPassword(walletPassword) {
    SpUtil.putString('wallet_password', walletPassword);
    SpUtil.putBool('isLogin', true);
  }

  //保存钱包
  static saveWallet({accountId, masterKey, walletName, masterSeed, password}) {
    List<WalletInfo> walletInfoLists = [];

    if (walletInfoList != null && walletInfoList.length != 0) {
      walletInfoLists = walletInfoList;
    }

    WalletInfo info = WalletInfo();
    info.master_key = masterKey;
    info.wallet_name = walletName;
    info.account_id = accountId;
    info.master_seed = masterSeed;

    walletInfoLists.add(info);
    SpUtil.putObjectList('walletInfoList', walletInfoLists);
    saveWalletPassword(password);
    switchWallet(info);
  }

  //保存列表
  static saveWalletList({walletInfoList}) {
    SpUtil.putObjectList('walletInfoList', walletInfoList);
  }

  //修改钱包激活状态
  static setWalletInfo(String id, {String name, String isActivation, String balance, String balanceTh}) {
    List<WalletInfo> walletInfoLists = [];

    if (walletInfoList != null && walletInfoList.length != 0) {
      walletInfoLists = walletInfoList;
    }
    for (int i = 0; i < walletInfoLists.length; i++) {
      if (walletInfoLists[i].account_id == id) {
        if (name != null) walletInfoLists[i].wallet_name = name;

        if (isActivation != null) walletInfoLists[i].is_activation = isActivation;

        if (balance != null) walletInfoLists[i].balance = balance;

        if (balanceTh != null) walletInfoLists[i].balanceTh = balanceTh;

        if (walletInfoLists[i].account_id == walletInfo.account_id) switchWallet(walletInfoLists[i]);

        saveWalletList(walletInfoList: walletInfoLists);
        return walletInfoLists;
      }
    }
  }

  static WalletInfo getWalletInfo({masterSeed, masterKey}) {
    List<WalletInfo> walletInfoLists = walletInfoList;

    for (int i = 0; i < walletInfoLists.length; i++) {
      if (masterSeed != null) {
        if (walletInfoLists[i].master_seed == masterSeed) {
          return walletInfoLists[i];
        }
      } else if (masterKey != null) {
        if (walletInfoLists[i].master_key == masterKey) {
          return walletInfoLists[i];
        }
      }
    }
    return null;
  }

  //刷新钱包资产
  static refreshWalletAssets() {
    if (GlobalTransaction.isLogin) {
      List<WalletAssets> assetsList = [];

      Net().post(ApiTransaction.CHAIN_BALANCE, {'account': GlobalTransaction.walletInfo.account_id}, success: (data) {
        data['currency_list'].forEach((element) {
          assetsList.add(WalletAssets.fromJson(element));
        });
        SpUtil.putObjectList('assetsList', assetsList);

        if (GlobalTransaction.walletInfo.is_activation != '1') {
          if (assetsList[0].value != '0') {
            GlobalTransaction.setWalletInfo(GlobalTransaction.walletInfo.account_id, isActivation: '1', balance: assetsList[0].value);
          }
        } else if (assetsList[0].value != '0') {
          GlobalTransaction.setWalletInfo(GlobalTransaction.walletInfo.account_id, balance: assetsList[0].value);
        }
      });
      refreshWalletCollectionBalance();
      refreshWalletSwapBalance();
    }
  }

  static refreshWalletCollectionBalance() {
    Net().post(ApiTransaction.collection_balance, null, success: (data) {
      CollectionBalanceEntity collectionBalanceEntity = CollectionBalanceEntity().fromJson(data);
      GlobalTransaction.digitalStorageAssetsList = collectionBalanceEntity.currencyList;
    });
  }

  static refreshWalletSwapBalance() {
    Net().post(ApiTransaction.swap_balance, null, success: (data) {
      CollectionBalanceEntity collectionBalanceEntity = CollectionBalanceEntity().fromJson(data);
      GlobalTransaction.swapAssetsList = collectionBalanceEntity.currencyList;
    });
  }

  //根据币名获取资产信息
  static WalletAssets getAssetsWalletInfo(String icon) {
    // ls();
    if (GlobalTransaction.isLogin) {
      List<WalletAssets> assetsList = SpUtil.getObjList('assetsList', (v) => WalletAssets.fromJson(v));
      if (assetsList == null) return null;
      for (int i = 0; i < assetsList.length; i++) {
        if (assetsList[i].net_currency_name == icon.toUpperCase()) {
          return assetsList[i];
        }
      }
      return null;
    }
    return null;
  }

  static deleteWallet(address) {
    List<WalletInfo> walletInfoLists = [];

    if (walletInfoList != null && walletInfoList.length != 0) {
      walletInfoLists = walletInfoList;
    }
    for (int i = 0; i < walletInfoLists.length; i++) {
      if (walletInfoLists[i].account_id == address) {
        walletInfoLists.removeAt(i);
        saveWalletList(walletInfoList: walletInfoLists);
      }
    }
  }

  static CollectionBalanceCurrencyList getDigitalStorageAssets(String coin) {
    if (GlobalTransaction.isLogin) {
      if (digitalStorageAssetsList == null) return null;
      for (int i = 0; i < digitalStorageAssetsList.length; i++) {
        if (digitalStorageAssetsList[i].netCurrencyName == coin.toUpperCase()) {
          return digitalStorageAssetsList[i];
        }
      }
      return null;
    }
    return null;
  }

  static CollectionBalanceCurrencyList getSwapAssets(String coin) {
    if (GlobalTransaction.isLogin) {
      if (swapAssetsList == null) return null;
      for (int i = 0; i < swapAssetsList.length; i++) {
        if (swapAssetsList[i].netCurrencyName == coin.toUpperCase()) {
          return swapAssetsList[i];
        }
      }
      return null;
    }
    return null;
  }
}
