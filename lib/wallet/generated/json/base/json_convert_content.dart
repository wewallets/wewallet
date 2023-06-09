// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:mars/wallet/mobels/share_info_entity.dart';
import 'package:mars/wallet/generated/json/share_info_entity_helper.dart';
import 'package:mars/wallet/mobels/gift_certificate_entity.dart';
import 'package:mars/wallet/generated/json/gift_certificate_entity_helper.dart';
import 'package:mars/wallet/mobels/goods_index_entity.dart';
import 'package:mars/wallet/generated/json/goods_index_entity_helper.dart';
import 'package:mars/wallet/mobels/order_list_entity.dart';
import 'package:mars/wallet/generated/json/order_list_entity_helper.dart';
import 'package:mars/wallet/mobels/recive_list_entity.dart';
import 'package:mars/wallet/generated/json/recive_list_entity_helper.dart';
import 'package:mars/wallet/mobels/goods_gear_entity.dart';
import 'package:mars/wallet/generated/json/goods_gear_entity_helper.dart';
import 'package:mars/wallet/mobels/category_list_entity.dart';
import 'package:mars/wallet/generated/json/category_list_entity_helper.dart';
import 'package:mars/wallet/mobels/user_info_entity.dart';
import 'package:mars/wallet/generated/json/user_info_entity_helper.dart';
import 'package:mars/wallet/mobels/get_app_config_entity.dart';
import 'package:mars/wallet/generated/json/get_app_config_entity_helper.dart';
import 'package:mars/wallet/mobels/bank_card_info_entity.dart';
import 'package:mars/wallet/generated/json/bank_card_info_entity_helper.dart';
import 'package:mars/wallet/mobels/gold_order_list_entity.dart';
import 'package:mars/wallet/generated/json/gold_order_list_entity_helper.dart';
import 'package:mars/wallet/mobels/assets_entity.dart';
import 'package:mars/wallet/generated/json/assets_entity_helper.dart';
import 'package:mars/wallet/mobels/user_recharge_entity.dart';
import 'package:mars/wallet/generated/json/user_recharge_entity_helper.dart';
import 'package:mars/wallet/mobels/recharge_info_entity.dart';
import 'package:mars/wallet/generated/json/recharge_info_entity_helper.dart';
import 'package:mars/wallet/mobels/assets_list_entity.dart';
import 'package:mars/wallet/generated/json/assets_list_entity_helper.dart';
import 'package:mars/wallet/mobels/store_list_entity.dart';
import 'package:mars/wallet/generated/json/store_list_entity_helper.dart';
import 'package:mars/wallet/mobels/goods_list_entity.dart';
import 'package:mars/wallet/generated/json/goods_list_entity_helper.dart';
import 'package:mars/wallet/mobels/order_pay_entity.dart';
import 'package:mars/wallet/generated/json/order_pay_entity_helper.dart';
import 'package:mars/wallet/mobels/play_article_list_entity.dart';
import 'package:mars/wallet/generated/json/play_article_list_entity_helper.dart';
import 'package:mars/wallet/mobels/bankcard_list_entity.dart';
import 'package:mars/wallet/generated/json/bankcard_list_entity_helper.dart';
import 'package:mars/wallet/mobels/pledge_list_entity.dart';
import 'package:mars/wallet/generated/json/pledge_list_entity_helper.dart';
import 'package:mars/wallet/mobels/store_info_entity.dart';
import 'package:mars/wallet/generated/json/store_info_entity_helper.dart';
import 'package:mars/wallet/mobels/member_system_entity.dart';
import 'package:mars/wallet/generated/json/member_system_entity_helper.dart';
import 'package:mars/wallet/mobels/collection_list_entity.dart';
import 'package:mars/wallet/generated/json/collection_list_entity_helper.dart';
import 'package:mars/wallet/mobels/banner_list_entity.dart';
import 'package:mars/wallet/generated/json/banner_list_entity_helper.dart';
import 'package:mars/wallet/mobels/article_list_entity.dart';
import 'package:mars/wallet/generated/json/article_list_entity_helper.dart';
import 'package:mars/wallet/mobels/confirm_order_entity.dart';
import 'package:mars/wallet/generated/json/confirm_order_entity_helper.dart';
import 'package:mars/wallet/mobels/play_label_entity.dart';
import 'package:mars/wallet/generated/json/play_label_entity_helper.dart';
import 'package:mars/wallet/mobels/payment_account_entity.dart';
import 'package:mars/wallet/generated/json/payment_account_entity_helper.dart';
import 'package:mars/wallet/mobels/user_market_rank_entity.dart';
import 'package:mars/wallet/generated/json/user_market_rank_entity_helper.dart';
import 'package:mars/wallet/mobels/agent_system_entity.dart';
import 'package:mars/wallet/generated/json/agent_system_entity_helper.dart';
import 'package:mars/wallet/mobels/integral_list_entity.dart';
import 'package:mars/wallet/generated/json/integral_list_entity_helper.dart';
import 'package:mars/wallet/mobels/assets_log_entity.dart';
import 'package:mars/wallet/generated/json/assets_log_entity_helper.dart';
import 'package:mars/wallet/mobels/user_recharge_bank_entity.dart';
import 'package:mars/wallet/generated/json/user_recharge_bank_entity_helper.dart';
import 'package:mars/wallet/mobels/wallet_entity.dart';
import 'package:mars/wallet/generated/json/wallet_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case ShareInfoEntity:
				return shareInfoEntityFromJson(data as ShareInfoEntity, json) as T;
			case ShareInfoChildList:
				return shareInfoChildListFromJson(data as ShareInfoChildList, json) as T;
			case GiftCertificateEntity:
				return giftCertificateEntityFromJson(data as GiftCertificateEntity, json) as T;
			case GoodsIndexEntity:
				return goodsIndexEntityFromJson(data as GoodsIndexEntity, json) as T;
			case GoodsIndexGoodsList:
				return goodsIndexGoodsListFromJson(data as GoodsIndexGoodsList, json) as T;
			case OrderListEntity:
				return orderListEntityFromJson(data as OrderListEntity, json) as T;
			case OrderListGood:
				return orderListGoodFromJson(data as OrderListGood, json) as T;
			case ReciveListEntity:
				return reciveListEntityFromJson(data as ReciveListEntity, json) as T;
			case GoodsGearEntity:
				return goodsGearEntityFromJson(data as GoodsGearEntity, json) as T;
			case CategoryListEntity:
				return categoryListEntityFromJson(data as CategoryListEntity, json) as T;
			case UserInfoEntity:
				return userInfoEntityFromJson(data as UserInfoEntity, json) as T;
			case GetAppConfigEntity:
				return getAppConfigEntityFromJson(data as GetAppConfigEntity, json) as T;
			case BankCardInfoEntity:
				return bankCardInfoEntityFromJson(data as BankCardInfoEntity, json) as T;
			case GoldOrderListEntity:
				return goldOrderListEntityFromJson(data as GoldOrderListEntity, json) as T;
			case GoldOrderListGood:
				return goldOrderListGoodFromJson(data as GoldOrderListGood, json) as T;
			case AssetsEntity:
				return assetsEntityFromJson(data as AssetsEntity, json) as T;
			case AssetsTotal:
				return assetsTotalFromJson(data as AssetsTotal, json) as T;
			case AssetsCurrencyList:
				return assetsCurrencyListFromJson(data as AssetsCurrencyList, json) as T;
			case UserRechargeEntity:
				return userRechargeEntityFromJson(data as UserRechargeEntity, json) as T;
			case RechargeInfoEntity:
				return rechargeInfoEntityFromJson(data as RechargeInfoEntity, json) as T;
			case AssetsListEntity:
				return assetsListEntityFromJson(data as AssetsListEntity, json) as T;
			case StoreListEntity:
				return storeListEntityFromJson(data as StoreListEntity, json) as T;
			case GoodsListEntity:
				return goodsListEntityFromJson(data as GoodsListEntity, json) as T;
			case OrderPayEntity:
				return orderPayEntityFromJson(data as OrderPayEntity, json) as T;
			case PlayArticleListEntity:
				return playArticleListEntityFromJson(data as PlayArticleListEntity, json) as T;
			case PlayArticleListFile:
				return playArticleListFileFromJson(data as PlayArticleListFile, json) as T;
			case PlayArticleListLiker:
				return playArticleListLikerFromJson(data as PlayArticleListLiker, json) as T;
			case PlayArticleListCommant:
				return playArticleListCommantFromJson(data as PlayArticleListCommant, json) as T;
			case BankcardListEntity:
				return bankcardListEntityFromJson(data as BankcardListEntity, json) as T;
			case PledgeListEntity:
				return pledgeListEntityFromJson(data as PledgeListEntity, json) as T;
			case StoreInfoEntity:
				return storeInfoEntityFromJson(data as StoreInfoEntity, json) as T;
			case MemberSystemEntity:
				return memberSystemEntityFromJson(data as MemberSystemEntity, json) as T;
			case MemberSystemList:
				return memberSystemListFromJson(data as MemberSystemList, json) as T;
			case CollectionListEntity:
				return collectionListEntityFromJson(data as CollectionListEntity, json) as T;
			case BannerListEntity:
				return bannerListEntityFromJson(data as BannerListEntity, json) as T;
			case ArticleListEntity:
				return articleListEntityFromJson(data as ArticleListEntity, json) as T;
			case ConfirmOrderEntity:
				return confirmOrderEntityFromJson(data as ConfirmOrderEntity, json) as T;
			case ConfirmOrderCouponRecive:
				return confirmOrderCouponReciveFromJson(data as ConfirmOrderCouponRecive, json) as T;
			case ConfirmOrderGood:
				return confirmOrderGoodFromJson(data as ConfirmOrderGood, json) as T;
			case PlayLabelEntity:
				return playLabelEntityFromJson(data as PlayLabelEntity, json) as T;
			case PaymentAccountEntity:
				return paymentAccountEntityFromJson(data as PaymentAccountEntity, json) as T;
			case UserMarketRankEntity:
				return userMarketRankEntityFromJson(data as UserMarketRankEntity, json) as T;
			case UserMarketRankRankYear:
				return userMarketRankRankYearFromJson(data as UserMarketRankRankYear, json) as T;
			case UserMarketRankRankMouth:
				return userMarketRankRankMouthFromJson(data as UserMarketRankRankMouth, json) as T;
			case AgentSystemEntity:
				return agentSystemEntityFromJson(data as AgentSystemEntity, json) as T;
			case AgentSystemList:
				return agentSystemListFromJson(data as AgentSystemList, json) as T;
			case AgentSystemListAgentList:
				return agentSystemListAgentListFromJson(data as AgentSystemListAgentList, json) as T;
			case IntegralListEntity:
				return integralListEntityFromJson(data as IntegralListEntity, json) as T;
			case AssetsLogEntity:
				return assetsLogEntityFromJson(data as AssetsLogEntity, json) as T;
			case AssetsLogList:
				return assetsLogListFromJson(data as AssetsLogList, json) as T;
			case UserRechargeBankEntity:
				return userRechargeBankEntityFromJson(data as UserRechargeBankEntity, json) as T;
			case WalletEntity:
				return walletEntityFromJson(data as WalletEntity, json) as T;
			case WalletWallet:
				return walletWalletFromJson(data as WalletWallet, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case ShareInfoEntity:
				return shareInfoEntityToJson(data as ShareInfoEntity);
			case ShareInfoChildList:
				return shareInfoChildListToJson(data as ShareInfoChildList);
			case GiftCertificateEntity:
				return giftCertificateEntityToJson(data as GiftCertificateEntity);
			case GoodsIndexEntity:
				return goodsIndexEntityToJson(data as GoodsIndexEntity);
			case GoodsIndexGoodsList:
				return goodsIndexGoodsListToJson(data as GoodsIndexGoodsList);
			case OrderListEntity:
				return orderListEntityToJson(data as OrderListEntity);
			case OrderListGood:
				return orderListGoodToJson(data as OrderListGood);
			case ReciveListEntity:
				return reciveListEntityToJson(data as ReciveListEntity);
			case GoodsGearEntity:
				return goodsGearEntityToJson(data as GoodsGearEntity);
			case CategoryListEntity:
				return categoryListEntityToJson(data as CategoryListEntity);
			case UserInfoEntity:
				return userInfoEntityToJson(data as UserInfoEntity);
			case GetAppConfigEntity:
				return getAppConfigEntityToJson(data as GetAppConfigEntity);
			case BankCardInfoEntity:
				return bankCardInfoEntityToJson(data as BankCardInfoEntity);
			case GoldOrderListEntity:
				return goldOrderListEntityToJson(data as GoldOrderListEntity);
			case GoldOrderListGood:
				return goldOrderListGoodToJson(data as GoldOrderListGood);
			case AssetsEntity:
				return assetsEntityToJson(data as AssetsEntity);
			case AssetsTotal:
				return assetsTotalToJson(data as AssetsTotal);
			case AssetsCurrencyList:
				return assetsCurrencyListToJson(data as AssetsCurrencyList);
			case UserRechargeEntity:
				return userRechargeEntityToJson(data as UserRechargeEntity);
			case RechargeInfoEntity:
				return rechargeInfoEntityToJson(data as RechargeInfoEntity);
			case AssetsListEntity:
				return assetsListEntityToJson(data as AssetsListEntity);
			case StoreListEntity:
				return storeListEntityToJson(data as StoreListEntity);
			case GoodsListEntity:
				return goodsListEntityToJson(data as GoodsListEntity);
			case OrderPayEntity:
				return orderPayEntityToJson(data as OrderPayEntity);
			case PlayArticleListEntity:
				return playArticleListEntityToJson(data as PlayArticleListEntity);
			case PlayArticleListFile:
				return playArticleListFileToJson(data as PlayArticleListFile);
			case PlayArticleListLiker:
				return playArticleListLikerToJson(data as PlayArticleListLiker);
			case PlayArticleListCommant:
				return playArticleListCommantToJson(data as PlayArticleListCommant);
			case BankcardListEntity:
				return bankcardListEntityToJson(data as BankcardListEntity);
			case PledgeListEntity:
				return pledgeListEntityToJson(data as PledgeListEntity);
			case StoreInfoEntity:
				return storeInfoEntityToJson(data as StoreInfoEntity);
			case MemberSystemEntity:
				return memberSystemEntityToJson(data as MemberSystemEntity);
			case MemberSystemList:
				return memberSystemListToJson(data as MemberSystemList);
			case CollectionListEntity:
				return collectionListEntityToJson(data as CollectionListEntity);
			case BannerListEntity:
				return bannerListEntityToJson(data as BannerListEntity);
			case ArticleListEntity:
				return articleListEntityToJson(data as ArticleListEntity);
			case ConfirmOrderEntity:
				return confirmOrderEntityToJson(data as ConfirmOrderEntity);
			case ConfirmOrderCouponRecive:
				return confirmOrderCouponReciveToJson(data as ConfirmOrderCouponRecive);
			case ConfirmOrderGood:
				return confirmOrderGoodToJson(data as ConfirmOrderGood);
			case PlayLabelEntity:
				return playLabelEntityToJson(data as PlayLabelEntity);
			case PaymentAccountEntity:
				return paymentAccountEntityToJson(data as PaymentAccountEntity);
			case UserMarketRankEntity:
				return userMarketRankEntityToJson(data as UserMarketRankEntity);
			case UserMarketRankRankYear:
				return userMarketRankRankYearToJson(data as UserMarketRankRankYear);
			case UserMarketRankRankMouth:
				return userMarketRankRankMouthToJson(data as UserMarketRankRankMouth);
			case AgentSystemEntity:
				return agentSystemEntityToJson(data as AgentSystemEntity);
			case AgentSystemList:
				return agentSystemListToJson(data as AgentSystemList);
			case AgentSystemListAgentList:
				return agentSystemListAgentListToJson(data as AgentSystemListAgentList);
			case IntegralListEntity:
				return integralListEntityToJson(data as IntegralListEntity);
			case AssetsLogEntity:
				return assetsLogEntityToJson(data as AssetsLogEntity);
			case AssetsLogList:
				return assetsLogListToJson(data as AssetsLogList);
			case UserRechargeBankEntity:
				return userRechargeBankEntityToJson(data as UserRechargeBankEntity);
			case WalletEntity:
				return walletEntityToJson(data as WalletEntity);
			case WalletWallet:
				return walletWalletToJson(data as WalletWallet);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (ShareInfoEntity).toString()){
			return ShareInfoEntity().fromJson(json);
		}	else if(type == (ShareInfoChildList).toString()){
			return ShareInfoChildList().fromJson(json);
		}	else if(type == (GiftCertificateEntity).toString()){
			return GiftCertificateEntity().fromJson(json);
		}	else if(type == (GoodsIndexEntity).toString()){
			return GoodsIndexEntity().fromJson(json);
		}	else if(type == (GoodsIndexGoodsList).toString()){
			return GoodsIndexGoodsList().fromJson(json);
		}	else if(type == (OrderListEntity).toString()){
			return OrderListEntity().fromJson(json);
		}	else if(type == (OrderListGood).toString()){
			return OrderListGood().fromJson(json);
		}	else if(type == (ReciveListEntity).toString()){
			return ReciveListEntity().fromJson(json);
		}	else if(type == (GoodsGearEntity).toString()){
			return GoodsGearEntity().fromJson(json);
		}	else if(type == (CategoryListEntity).toString()){
			return CategoryListEntity().fromJson(json);
		}	else if(type == (UserInfoEntity).toString()){
			return UserInfoEntity().fromJson(json);
		}	else if(type == (GetAppConfigEntity).toString()){
			return GetAppConfigEntity().fromJson(json);
		}	else if(type == (BankCardInfoEntity).toString()){
			return BankCardInfoEntity().fromJson(json);
		}	else if(type == (GoldOrderListEntity).toString()){
			return GoldOrderListEntity().fromJson(json);
		}	else if(type == (GoldOrderListGood).toString()){
			return GoldOrderListGood().fromJson(json);
		}	else if(type == (AssetsEntity).toString()){
			return AssetsEntity().fromJson(json);
		}	else if(type == (AssetsTotal).toString()){
			return AssetsTotal().fromJson(json);
		}	else if(type == (AssetsCurrencyList).toString()){
			return AssetsCurrencyList().fromJson(json);
		}	else if(type == (UserRechargeEntity).toString()){
			return UserRechargeEntity().fromJson(json);
		}	else if(type == (RechargeInfoEntity).toString()){
			return RechargeInfoEntity().fromJson(json);
		}	else if(type == (AssetsListEntity).toString()){
			return AssetsListEntity().fromJson(json);
		}	else if(type == (StoreListEntity).toString()){
			return StoreListEntity().fromJson(json);
		}	else if(type == (GoodsListEntity).toString()){
			return GoodsListEntity().fromJson(json);
		}	else if(type == (OrderPayEntity).toString()){
			return OrderPayEntity().fromJson(json);
		}	else if(type == (PlayArticleListEntity).toString()){
			return PlayArticleListEntity().fromJson(json);
		}	else if(type == (PlayArticleListFile).toString()){
			return PlayArticleListFile().fromJson(json);
		}	else if(type == (PlayArticleListLiker).toString()){
			return PlayArticleListLiker().fromJson(json);
		}	else if(type == (PlayArticleListCommant).toString()){
			return PlayArticleListCommant().fromJson(json);
		}	else if(type == (BankcardListEntity).toString()){
			return BankcardListEntity().fromJson(json);
		}	else if(type == (PledgeListEntity).toString()){
			return PledgeListEntity().fromJson(json);
		}	else if(type == (StoreInfoEntity).toString()){
			return StoreInfoEntity().fromJson(json);
		}	else if(type == (MemberSystemEntity).toString()){
			return MemberSystemEntity().fromJson(json);
		}	else if(type == (MemberSystemList).toString()){
			return MemberSystemList().fromJson(json);
		}	else if(type == (CollectionListEntity).toString()){
			return CollectionListEntity().fromJson(json);
		}	else if(type == (BannerListEntity).toString()){
			return BannerListEntity().fromJson(json);
		}	else if(type == (ArticleListEntity).toString()){
			return ArticleListEntity().fromJson(json);
		}	else if(type == (ConfirmOrderEntity).toString()){
			return ConfirmOrderEntity().fromJson(json);
		}	else if(type == (ConfirmOrderCouponRecive).toString()){
			return ConfirmOrderCouponRecive().fromJson(json);
		}	else if(type == (ConfirmOrderGood).toString()){
			return ConfirmOrderGood().fromJson(json);
		}	else if(type == (PlayLabelEntity).toString()){
			return PlayLabelEntity().fromJson(json);
		}	else if(type == (PaymentAccountEntity).toString()){
			return PaymentAccountEntity().fromJson(json);
		}	else if(type == (UserMarketRankEntity).toString()){
			return UserMarketRankEntity().fromJson(json);
		}	else if(type == (UserMarketRankRankYear).toString()){
			return UserMarketRankRankYear().fromJson(json);
		}	else if(type == (UserMarketRankRankMouth).toString()){
			return UserMarketRankRankMouth().fromJson(json);
		}	else if(type == (AgentSystemEntity).toString()){
			return AgentSystemEntity().fromJson(json);
		}	else if(type == (AgentSystemList).toString()){
			return AgentSystemList().fromJson(json);
		}	else if(type == (AgentSystemListAgentList).toString()){
			return AgentSystemListAgentList().fromJson(json);
		}	else if(type == (IntegralListEntity).toString()){
			return IntegralListEntity().fromJson(json);
		}	else if(type == (AssetsLogEntity).toString()){
			return AssetsLogEntity().fromJson(json);
		}	else if(type == (AssetsLogList).toString()){
			return AssetsLogList().fromJson(json);
		}	else if(type == (UserRechargeBankEntity).toString()){
			return UserRechargeBankEntity().fromJson(json);
		}	else if(type == (WalletEntity).toString()){
			return WalletEntity().fromJson(json);
		}	else if(type == (WalletWallet).toString()){
			return WalletWallet().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<ShareInfoEntity>[] is M){
			return data.map<ShareInfoEntity>((e) => ShareInfoEntity().fromJson(e)).toList() as M;
		}	else if(<ShareInfoChildList>[] is M){
			return data.map<ShareInfoChildList>((e) => ShareInfoChildList().fromJson(e)).toList() as M;
		}	else if(<GiftCertificateEntity>[] is M){
			return data.map<GiftCertificateEntity>((e) => GiftCertificateEntity().fromJson(e)).toList() as M;
		}	else if(<GoodsIndexEntity>[] is M){
			return data.map<GoodsIndexEntity>((e) => GoodsIndexEntity().fromJson(e)).toList() as M;
		}	else if(<GoodsIndexGoodsList>[] is M){
			return data.map<GoodsIndexGoodsList>((e) => GoodsIndexGoodsList().fromJson(e)).toList() as M;
		}	else if(<OrderListEntity>[] is M){
			return data.map<OrderListEntity>((e) => OrderListEntity().fromJson(e)).toList() as M;
		}	else if(<OrderListGood>[] is M){
			return data.map<OrderListGood>((e) => OrderListGood().fromJson(e)).toList() as M;
		}	else if(<ReciveListEntity>[] is M){
			return data.map<ReciveListEntity>((e) => ReciveListEntity().fromJson(e)).toList() as M;
		}	else if(<GoodsGearEntity>[] is M){
			return data.map<GoodsGearEntity>((e) => GoodsGearEntity().fromJson(e)).toList() as M;
		}	else if(<CategoryListEntity>[] is M){
			return data.map<CategoryListEntity>((e) => CategoryListEntity().fromJson(e)).toList() as M;
		}	else if(<UserInfoEntity>[] is M){
			return data.map<UserInfoEntity>((e) => UserInfoEntity().fromJson(e)).toList() as M;
		}	else if(<GetAppConfigEntity>[] is M){
			return data.map<GetAppConfigEntity>((e) => GetAppConfigEntity().fromJson(e)).toList() as M;
		}	else if(<BankCardInfoEntity>[] is M){
			return data.map<BankCardInfoEntity>((e) => BankCardInfoEntity().fromJson(e)).toList() as M;
		}	else if(<GoldOrderListEntity>[] is M){
			return data.map<GoldOrderListEntity>((e) => GoldOrderListEntity().fromJson(e)).toList() as M;
		}	else if(<GoldOrderListGood>[] is M){
			return data.map<GoldOrderListGood>((e) => GoldOrderListGood().fromJson(e)).toList() as M;
		}	else if(<AssetsEntity>[] is M){
			return data.map<AssetsEntity>((e) => AssetsEntity().fromJson(e)).toList() as M;
		}	else if(<AssetsTotal>[] is M){
			return data.map<AssetsTotal>((e) => AssetsTotal().fromJson(e)).toList() as M;
		}	else if(<AssetsCurrencyList>[] is M){
			return data.map<AssetsCurrencyList>((e) => AssetsCurrencyList().fromJson(e)).toList() as M;
		}	else if(<UserRechargeEntity>[] is M){
			return data.map<UserRechargeEntity>((e) => UserRechargeEntity().fromJson(e)).toList() as M;
		}	else if(<RechargeInfoEntity>[] is M){
			return data.map<RechargeInfoEntity>((e) => RechargeInfoEntity().fromJson(e)).toList() as M;
		}	else if(<AssetsListEntity>[] is M){
			return data.map<AssetsListEntity>((e) => AssetsListEntity().fromJson(e)).toList() as M;
		}	else if(<StoreListEntity>[] is M){
			return data.map<StoreListEntity>((e) => StoreListEntity().fromJson(e)).toList() as M;
		}	else if(<GoodsListEntity>[] is M){
			return data.map<GoodsListEntity>((e) => GoodsListEntity().fromJson(e)).toList() as M;
		}	else if(<OrderPayEntity>[] is M){
			return data.map<OrderPayEntity>((e) => OrderPayEntity().fromJson(e)).toList() as M;
		}	else if(<PlayArticleListEntity>[] is M){
			return data.map<PlayArticleListEntity>((e) => PlayArticleListEntity().fromJson(e)).toList() as M;
		}	else if(<PlayArticleListFile>[] is M){
			return data.map<PlayArticleListFile>((e) => PlayArticleListFile().fromJson(e)).toList() as M;
		}	else if(<PlayArticleListLiker>[] is M){
			return data.map<PlayArticleListLiker>((e) => PlayArticleListLiker().fromJson(e)).toList() as M;
		}	else if(<PlayArticleListCommant>[] is M){
			return data.map<PlayArticleListCommant>((e) => PlayArticleListCommant().fromJson(e)).toList() as M;
		}	else if(<BankcardListEntity>[] is M){
			return data.map<BankcardListEntity>((e) => BankcardListEntity().fromJson(e)).toList() as M;
		}	else if(<PledgeListEntity>[] is M){
			return data.map<PledgeListEntity>((e) => PledgeListEntity().fromJson(e)).toList() as M;
		}	else if(<StoreInfoEntity>[] is M){
			return data.map<StoreInfoEntity>((e) => StoreInfoEntity().fromJson(e)).toList() as M;
		}	else if(<MemberSystemEntity>[] is M){
			return data.map<MemberSystemEntity>((e) => MemberSystemEntity().fromJson(e)).toList() as M;
		}	else if(<MemberSystemList>[] is M){
			return data.map<MemberSystemList>((e) => MemberSystemList().fromJson(e)).toList() as M;
		}	else if(<CollectionListEntity>[] is M){
			return data.map<CollectionListEntity>((e) => CollectionListEntity().fromJson(e)).toList() as M;
		}	else if(<BannerListEntity>[] is M){
			return data.map<BannerListEntity>((e) => BannerListEntity().fromJson(e)).toList() as M;
		}	else if(<ArticleListEntity>[] is M){
			return data.map<ArticleListEntity>((e) => ArticleListEntity().fromJson(e)).toList() as M;
		}	else if(<ConfirmOrderEntity>[] is M){
			return data.map<ConfirmOrderEntity>((e) => ConfirmOrderEntity().fromJson(e)).toList() as M;
		}	else if(<ConfirmOrderCouponRecive>[] is M){
			return data.map<ConfirmOrderCouponRecive>((e) => ConfirmOrderCouponRecive().fromJson(e)).toList() as M;
		}	else if(<ConfirmOrderGood>[] is M){
			return data.map<ConfirmOrderGood>((e) => ConfirmOrderGood().fromJson(e)).toList() as M;
		}	else if(<PlayLabelEntity>[] is M){
			return data.map<PlayLabelEntity>((e) => PlayLabelEntity().fromJson(e)).toList() as M;
		}	else if(<PaymentAccountEntity>[] is M){
			return data.map<PaymentAccountEntity>((e) => PaymentAccountEntity().fromJson(e)).toList() as M;
		}	else if(<UserMarketRankEntity>[] is M){
			return data.map<UserMarketRankEntity>((e) => UserMarketRankEntity().fromJson(e)).toList() as M;
		}	else if(<UserMarketRankRankYear>[] is M){
			return data.map<UserMarketRankRankYear>((e) => UserMarketRankRankYear().fromJson(e)).toList() as M;
		}	else if(<UserMarketRankRankMouth>[] is M){
			return data.map<UserMarketRankRankMouth>((e) => UserMarketRankRankMouth().fromJson(e)).toList() as M;
		}	else if(<AgentSystemEntity>[] is M){
			return data.map<AgentSystemEntity>((e) => AgentSystemEntity().fromJson(e)).toList() as M;
		}	else if(<AgentSystemList>[] is M){
			return data.map<AgentSystemList>((e) => AgentSystemList().fromJson(e)).toList() as M;
		}	else if(<AgentSystemListAgentList>[] is M){
			return data.map<AgentSystemListAgentList>((e) => AgentSystemListAgentList().fromJson(e)).toList() as M;
		}	else if(<IntegralListEntity>[] is M){
			return data.map<IntegralListEntity>((e) => IntegralListEntity().fromJson(e)).toList() as M;
		}	else if(<AssetsLogEntity>[] is M){
			return data.map<AssetsLogEntity>((e) => AssetsLogEntity().fromJson(e)).toList() as M;
		}	else if(<AssetsLogList>[] is M){
			return data.map<AssetsLogList>((e) => AssetsLogList().fromJson(e)).toList() as M;
		}	else if(<UserRechargeBankEntity>[] is M){
			return data.map<UserRechargeBankEntity>((e) => UserRechargeBankEntity().fromJson(e)).toList() as M;
		}	else if(<WalletEntity>[] is M){
			return data.map<WalletEntity>((e) => WalletEntity().fromJson(e)).toList() as M;
		}	else if(<WalletWallet>[] is M){
			return data.map<WalletWallet>((e) => WalletWallet().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}