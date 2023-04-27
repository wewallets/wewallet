import 'package:mars/wallet/mobels/gold_order_list_entity.dart';

goldOrderListEntityFromJson(GoldOrderListEntity data, Map<String, dynamic> json) {
	if (json['order_express'] != null) {
		data.orderExpress = json['order_express'];
	}
	if (json['gold_order_id'] != null) {
		data.goldOrderId = json['gold_order_id'].toString();
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
	if (json['pay_type'] != null) {
		data.payType = json['pay_type'].toString();
	}
	if (json['add_time'] != null) {
		data.addTime = json['add_time'].toString();
	}
	if (json['shipping_time'] != null) {
		data.shippingTime = json['shipping_time'].toString();
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
	if (json['shipping_type'] != null) {
		data.shippingType = json['shipping_type'].toString();
	}
	if (json['status_name'] != null) {
		data.statusName = json['status_name'].toString();
	}
	if (json['invoice_no'] != null) {
		data.invoiceNo = json['invoice_no'].toString();
	}
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => GoldOrderListGood().fromJson(v)).toList();
	}
	if (json['store_address'] != null) {
		data.storeAddress = json['store_address'].toString();
	}
	if (json['store_name'] != null) {
		data.storeName = json['store_name'].toString();
	}
	if (json['store_mobile'] != null) {
		data.storeMobile = json['store_mobile'].toString();
	}
	return data;
}

Map<String, dynamic> goldOrderListEntityToJson(GoldOrderListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['order_express'] = entity.orderExpress;
	data['gold_order_id'] = entity.goldOrderId;
	data['order_sn'] = entity.orderSn;
	data['order_amount'] = entity.orderAmount;
	data['shipping_status'] = entity.shippingStatus;
	data['receipt_time'] = entity.receiptTime;
	data['pay_type'] = entity.payType;
	data['add_time'] = entity.addTime;
	data['shipping_time'] = entity.shippingTime;
	data['address_id'] = entity.addressId;
	data['consignee'] = entity.consignee;
	data['province_name'] = entity.provinceName;
	data['city_name'] = entity.cityName;
	data['district_name'] = entity.districtName;
	data['address'] = entity.address;
	data['mobile'] = entity.mobile;
	data['shipping_type'] = entity.shippingType;
	data['status_name'] = entity.statusName;
	data['invoice_no'] = entity.invoiceNo;
	data['goods'] =  entity.goods?.map((v) => v.toJson())?.toList();
	data['store_address'] = entity.storeAddress;
	data['store_name'] = entity.storeName;
	data['store_mobile'] = entity.storeMobile;
	return data;
}

goldOrderListGoodFromJson(GoldOrderListGood data, Map<String, dynamic> json) {
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
	if (json['goods_thumb'] != null) {
		data.goodsThumb = json['goods_thumb'].toString();
	}
	return data;
}

Map<String, dynamic> goldOrderListGoodToJson(GoldOrderListGood entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rec_id'] = entity.recId;
	data['goods_id'] = entity.goodsId;
	data['goods_name'] = entity.goodsName;
	data['goods_number'] = entity.goodsNumber;
	data['goods_thumb'] = entity.goodsThumb;
	return data;
}