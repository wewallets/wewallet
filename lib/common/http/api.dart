import 'package:mars/common/transaction_component_index.dart';

class ApiTransaction {
  ///K线地址
  static String KLINE_SERVICE = GlobalTransaction.isManualRelease ? "ws://go6789.kline87.com/ws" : 'ws://47.242.241.207:9012/ws';

  /// 服务器TEST地址
  // static const String TEST_BASE_URL = "http://testapi.dsplab.ink:9080/";
  static const String TEST_BASE_URL = "https://testtokenwallet.eaec.ink/";

  /// 服务器正式地址
  // static const String RELEASE_BASE_URL = "https://app.kline87.com/";
  static const String RELEASE_BASE_URL = "https://app5.rzjnhbv.com/";

  static String BASE_URL = GlobalTransaction.isManualRelease ? RELEASE_BASE_URL : TEST_BASE_URL;

  /// k线
  static String push_kline_graph = GlobalTransaction.isManualRelease ? 'https://testtokenwallet.eaec.ink/kline/push_kline_graph' : 'https://testrisek.eaec.ink/kline/push_kline_graph';

  /// usdt
  static String BASE_CY = BASE_URL + 'market/basecurrency.json'; // get

  /// usdt列表
  static String BASE_CY_LIST = BASE_URL + 'market/tradpair.json'; // post

  /// 矿池列表
  static String ORE_LIST = BASE_URL + 'mpool/pool_list.json';

  /// 矿池详情
  static String ORE_DETAIL = BASE_URL + 'mpool/pool_detail.json';

  /// 登录
  // static String RIPPLE_LOGIN = BASE_URL + 'auth/ripple_login.json';

  /// 创建地址
  static String CREATE_ADDRESS = BASE_URL + 'auth/create_address.json';

  static String PAYMENT = BASE_URL + 'chain/payment.json';

  /// 基本信息
  static String INIT_INFO = BASE_URL + 'init_trade?id=';

  /// 搜索
  static String SEARCH_STOCK = BASE_URL + 'lookup_stock?id=';

  /// 下单内容
  static String PLACE_ORDER = BASE_URL + 'buy_stock?id=';

  /// 清仓
  static String CLEAR_STOCK = BASE_URL + 'sell_stock?id=';

  /// K线
  static String K_LINE = BASE_URL + 'market/kline.json';

  /// 币种简介
  static String CY_INTRO = BASE_URL + 'market/currency_intro.json';

  /// 成交记录
  static String CY_TRANS_LOG = BASE_URL + 'market/deal_list.json';

  /// 深度
  static String CY_DEPTH = BASE_URL + 'market/depth.json';

  /// 委托单
  static String TRUST_LIST = BASE_URL + 'order/order_list.json';

  //历史委托
  static String ORDER_HISTORY = BASE_URL + 'order/order_history.json';

  /// 历史记录
  static String HISTORY_LIST = BASE_URL + 'market/deal_list.json';

  /// 交易对行情
  static String MARKET_DETAIL = BASE_URL + 'market/market_detail.json';

  /// 交易上下五档行情
  static String FIVE_LEVEL = BASE_URL + 'market/order_marge.json';

  /// 资产接口
  static String CHAIN_ASSETS = BASE_URL + 'chain/assets.json';

  /// 资产接口
  static String CHAIN_BALANCE = BASE_URL + 'chain/balance.json';

  /// 信任接口
  static String CHAIN_TRUST_SET = BASE_URL + 'chain/trust_set.json';

  /// 取消信任接口
  static String CHAIN_TRUST_SET_CANCEL = BASE_URL + 'chain/trust_set_cancel.json';

  /// 账本记录接口
  static String USDER_LEDGER = BASE_URL + 'wallet/ledger.json';

  /// 行情列表接口
  static String MARKET_LIST = BASE_URL + 'market/market_list.json';

  /// 行情列表接口
  static String RANKING_LIST = BASE_URL + 'market/ranking_list.json';

  /// 矿工列表接口
  static String MINER_LIST = BASE_URL + 'mpool/miner_list.json';
  static String POOL_MINER_LIST = BASE_URL + 'pool/miner_list.json';

  /// 获取app配置信息的接口
  static String GET_APP_CONFIG = BASE_URL + 'config/get_app_config.json';

  /// 获取app配置信息的接口
  static String GET_VALUE = BASE_URL + 'config/getvalue.json';

  /// 修改矿工备注接口
  static String SET_RMARK = BASE_URL + 'mpool/set_remark.json';

  /// 收益明细接口
  static String REWARD_LOG = BASE_URL + 'mpool/reward_log.json';

  /// 获取充币地址接口
  static String GET_IN_ADDRESS = BASE_URL + 'chain/get_in_address.json';

  /// 提币订单接口
  static String OUT_ORDER = BASE_URL + 'chain/out_order.json';

  /// 提币订单接口
  static String out_order_eae = BASE_URL + 'chain/out_order_eae.json';

  /// 提币订单接口
  static String OUT_ORDER_BRT = BASE_URL + 'chain/top_up_brt.json';

  /// 取消挂单接口
  static String CHAIN_OFFER_CANCEL = BASE_URL + 'order/offer_cancel.json';

  /// 挂单接口
  static String CHAIN_OFFER_CREATE = BASE_URL + 'order/offer_create.json';

  /// 挂单手续费接口
  static String CHAIN_OFFER_POUNDAGE = BASE_URL + 'order/offer_poundage.json';

  /// 公告列表、详情接口
  static String GONGGAO_LIET = BASE_URL + 'wallet/gonggaolist.json';

  /// 地址列表
  static String ACCOUNTS_BALANCE = BASE_URL + 'chain/accounts_balance.json';

  /// 激活接口
  static String PAYMENT_ACTIVE = BASE_URL + 'chain/payment_active.json';

  /// 导入地址接口
  static String BACK_ADDRESS = BASE_URL + 'auth/back_address.json';

  /// 矿池转出接口
  static String POOL_OUT = BASE_URL + 'chain/pool_out.json';

  /// 矿池转入接口
  static String POOL_IN = BASE_URL + 'pool/pool_in.json';

  /// 矿池收益接口
  static String PROFIT = BASE_URL + 'chain/profit.json';

  /// 挂单查询可用余额接口
  static String OFFER_BALANCE = BASE_URL + 'chain/offer_balance.json';

  /// 活动接口
  static String WALLET_ACTIVITY = BASE_URL + 'wallet/activity.json';

  /// 投票接口
  static String WALLET_VOTE = BASE_URL + 'wallet/vote.json';

  /// 上币申请接口
  static String WALLET_APPLY = BASE_URL + 'wallet/apply_coin.json';

  /// 申购页面接口
  static String WALLET_PURCHASE_INFO = BASE_URL + 'wallet/purchase_info.json';

  /// 申购接口
  static String WALLET_PURCHASE = BASE_URL + 'wallet/purchase.json';

  /// 隐藏失败订单接口
  static String ORDER_HIDE = BASE_URL + 'market/order_hide.json';

  /// 激活选区列表接口
  static String USER_AREA = BASE_URL + 'market/user_area.json';

  /// banner接口
  static String MARKET_BANNER = BASE_URL + 'market/banner.json';

  /// 行情
  static String TICKER = 'https://fxhapi.feixiaohao.com/public/v1/ticker';

  /// 矿池详情接口
  static String POOL_DETAIL = BASE_URL + 'pool/pool_detail.json';

  /// 矿池激活接口
  static String POOL_ACTIVATE = BASE_URL + 'pool/activate.json';

  /// 矿池排行接口
  static String POOL_RANKING_LIST = BASE_URL + 'pool/ranking_list.json';

  /// 我的矿池接口
  static String POOL_MY = BASE_URL + 'pool/my_pool.json';

  /// 当日收益最大最小接口
  static String POOL_RANKING_MIN_MAX = BASE_URL + 'pool/ranking_minmax.json';

  /// 矿池收益明细接口
  static String EARINGS_HISTORY = BASE_URL + 'pool/earings_history.json';

  /// 用户协议接口
  static String WALLET_AGREEMENT = BASE_URL + 'wallet/agreement.json';
  /// 用户协议接口
  static String BASIC_AGREEMENT = BASE_URL + 'basic/agreement.json';
  /// 用户信息接口
  static String ADDRESS_INFO = BASE_URL + 'wallet/address_info.json';

  /// 用户注册接口
  static String ADDRESS_INFO_EDIT = BASE_URL + 'wallet/address_nick_set.json';

  static String ADDRESS_INFO_EDITS = BASE_URL + 'wallet/address_info_edit.json';

  /// 矿池数据接口
  static String MPOOL_POOLINFO = BASE_URL + 'mpool/poolinfo.json';

  /// 首页矿池昨日收益接口
  static String MPOOL_POOLYESTERDAY = BASE_URL + 'mpool/poolyesterday.json';

  /// 直推矿工接口
  static String MPOOL_POOLLUNDER = BASE_URL + 'mpool/poolunder.json';

  /// 贡献接口
  static String MPOOL_POOL_CONTRIBUTION = BASE_URL + 'mpool/poolcontribution.json';

  /// 导入旧地址接口
  static String BACK_ADDRESS_LIST = BASE_URL + 'auth/back_address_list.json';

  /// 生成新助记词接口
  static String UPDATE_MEMONIC = BASE_URL + 'auth/update_mnemonic.json';

  /// 首页矿池昨日收益接口
  static String MPOOL_POOL_YESTERDAY = BASE_URL + 'mpool/poolyesterday.json';

  /// 首页矿池昨日收益接口
  static String send_email = BASE_URL + 'basic/send_email.json';

  /// 首页矿池昨日收益接口
  static String email_set = BASE_URL + 'auth/email_set.json';

  /// 首页矿池昨日收益接口
  static String email_info = BASE_URL + 'auth/email_info.json';

  static String product_detail = BASE_URL + 'product/detail.json';

  static String product_buy = BASE_URL + 'product/buy.json';

  ///上传图片
  static String uplod_img = BASE_URL + 'basic/uplod_img.json';

  ///银行列表
  static String bank_list = BASE_URL + 'recharge/bank_list.json';

  ///银行凭证充值接口
  static String recharge_add = BASE_URL + 'recharge/add.json';

  ///美元汇率接口
  static String recharge_exchangerate = BASE_URL + 'recharge/exchangerate.json';

  /// 获取市场价接口
  static String UNIT_PRICE = BASE_URL + 'market/unit_price.json';

  /// 闪兑
  static String CONVERSION = BASE_URL + 'chain/conversion.json';

  /// 获取市场价接口
  static String collection_UNIT_PRICE = BASE_URL + 'collection/conversion_price.json';

  /// 闪兑
  static String collection_CONVERSION = BASE_URL + 'collection/conversion.json';
  /// 轮播图
  static String banner_list = BASE_URL + 'wallet/banner.json';
  static String agreement = BASE_URL + 'basic/agreement.json';
  static String fund_list = BASE_URL + 'fund/list.json';

  static String fund_detail = BASE_URL + 'fund/wheel_detail.json';
  static String fund_product_detail = BASE_URL + 'fund/product_detail.json';

  static String gonggao_list = BASE_URL + 'fund/gonggao_list.json';

  static String is_active = BASE_URL + 'fund/is_active.json';

  static String active = BASE_URL + 'fund/active.json';

  static String assets_in = BASE_URL + 'fund/assets_in.json';
  static String user_product = BASE_URL + 'fund/user_product.json';
  static String user_product_income = BASE_URL + 'fund/user_product_income.json';
  static String user_promote = BASE_URL + 'fund/user_promote.json';
  static String user_income = BASE_URL + 'fund/user_income.json';
  static String assets_log = BASE_URL + 'fund/assets_log.json';
  static String assets_out = BASE_URL + 'fund/assets_out.json';
  static String order_add = BASE_URL + 'fund/order_add.json';
  static String assets_ai_in = BASE_URL + 'fund/assets_ai_in.json';
  static String assets_ai_out = BASE_URL + 'fund/assets_ai_out.json';

  static String fund_gonggao_list = BASE_URL + 'fund/gonggao_list.json';
  static String pull_order_market = GlobalTransaction.isManualRelease ? 'https://kline.kline87.com/trade/pull_order_market' : 'https://testrisek.eaec.ink/trade/pull_order_market';
  static String pull_order_depth = GlobalTransaction.isManualRelease ? 'https://kline.kline87.com/trade/pull_order_depth' : 'https://testrisek.eaec.ink/trade/pull_order_depth';
  static String pull_order_deal = GlobalTransaction.isManualRelease ? 'https://kline.kline87.com/trade/pull_order_deal' : 'https://testrisek.eaec.ink/trade/pull_order_deal';
  static String pull_order_buysell = GlobalTransaction.isManualRelease ? 'https://kline.kline87.com/trade/pull_order_buysell' : 'https://testrisek.eaec.ink/trade/pull_order_buysell';
  static String market_detail = GlobalTransaction.isManualRelease ? 'https://kline.kline87.com/trade/market_detail' : 'https://testrisek.eaec.ink/trade/market_detail';

  static String collection_balance = BASE_URL + 'collection/balance.json';
  static String collection_assets_in = BASE_URL + 'collection/assets_in.json';
  static String collection_assets_out = BASE_URL + 'collection/assets_out.json';
  static String collection_product_list = BASE_URL + 'collection/product_list.json';
  static String collection_product_by_currency = BASE_URL + 'collection/product_by_currency.json';
  static String collection_product_rand = BASE_URL + 'collection/product_rand.json';
  static String collection_order_add = BASE_URL + 'collection/order_add.json';
  static String collection_assets_log = BASE_URL + 'collection/assets_log.json';
  static String collection_get_by_account = BASE_URL + 'collection/get_by_account.json';
  static String collection_child_info = BASE_URL + 'collection/child_info.json';
  static String collection_child_list = BASE_URL + 'collection/child_list.json';
  static String collection_bind = BASE_URL + 'collection/bind.json';
  static String collection_order_hang_list = BASE_URL + 'collection/order_hang_list.json';
  static String collection_order_hang_create = BASE_URL + 'collection/order_hang_create.json';
  static String collection_transfer_currency = BASE_URL + 'chain/transfer_currency.json';
  static String collection_order_hang_pay = BASE_URL + 'collection/order_hang_pay.json';
  static String collection_order_hang_cancel = BASE_URL + 'collection/order_hang_cancel.json';
  static String collection_order_buy_back = BASE_URL + 'collection/order_buy_back.json';


  static String swap_balance = BASE_URL + 'swap/balance.json';
  static String swap_product_list = BASE_URL + 'swap/product_list.json';
  static String swap_assets_log = BASE_URL + 'swap/assets_log.json';
  static String swap_order_add = BASE_URL + 'swap/order_add.json';
  static String swap_order_cancel = BASE_URL + 'swap/order_cancel.json';
  static String swap_order_list = BASE_URL + 'swap/order_list.json';
  static String swap_product_price = BASE_URL + 'swap/product_price.json';
  static String swap_assets_in = BASE_URL + 'swap/assets_in.json';
  static String swap_assets_out = BASE_URL + 'swap/assets_out.json';

  static String swap_pledge_group = BASE_URL + 'swap/pledge_group.json';
  static String swap_pledge_list = BASE_URL + 'swap/pledge_list.json';
  static String swap_pledge_order_add = BASE_URL + 'swap/pledge_order_add.json';
  static String swap_pledge_order_list = BASE_URL + 'swap/pledge_order_list.json';
  static String swap_pool_info = BASE_URL + 'swap/pool_info.json';
  static String swap_miner_list = BASE_URL + 'swap/miner_list.json';


}
