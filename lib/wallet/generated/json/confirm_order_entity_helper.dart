import 'package:mars/wallet/mobels/confirm_order_entity.dart';

confirmOrderEntityFromJson(ConfirmOrderEntity data, Map<String, dynamic> json) {
	if (json['coupon_recive'] != null) {
		data.couponRecive = (json['coupon_recive'] as List).map((v) => ConfirmOrderCouponRecive().fromJson(v)).toList();
	}
	if (json['user_address'] != null) {
		data.userAddress = json['user_address'];
	}
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => ConfirmOrderGood().fromJson(v)).toList();
	}
	if (json['order_amount'] != null) {
		data.orderAmount = json['order_amount'].toString();
	}
	return data;
}

Map<String, dynamic> confirmOrderEntityToJson(ConfirmOrderEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coupon_recive'] =  entity.couponRecive?.map((v) => v.toJson())?.toList();
	data['user_address'] = entity.userAddress;
	data['goods'] =  entity.goods?.map((v) => v.toJson())?.toList();
	data['order_amount'] = entity.orderAmount;
	return data;
}

confirmOrderCouponReciveFromJson(ConfirmOrderCouponRecive data, Map<String, dynamic> json) {
	if (json['coupon_id'] != null) {
		data.couponId = json['coupon_id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['cat_id'] != null) {
		data.catId = json['cat_id'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'].toString();
	}
	if (json['full_amount'] != null) {
		data.fullAmount = json['full_amount'].toString();
	}
	if (json['vaild_start_time'] != null) {
		data.vaildStartTime = json['vaild_start_time'].toString();
	}
	if (json['vaild_end_time'] != null) {
		data.vaildEndTime = json['vaild_end_time'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['cat_name'] != null) {
		data.catName = json['cat_name'].toString();
	}
	return data;
}

Map<String, dynamic> confirmOrderCouponReciveToJson(ConfirmOrderCouponRecive entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coupon_id'] = entity.couponId;
	data['name'] = entity.name;
	data['cat_id'] = entity.catId;
	data['amount'] = entity.amount;
	data['full_amount'] = entity.fullAmount;
	data['vaild_start_time'] = entity.vaildStartTime;
	data['vaild_end_time'] = entity.vaildEndTime;
	data['create_time'] = entity.createTime;
	data['cat_name'] = entity.catName;
	return data;
}

confirmOrderGoodFromJson(ConfirmOrderGood data, Map<String, dynamic> json) {
	if (json['goods_id'] != null) {
		data.goodsId = json['goods_id'].toString();
	}
	if (json['goods_name'] != null) {
		data.goodsName = json['goods_name'].toString();
	}
	if (json['goods_sn'] != null) {
		data.goodsSn = json['goods_sn'].toString();
	}
	if (json['shop_price'] != null) {
		data.shopPrice = json['shop_price'].toString();
	}
	if (json['goods_number'] != null) {
		data.goodsNumber = json['goods_number'].toString();
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
	if (json['goods_desc'] != null) {
		data.goodsDesc = json['goods_desc'].toString();
	}
	if (json['keywords'] != null) {
		data.keywords = json['keywords'].toString();
	}
	if (json['cat_id'] != null) {
		data.catId = json['cat_id'].toString();
	}
	return data;
}

Map<String, dynamic> confirmOrderGoodToJson(ConfirmOrderGood entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goods_id'] = entity.goodsId;
	data['goods_name'] = entity.goodsName;
	data['goods_sn'] = entity.goodsSn;
	data['shop_price'] = entity.shopPrice;
	data['goods_number'] = entity.goodsNumber;
	data['market_price'] = entity.marketPrice;
	data['goods_thumb'] = entity.goodsThumb;
	data['goods_brief'] = entity.goodsBrief;
	data['goods_desc'] = entity.goodsDesc;
	data['keywords'] = entity.keywords;
	data['cat_id'] = entity.catId;
	return data;
}