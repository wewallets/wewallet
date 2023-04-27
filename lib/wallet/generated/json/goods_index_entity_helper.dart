import 'package:mars/wallet/mobels/goods_index_entity.dart';

goodsIndexEntityFromJson(GoodsIndexEntity data, Map<String, dynamic> json) {
	if (json['goods_list'] != null) {
		data.goodsList = (json['goods_list'] as List).map((v) => GoodsIndexGoodsList().fromJson(v)).toList();
	}
	if (json['index_bmg'] != null) {
		data.indexBmg = json['index_bmg'].toString();
	}
	return data;
}

Map<String, dynamic> goodsIndexEntityToJson(GoodsIndexEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goods_list'] =  entity.goodsList?.map((v) => v.toJson())?.toList();
	data['index_bmg'] = entity.indexBmg;
	return data;
}

goodsIndexGoodsListFromJson(GoodsIndexGoodsList data, Map<String, dynamic> json) {
	if (json['goods_id'] != null) {
		data.goodsId = json['goods_id'].toString();
	}
	if (json['goods_name'] != null) {
		data.goodsName = json['goods_name'].toString();
	}
	if (json['shop_price'] != null) {
		data.shopPrice = json['shop_price'].toString();
	}
	if (json['goods_thumb'] != null) {
		data.goodsThumb = json['goods_thumb'].toString();
	}
	if (json['gcount'] != null) {
		data.gcount = json['gcount'].toString();
	}
	return data;
}

Map<String, dynamic> goodsIndexGoodsListToJson(GoodsIndexGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goods_id'] = entity.goodsId;
	data['goods_name'] = entity.goodsName;
	data['shop_price'] = entity.shopPrice;
	data['goods_thumb'] = entity.goodsThumb;
	data['gcount'] = entity.gcount;
	return data;
}