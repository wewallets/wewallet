import 'package:fluro/fluro.dart';
import 'package:mars/routes/addressmanage/address_info_manage_page.dart';
import 'package:mars/routes/addressmanage/address_manage_page.dart';
import 'package:mars/routes/addressmanage/export_secretkey_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_award_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_award_record_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_promote_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_detail_buy_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_detail_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_home_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_my_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_record_page.dart';
import 'package:mars/routes/crowdfunding/crowdfunding_transfer_page.dart';
import 'package:mars/routes/crowdfunding/help_center_page.dart';
import 'package:mars/routes/home/new_home_page.dart';
import 'package:mars/routes/kline/kline_page.dart';
import 'package:mars/routes/main_new_page.dart';
import 'package:mars/routes/main_page.dart';
import 'package:mars/routes/notice/notice_page.dart';
import 'package:mars/routes/operated/operated_apply_page.dart';
import 'package:mars/routes/operated/operated_coin_page.dart';
import 'package:mars/routes/operated/operated_subscription_page.dart';
import 'package:mars/routes/orepool/income_details_page.dart';
import 'package:mars/routes/orepool/ore_bill_page.dart';
import 'package:mars/routes/orepool/ore_contribution_page.dart';
import 'package:mars/routes/orepool/ore_data_page.dart';
import 'package:mars/routes/orepool/ore_detail_page.dart';
import 'package:mars/routes/orepool/ore_fil_detail_page.dart';
import 'package:mars/routes/orepool/ore_main_page.dart';
import 'package:mars/routes/orepool/ore_out_page.dart';
import 'package:mars/routes/orepool/ore_pool_page.dart';
import 'package:mars/routes/orepool/ore_to_page.dart';
import 'package:mars/routes/orepool/ore_pool_my_page.dart';
import 'package:mars/routes/orepool/ore_my_team_page.dart';
import 'package:mars/routes/other/about_us_page.dart';
import 'package:mars/routes/other/account_book_info_page.dart';
import 'package:mars/routes/other/account_book_page.dart';
import 'package:mars/routes/other/bank_list_page.dart';
import 'package:mars/routes/other/big_coffee_said_page.dart';
import 'package:mars/routes/other/confirm_recharge_page.dart';
import 'package:mars/routes/other/flash_cash_page.dart';
import 'package:mars/routes/other/guide_map_page.dart';
import 'package:mars/routes/other/modification_remarks_page.dart';
import 'package:mars/routes/other/share_page.dart';
import 'package:mars/routes/other/webview2_page.dart';
import 'package:mars/routes/other/webview_page.dart';
import 'package:mars/routes/transaction/trust_page.dart';
import 'package:mars/routes/user/activation_miner_page.dart';
import 'package:mars/routes/other/select_currency_page.dart';
import 'package:mars/routes/user/account_receivable_page.dart';
import 'package:mars/routes/user/add_gateway_page.dart';
import 'package:mars/routes/user/bind_email_page.dart';
import 'package:mars/routes/user/choose_old_address_page.dart';
import 'package:mars/routes/user/create_wallet_page.dart';
import 'package:mars/routes/user/create_wallet_success_page.dart';
import 'package:mars/routes/user/flash_cash_coin_page.dart';
import 'package:mars/routes/user/import_wallet_page.dart';
import 'package:mars/routes/user/list_of_miners_page.dart';
import 'package:mars/routes/user/login_Page.dart';
import 'package:mars/routes/user/mnemonic_backup_page.dart';
import 'package:mars/routes/user/modify_wallet_pwd_page.dart';
import 'package:mars/routes/user/public_offering_page.dart';
import 'package:mars/routes/user/recharge_coin_page.dart';
import 'package:mars/routes/user/reset_wallet_pwd_page.dart';
import 'package:mars/routes/user/transfer_accounts_page.dart';
import 'package:mars/routes/user/understanding_mnemonics_page.dart';
import 'package:mars/routes/user/withdraw_coin_brt_page.dart';
import 'package:mars/routes/user/withdraw_coin_page.dart';
import '../../routes/crowdfunding/crowdfunding_product_detail_page.dart';
import '../../routes/digitalStorage/binding_digital_storage_page.dart';
import '../../routes/digitalStorage/buy_digital_storage_page.dart';
import '../../routes/digitalStorage/details_digital_storage_page.dart';
import '../../routes/digitalStorage/digital_flash_cash_coin_page.dart';
import '../../routes/digitalStorage/home_digital_storage_page.dart';
import '../../routes/digitalStorage/ledger_digital_storage_page.dart';
import '../../routes/digitalStorage/main_digital_storage_page.dart';
import '../../routes/digitalStorage/my_digital_storage_page.dart';
import '../../routes/digitalStorage/subordinate_digital_storage_page.dart';
import '../../routes/digitalStorage/transfer_digital_storage_page.dart';
import '../../routes/ecology/ecology_detail10_page.dart';
import '../../routes/ecology/ecology_detail11_page.dart';
import '../../routes/ecology/ecology_detail12_page.dart';
import '../../routes/ecology/ecology_detail13_page.dart';
import '../../routes/ecology/ecology_detail1_page.dart';
import '../../routes/ecology/ecology_detail2_page.dart';
import '../../routes/ecology/ecology_detail3_page.dart';
import '../../routes/ecology/ecology_detail4_page.dart';
import '../../routes/ecology/ecology_detail5_page.dart';
import '../../routes/ecology/ecology_detail6_page.dart';
import '../../routes/ecology/ecology_detail7_page.dart';
import '../../routes/ecology/ecology_detail8_page.dart';
import '../../routes/ecology/ecology_detail9_page.dart';
import '../../routes/other/crowdfunding_illustrate_page.dart';
import '../../routes/other/help_list_page.dart';
import '../../routes/other/select_currency_two_page.dart';
import '../../routes/other/select_currency_white_page.dart';
import '../../routes/swap/independent_swap_page.dart';
import '../../routes/swap/ledger_swap_page.dart';
import '../../routes/swap/main_swap_page.dart';
import '../../routes/swap/my_product_page.dart';
import '../../routes/swap/order_ledger_swap_page.dart';
import '../../routes/swap/product_details_page.dart';
import '../../routes/swap/swap_list_of_miners_page.dart';
import 'pageBuilder.dart';

class PageTransactionRouter {
  static final router = FluroRouter();

  static final String main_page = "transaction_main_page";
  static final String transfer_accounts_page = "transaction_transfer_accounts_page";
  static final String login_Page = "transaction_login_Page";
  static final String create_wallet_page = "transaction_create_wallet_page";
  static final String import_wallet_page = "transaction_import_wallet_page";
  static final String mnemonic_backup_page = "transaction_mnemonic_backup_page";
  static final String understanding_mnemonics_page = "transaction_understanding_mnemonics_page";
  static final String withdraw_coin_page = "transaction_withdraw_coin_page";
  static final String recharge_coin_page = "transaction_recharge_coin_page";
  static final String address_manage_page = "transaction_address_manage_page";
  static final String address_info_manage_page = "transaction_address_info_manage_page";
  static final String export_secretkey_page = "transaction_export_secretkey_page";
  static final String modify_wallet_pwd_page = "transaction_modify_wallet_pwd_page";
  static final String reset_wallet_pwd_page = "transaction_reset_wallet_pwd_page";
  static final String activation_miner_page = "transaction_activation_miner_page";
  static final String notice_page = "transaction_notice_page";
  static final String add_gateway_page = "transaction_add_gateway_page";
  static final String account_receivable_page = "transaction_account_receivable_page";
  static final String select_currency_page = "transaction_select_currency_page";
  static final String ore_main_page = "transaction_ore_main_page";
  static final String ore_detail_page = "transaction_ore_detail_page";
  static final String ore_fil_detail_page = "transaction_ore_fil_detail_page";
  static final String k_line_page = "transaction_k_line_page";
  static final String account_book_page = "transaction_account_book_page";
  static final String account_book_info_page = "transaction_account_book_info_page";
  static final String trust_page = "transaction_trust_page";
  static final String create_wallet_success_page = "transaction_create_wallet_success_page";
  static final String guide_map_page = "transaction_guide_map_page";
  static final String webview_page = "transaction_webview_page";
  static final String webview2_page = "transaction_webview2_page";
  static final String list_of_miners_page = "transaction_list_of_miners_page";
  static final String modification_remarks_page = "transaction_modification_remarks_page";
  static final String income_details_page = "transaction_income_details_page";
  static final String share_page = "transaction_share_page";
  static final String ore_pool_page = "transaction_ore_pool_page";
  static final String ore_to_page = "transaction_ore_to_page";
  static final String ore_out_page = "transaction_ore_out_page";
  static final String ore_bill_page = "transaction_ore_bill_page";
  static final String withdraw_coin_brt_page = "transaction_withdraw_coin_brt_page";
  static final String operated_coin_page = "transaction_operated_coin_page";
  static final String operated_apply_page = "transaction_operated_apply_page";
  static final String operated_subscription_page = "transaction_operated_subscription_page";
  static final String ore_pool_my_page = "transaction_ore_pool_my_page";
  static final String ore_my_team_page = "transaction_ore_my_team_page";
  static final String ore_data_page = "transaction_ore_data_page";
  static final String choose_old_address_page = "transaction_choose_old_address_page";
  static final String ore_contribution_page = "transaction_ore_contribution_page";
  static final String new_home_page = "transaction_new_home_page";
  static final String new_main_page = "transaction_new_main_page";
  static final String about_us_page = "transaction_about_us_page";
  static final String bind_email_page = "transaction_bind_email_page";
  static final String public_offering_page = "transaction_public_offering_page";
  static final String big_coffee_said_page = "transaction_big_coffee_said_page";
  static final String flash_cash_page = "transaction_flash_cash_page";
  static final String bank_list_page = "transaction_bank_list_page";
  static final String confirm_recharge_page = "transaction_confirm_recharge_page";
  static final String flash_cash_coin_page = "transaction_flash_cash_coin_page";
  static final String crowdfunding_home_page = "transaction_crowdfunding_home_page";
  static final String crowdfunding_award_page = "transaction_crowdfunding_award_page";
  static final String crowdfunding_detail_page = "transaction_crowdfunding_detail_page";
  static final String crowdfunding_my_page = "transaction_crowdfunding_my_page";
  static final String crowdfunding_promote_page = "transaction_crowdfunding_promote_page";
  static final String crowdfunding_record_page = "transaction_crowdfunding_record_page";
  static final String crowdfunding_detail_buy_page = "transaction_crowdfunding_detail_buy_page";
  static final String crowdfunding_transfer_page = "transaction_crowdfunding_transfer_page";
  static final String crowdfunding_award_record_page = "transaction_crowdfunding_award_record_page";
  static final String crowdfunding_detail_two_page = "transaction_crowdfunding_detail_two_page";
  static final String help_center_page = "transaction_help_center_page";
  static final String ecology_detail1_page = "transaction_ecology_detail1_page";
  static final String ecology_detail2_page = "transaction_ecology_detail2_page";
  static final String ecology_detail3_page = "transaction_ecology_detail3_page";
  static final String ecology_detail4_page = "transaction_ecology_detail4_page";
  static final String ecology_detail5_page = "transaction_ecology_detail5_page";
  static final String ecology_detail6_page = "transaction_ecology_detail6_page";
  static final String ecology_detail7_page = "transaction_ecology_detail7_page";
  static final String ecology_detail8_page = "transaction_ecology_detail8_page";
  static final String ecology_detail9_page = "transaction_ecology_detail9_page";
  static final String ecology_detail10_page = "transaction_ecology_detail10_page";
  static final String ecology_detail11_page = "transaction_ecology_detail11_page";
  static final String ecology_detail12_page = "transaction_ecology_detail12_page";
  static final String ecology_detail13_page = "transaction_ecology_detail13_page";
  static final String help_page = "transaction_help_page";
  static final String crowdfunding_illustrate_page = "transaction_crowdfunding_illustrate_page";
  static final String crowdfunding_product_detail_page = "transaction_crowdfunding_product_detail_page";
  static final String main_digital_storage_page = "transaction_main_digital_storage_page";
  static final String ledger_digital_storage_page = "transaction_ledger_digital_storage_page";
  static final String transfer_digital_storage_page = "transaction_transfer_digital_storage_page";
  static final String details_digital_storage_page = "transaction_details_digital_storage_page";
  static final String buy_digital_storage_page = "transaction_buy_digital_storage_page";
  static final String my_digital_storage_page = "transaction_my_digital_storage_page";
  static final String binding_digital_storage_page = "transaction_binding_digital_storage_page";
  static final String subordinate_digital_storage_page = "transaction_subordinate_digital_storage_page";
  static final String select_currency_two_page = "transaction_select_currency_two_page";
  static final String main_swap_page = "transaction_main_swap_page";
  static final String select_currency_white_page = "transaction_select_currency_white_page";
  static final String ledger_swap_page = "transaction_ledger_swap_page";
  static final String independent_swap_page = "transaction_independent_swap_page";
  static final String order_ledger_swap_page = "transaction_order_ledger_swap_page";
  static final String my_product_page = "transaction_my_product_page";
  static final String product_details_page = "transaction_product_details_page";
  static final String digital_flash_cash_coin_page = "transaction_digital_flash_cash_coin_page";
  static final String swap_list_of_miners_page = "transaction_swap_list_of_miners_page";

  static final Map<String, PageBuilder> pageRoutes = {
    digital_flash_cash_coin_page: PageBuilder(builder: (bundle) => (DigitalFlashCashCoinPage(bundle))),
    order_ledger_swap_page: PageBuilder(builder: (bundle) => (OrderLedgerSwapPage(bundle))),
    independent_swap_page: PageBuilder(builder: (bundle) => (IndependentSwapPage(bundle))),
    my_product_page: PageBuilder(builder: (bundle) => (MyProductPage(bundle))),
    product_details_page: PageBuilder(builder: (bundle) => (ProductDetailsPage(bundle))),
    ore_to_page: PageBuilder(builder: (bundle) => (OreToPage(bundle))),
    ore_out_page: PageBuilder(builder: (bundle) => (OreOutPage(bundle))),
    ledger_swap_page: PageBuilder(builder: (bundle) => (LedgerSwapPage(bundle))),
    main_swap_page: PageBuilder(builder: (bundle) => (MainSwapPage())),
    swap_list_of_miners_page: PageBuilder(builder: (bundle) => (SwapListOfMinersPage())),
    select_currency_white_page: PageBuilder(builder: (bundle) => (SelectCurrencyWhitePage(bundle))),
    select_currency_two_page: PageBuilder(builder: (bundle) => (SelectCurrencyTwoPage(bundle))),
    binding_digital_storage_page: PageBuilder(builder: (bundle) => (BindingDigitalStoragePage(bundle))),
    subordinate_digital_storage_page: PageBuilder(builder: (bundle) => (SubordinateDigitalStoragePage(bundle))),
    ledger_digital_storage_page: PageBuilder(builder: (bundle) => (LedgerDigitalStoragePage(bundle))),
    transfer_digital_storage_page: PageBuilder(builder: (bundle) => (TransferDigitalStoragePage(bundle))),
    details_digital_storage_page: PageBuilder(builder: (bundle) => (DetailsDigitalStoragePage(bundle))),
    buy_digital_storage_page: PageBuilder(builder: (bundle) => (BuyDigitalStoragePage(bundle))),
    my_digital_storage_page: PageBuilder(builder: (bundle) => (MyDigitalStoragePage(bundle))),
    ore_bill_page: PageBuilder(builder: (bundle) => (OreBillPage())),
    main_digital_storage_page: PageBuilder(builder: (bundle) => (MainDigitalStoragePage())),
    ore_pool_page: PageBuilder(builder: (bundle) => (OrePoolPage())),
    main_page: PageBuilder(builder: (bundle) => (MainPage())),
    list_of_miners_page: PageBuilder(builder: (bundle) => (ListOfMinersPage())),
    guide_map_page: PageBuilder(builder: (bundle) => (GuideMapPage())),
    webview_page: PageBuilder(builder: (bundle) => (WebViewPage(bundle))),
    transfer_accounts_page: PageBuilder(builder: (bundle) => (TransferAccountsPage(bundle))),
    login_Page: PageBuilder(builder: (bundle) => (LoginPage())),
    create_wallet_page: PageBuilder(builder: (bundle) => (CreateWalletPage(bundle))),
    import_wallet_page: PageBuilder(builder: (bundle) => (ImportWalletPage(bundle))),
    mnemonic_backup_page: PageBuilder(builder: (bundle) => (MnemonicBackupPage(bundle))),
    create_wallet_success_page: PageBuilder(builder: (bundle) => (CreateWalletSuccessPage())),
    understanding_mnemonics_page: PageBuilder(builder: (bundle) => (UnderstandingMnemonicsPage())),
    withdraw_coin_page: PageBuilder(builder: (bundle) => (WithdrawCoinPage(bundle))),
    withdraw_coin_brt_page: PageBuilder(builder: (bundle) => (WithdrawCoinBrtPage(bundle))),
    recharge_coin_page: PageBuilder(builder: (bundle) => (RechargeCoinPage(bundle))),
    address_manage_page: PageBuilder(builder: (bundle) => (AddressManagePage())),
    address_info_manage_page: PageBuilder(builder: (bundle) => (AddressInfoManagePage(bundle))),
    export_secretkey_page: PageBuilder(builder: (bundle) => (ExportSecretkeyPage(bundle))),
    modify_wallet_pwd_page: PageBuilder(builder: (bundle) => (ModifyWalletPwdPage())),
    reset_wallet_pwd_page: PageBuilder(builder: (bundle) => (ResetWalletPwdPage())),
    activation_miner_page: PageBuilder(builder: (bundle) => (ActivationMinerPage(bundle))),
    notice_page: PageBuilder(builder: (bundle) => (NoticePage())),
    add_gateway_page: PageBuilder(builder: (bundle) => (AddGatewayPage(bundle))),
    account_receivable_page: PageBuilder(builder: (bundle) => (AccountReceivablePage(bundle))),
    select_currency_page: PageBuilder(builder: (bundle) => (SelectCurrencyPage(bundle))),
    ore_main_page: PageBuilder(builder: (bundle) => (OreMainPage())),
    ore_detail_page: PageBuilder(builder: (bundle) => (OreDetailPage(bundle))),
    k_line_page: PageBuilder(builder: (bundle) => (KLinePage(bundle))),
    account_book_page: PageBuilder(builder: (bundle) => (AccountBookPage(bundle))),
    account_book_info_page: PageBuilder(builder: (bundle) => (AccountBookInfoPage(bundle))),
    trust_page: PageBuilder(builder: (bundle) => (TrustPage())),
    modification_remarks_page: PageBuilder(builder: (bundle) => (ModificationRemarksPage(bundle))),
    income_details_page: PageBuilder(builder: (bundle) => (IncomeDetailsPage())),
    share_page: PageBuilder(builder: (bundle) => (SharePage())),
    operated_coin_page: PageBuilder(builder: (bundle) => (OperatedCoinPage())),
    operated_apply_page: PageBuilder(builder: (bundle) => (OperatedApplyPage(bundle))),
    operated_subscription_page: PageBuilder(builder: (bundle) => (OperatedSubscriptionPage())),
    ore_pool_my_page: PageBuilder(builder: (bundle) => (OrePoolMyPage(bundle))),
    ore_my_team_page: PageBuilder(builder: (bundle) => (OreMyTeamPage(bundle))),
    ore_data_page: PageBuilder(builder: (bundle) => (OreDataPage())),
    choose_old_address_page: PageBuilder(builder: (bundle) => (ChooseOldAddressPage(bundle))),
    ore_contribution_page: PageBuilder(builder: (bundle) => (OreContributionPage())),
    new_home_page: PageBuilder(builder: (bundle) => (NewHomePage())),
    new_main_page: PageBuilder(builder: (bundle) => (MainNewPage())),
    about_us_page: PageBuilder(builder: (bundle) => (AboutUsPage())),
    bind_email_page: PageBuilder(builder: (bundle) => (BindEmailPage())),
    public_offering_page: PageBuilder(builder: (bundle) => (PublicOfferingPage())),
    big_coffee_said_page: PageBuilder(builder: (bundle) => (BigCoffeeSaidPage())),
    ore_fil_detail_page: PageBuilder(builder: (bundle) => (OreFilDetailPage(bundle))),
    flash_cash_page: PageBuilder(builder: (bundle) => (FlashCashPage(bundle))),
    bank_list_page: PageBuilder(builder: (bundle) => (BankListPage())),
    confirm_recharge_page: PageBuilder(builder: (bundle) => (ConfirmRechargePage(bundle))),
    flash_cash_coin_page: PageBuilder(builder: (bundle) => (FlashCashCoinPage(bundle))),
    webview2_page: PageBuilder(builder: (bundle) => (WebView2Page(bundle))),
    crowdfunding_home_page: PageBuilder(builder: (bundle) => (CrowdFundingHomePage())),
    crowdfunding_award_page: PageBuilder(builder: (bundle) => (CrowdFundingAwardPage())),
    crowdfunding_award_record_page: PageBuilder(builder: (bundle) => (CrowdFundingAwardRecordPage())),
    crowdfunding_detail_page: PageBuilder(builder: (bundle) => (CrowdFundingDetailPage(bundle))),
    crowdfunding_my_page: PageBuilder(builder: (bundle) => (CrowdFundingMyPage())),
    crowdfunding_promote_page: PageBuilder(builder: (bundle) => (CrowdFundingPromotePage())),
    crowdfunding_record_page: PageBuilder(builder: (bundle) => (CrowdFundingRecordPage(bundle))),
    crowdfunding_detail_buy_page: PageBuilder(builder: (bundle) => (CrowdFundingBuyDetailPage(bundle))),
    crowdfunding_transfer_page: PageBuilder(builder: (bundle) => (CrowdFundingTransferPage(bundle))),
    help_page: PageBuilder(builder: (bundle) => (HelpListPage(bundle))),
    crowdfunding_product_detail_page: PageBuilder(builder: (bundle) => (CrowdFundingProductDetailPage(bundle))),
    help_center_page: PageBuilder(builder: (bundle) => (HelpCenterPage())),
    crowdfunding_illustrate_page: PageBuilder(builder: (bundle) => (CrowdFundingIllustratePage())),
    ecology_detail1_page: PageBuilder(builder: (bundle) => (EcologyDetail1Page())),
    ecology_detail2_page: PageBuilder(builder: (bundle) => (EcologyDetail2Page())),
    ecology_detail3_page: PageBuilder(builder: (bundle) => (EcologyDetail3Page())),
    ecology_detail4_page: PageBuilder(builder: (bundle) => (EcologyDetail4Page())),
    ecology_detail5_page: PageBuilder(builder: (bundle) => (EcologyDetail5Page())),
    ecology_detail6_page: PageBuilder(builder: (bundle) => (EcologyDetail6Page())),
    ecology_detail7_page: PageBuilder(builder: (bundle) => (EcologyDetail7Page())),
    ecology_detail8_page: PageBuilder(builder: (bundle) => (EcologyDetail8Page())),
    ecology_detail9_page: PageBuilder(builder: (bundle) => (EcologyDetail9Page())),
    ecology_detail10_page: PageBuilder(builder: (bundle) => (EcologyDetail10Page())),
    ecology_detail11_page: PageBuilder(builder: (bundle) => (EcologyDetail11Page())),
    ecology_detail12_page: PageBuilder(builder: (bundle) => (EcologyDetail12Page())),
    ecology_detail13_page: PageBuilder(builder: (bundle) => (EcologyDetail13Page())),
  };

  static setupRoutes() {
    pageRoutes.forEach((path, handler) {
      router.define(path, handler: handler, transitionType: TransitionType.cupertino);
    });
  }
}
