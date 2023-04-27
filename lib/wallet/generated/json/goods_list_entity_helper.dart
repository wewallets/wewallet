import 'package:mars/wallet/mobels/goods_list_entity.dart';

goodsListEntityFromJson(GoodsListEntity data, Map<String, dynamic> json) {
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
	if (json['keywords'] != null) {
		data.keywords = json['keywords'].toString();
	}
	if (json['must_know'] != null) {
		data.mustKnow = json['must_know'].toString();
	}
	if (json['goods_thumb'] != null) {
		data.goodsThumb = json['goods_thumb'].toString();
	}
	if (json['gcount'] != null) {
		data.gcount = json['gcount'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['goods_sn'] != null) {
		data.goodsSn = json['goods_sn'].toString();
	}
	if (json['goods_weight'] != null) {
		data.goodsWeight = json['goods_weight'].toString();
	}
	if (json['goods_unit'] != null) {
		data.goodsUnit = json['goods_unit'].toString();
	}
	if (json['goods_brief'] != null) {
		data.goodsBrief = json['goods_brief'].toString();
	}
	if (json['goods_desc'] != null) {
		data.goodsDesc = json['goods_desc'].toString();
	}
	if (json['add_time'] != null) {
		data.add_time = json['add_time'].toString();
	}
	if (json['shipping_time'] != null) {
		data.shipping_time = json['shipping_time'].toString();
	}
	if (json['is_collection'] != null) {
		data.is_collection = json['is_collection'].toString();
	}
	if (json['is_gold'] != null) {
		data.isGold = json['is_gold'].toString();
	}
	if (json['is_support_repo'] != null) {
		data.is_support_repo = json['is_support_repo'].toString();
	}
	return data;
}

Map<String, dynamic> goodsListEntityToJson(GoodsListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goods_id'] = entity.goodsId;
	data['goods_name'] = entity.goodsName;
	data['shop_price'] = entity.shopPrice;
	data['market_price'] = entity.marketPrice;
	data['keywords'] = entity.keywords;
	data['must_know'] = entity.mustKnow;
	data['goods_thumb'] = entity.goodsThumb;
	data['gcount'] = entity.gcount;
	data['type'] = entity.type;
	data['goods_sn'] = entity.goodsSn;
	data['goods_weight'] = entity.goodsWeight;
	data['goods_unit'] = entity.goodsUnit;
	data['goods_brief'] = entity.goodsBrief;
	data['goods_desc'] = entity.goodsDesc;
	data['add_time'] = entity.add_time;
	data['shipping_time'] = entity.shipping_time;
	data['is_collection'] = entity.is_collection;
	data['is_gold'] = entity.isGold;
	data['is_support_repo'] = entity.is_support_repo;
	return data;
}