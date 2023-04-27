import 'package:fluro/fluro.dart';

import '../../routes/main_page.dart';
import '../../routes/miner/bind_superior_page.dart';
import '../../routes/miner/miner_page.dart';
import '../../routes/other/about_us_page.dart';
import '../../routes/other/help_and_feedback_page.dart';
import '../../routes/other/notice_page.dart';
import '../../routes/other/webview_page.dart';
import '../../routes/pledge/my_pledge_page.dart';
import '../../routes/pledge/pledge_page.dart';
import '../../routes/user/collect_money_page.dart';
import '../../routes/user/create_wallet_page.dart';
import '../../routes/user/import_wallet_page.dart';
import '../../routes/user/mnemonic_page.dart';
import '../../routes/user/select_chain_page.dart';
import '../../routes/user/select_currency_page.dart';
import '../../routes/user/transfer_page.dart';
import '../../routes/user/transfer_record_page.dart';
import '../../routes/user/use_setting_page.dart';
import '../../routes/user/wallet_management_page.dart';
import 'pageBuilder.dart';

class PageWalletRouter {
  static final router = FluroRouter();

  static final String main_page = 'main_page';
  static final String collect_money_page = 'collect_money_page';
  static final String transfer_page = 'transfer_page';
  static final String create_wallet_page = 'create_wallet_page';
  static final String import_wallet_page = 'import_wallet_page';
  static final String mnemonic_page = 'mnemonic_page';
  static final String wallet_management_page = 'wallet_management_page';
  static final String transfer_record_page = 'transfer_record_page';
  static final String use_setting_page = 'use_setting_page';
  static final String select_currency_page = 'select_currency_page';
  static final String help_and_feedback_page = 'help_and_feedback_page';
  static final String webview_page = 'webview_page';
  static final String notice_page = 'notice_page';
  static final String about_us_page = 'about_us_page';
  static final String select_chain_page = 'select_chain_page';
  static final String pledge_page = 'pledge_page';
  static final String my_pledge_page = 'my_pledge_page';
  static final String miner_page = 'miner_page';
  static final String bind_superior_page = 'bind_superior_page';

  static final Map<String, PageBuilder> pageRoutes = {
    main_page: PageBuilder(builder: (bundle) => (MainPage())),
    transfer_page: PageBuilder(builder: (bundle) => (TransferPage(bundle))),
    collect_money_page: PageBuilder(builder: (bundle) => (CollectMoneyPage(bundle))),
    create_wallet_page: PageBuilder(builder: (bundle) => (CreateWalletPage(bundle))),
    import_wallet_page: PageBuilder(builder: (bundle) => (ImportWalletPage(bundle))),
    mnemonic_page: PageBuilder(builder: (bundle) => (MnemonicPage(bundle))),
    wallet_management_page: PageBuilder(builder: (bundle) => (WalletManagementPage(bundle))),
    transfer_record_page: PageBuilder(builder: (bundle) => (TransferRecordPage(bundle))),
    use_setting_page: PageBuilder(builder: (bundle) => (UseSettingPage())),
    select_currency_page: PageBuilder(builder: (bundle) => (SelectCurrencyPage())),
    help_and_feedback_page: PageBuilder(builder: (bundle) => (HelpAndFeedbackPage())),
    notice_page: PageBuilder(builder: (bundle) => (NoticePage())),
    about_us_page: PageBuilder(builder: (bundle) => (AboutUsPage())),
    webview_page: PageBuilder(builder: (bundle) => (WebViewPage(bundle))),
    select_chain_page: PageBuilder(builder: (bundle) => (SelectChainPage(bundle))),
    pledge_page: PageBuilder(builder: (bundle) => (PledgePage(bundle))),
    my_pledge_page: PageBuilder(builder: (bundle) => (MyPledgePage())),
    miner_page: PageBuilder(builder: (bundle) => (MinerPage(bundle))),
    bind_superior_page: PageBuilder(builder: (bundle) => (BindSuperiorPage(bundle))),
  };

  static setupRoutes() {
    pageRoutes.forEach((path, handler) {
      router.define(path, handler: handler, transitionType: TransitionType.cupertino);
    });
  }
}
