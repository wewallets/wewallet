import 'package:mars/wallet/mobels/collection_list_entity.dart';

collectionListEntityFromJson(CollectionListEntity data, Map<String, dynamic> json) {
	if (json['goods_id'] != null) {
		data.goodsId = json['goods_id'].toString();
	}
	if (json['goods_name'] != null) {
		data.goodsName = json['goods_name'].toString();
	}
	if (json['shop_price'] != null) {
		data.shopPrice = json['shop_price'].toString();
	}
	if (json['market_price'] != null) {
		data.marketPrice = json['market_price'].toString();
	}
	if (json['goods_thumb'] != null) {
		data.goodsThumb = json['goods_thumb'].toString();
	}
	if (json['goods_brief'] != null) {
		data.goodsBrief = json['goods_brief'].toString();
	}
	if (json['keywords'] != null) {
		data.keywords = json['keywords'].toString();
	}
	if (json['is_gold'] != null) {
		data.isGold = json['is_gold'].toString();
	}
	if (json['is_support_repo'] != null) {
		data.is_support_repo = json['is_support_repo'].toString();
	}
	return data;
}

Map<String, dynamic> collectionListEntityToJson(CollectionListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goods_id'] = entity.goodsId;
	data['goods_name'] = entity.goodsName;
	data['shop_price'] = entity.shopPrice;
	data['market_price'] = entity.marketPrice;
	data['goods_thumb'] = entity.goodsThumb;
	data['goods_brief'] = entity.goodsBrief;
	data['keywords'] = entity.keywords;
	data['is_gold'] = entity.isGold;
	data['is_support_repo'] = entity.is_support_repo;
	return data;
}