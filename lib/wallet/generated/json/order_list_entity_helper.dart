import 'package:mars/wallet/mobels/order_list_entity.dart';

orderListEntityFromJson(OrderListEntity data, Map<String, dynamic> json) {
	if (json['order_express'] != null) {
		data.orderExpress = json['order_express'];
	}
	if (json['order_id'] != null) {
		data.orderId = json['order_id'].toString();
	}
	if (json['order_sn'] != null) {
		data.orderSn = json['order_sn'].toString();
	}
	if (json['order_amount'] != null) {
		data.orderAmount = json['order_amount'].toString();
	}
	if (json['shipping_status'] != null) {
		data.shippingStatus = json['shipping_status'].toString();
	}
	if (json['receipt_time'] != null) {
		data.receiptTime = json['receipt_time'].toString();
	}
	if (json['address_id'] != null) {
		data.addressId = json['address_id'].toString();
	}
	if (json['consignee'] != null) {
		data.consignee = json['consignee'].toString();
	}
	if (json['province_name'] != null) {
		data.provinceName = json['province_name'].toString();
	}
	if (json['city_name'] != null) {
		data.cityName = json['city_name'].toString();
	}
	if (json['district_name'] != null) {
		data.districtName = json['district_name'].toString();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile'].toString();
	}
	if (json['status_name'] != null) {
		data.statusName = json['status_name'].toString();
	}
	if (json['order_type'] != null) {
		data.orderType = json['order_type'].toString();
	}
	if (json['pay_type'] != null) {
		data.payType = json['pay_type'].toString();
	}
	if (json['is_first'] != null) {
		data.isFirst = json['is_first'].toString();
	}
	if (json['add_time'] != null) {
		data.add_time = json['add_time'].toString();
	}
	if (json['shipping_time'] != null) {
		data.shipping_time = json['shipping_time'].toString();
	}
	if (json['pay_type'] != null) {
		data.pay_type = json['pay_type'].toString();
	}
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => OrderListGood().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> orderListEntityToJson(OrderListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['order_express'] = entity.orderExpress;
	data['order_id'] = entity.orderId;
	data['order_sn'] = entity.orderSn;
	data['order_amount'] = entity.orderAmount;
	data['shipping_status'] = entity.shippingStatus;
	data['receipt_time'] = entity.receiptTime;
	data['address_id'] = entity.addressId;
	data['consignee'] = entity.consignee;
	data['province_name'] = entity.provinceName;
	data['city_name'] = entity.cityName;
	data['district_name'] = entity.districtName;
	data['address'] = entity.address;
	data['mobile'] = entity.mobile;
	data['status_name'] = entity.statusName;
	data['order_type'] = entity.orderType;
	data['pay_type'] = entity.payType;
	data['is_first'] = entity.isFirst;
	data['add_time'] = entity.add_time;
	data['shipping_time'] = entity.shipping_time;
	data['pay_type'] = entity.pay_type;
	data['goods'] =  entity.goods?.map((v) => v.toJson())?.toList();
	return data;
}

orderListGoodFromJson(OrderListGood data, Map<String, dynamic> json) {
	if (json['rec_id'] != null) {
		data.recId = json['rec_id'].toString();
	}
	if (json['goods_id'] != null) {
		data.goodsId = json['goods_id'].toString();
	}
	if (json['goods_name'] != null) {
		data.goodsName = json['goods_name'].toString();
	}
	if (json['goods_number'] != null) {
		data.goodsNumber = json['goods_number'].toString();
	}
	if (json['goods_price'] != null) {
		data.goodsPrice = json['goods_price'].toString();
	}
	if (json['goods_thumb'] != null) {
		data.goodsThumb = json['goods_thumb'].toString();
	}
	if (json['shop_price'] != null) {
		data.shopPrice = json['shop_price'].toString();
	}
	return data;
}

Map<String, dynamic> orderListGoodToJson(OrderListGood entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rec_id'] = entity.recId;
	data['goods_id'] = entity.goodsId;
	data['goods_name'] = entity.goodsName;
	data['goods_number'] = entity.goodsNumber;
	data['goods_price'] = entity.goodsPrice;
	data['goods_thumb'] = entity.goodsThumb;
	data['shop_price'] = entity.shopPrice;
	return data;
}