import 'package:mars/models/pool_detail_entity.dart';

poolDetailEntityFromJson(PoolDetailEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['product_period'] != null) {
		data.productPeriod = json['product_period'].toString();
	}
	if (json['product_name'] != null) {
		data.productName = json['product_name'].toString();
	}
	if (json['product_pay_currency'] != null) {
		data.productPayCurrency = json['product_pay_currency'].toString();
	}
	if (json['product_pay_max_amount'] != null) {
		data.productPayMaxAmount = json['product_pay_max_amount'].toString();
	}
	if (json['product_pay_min_amount'] != null) {
		data.productPayMinAmount = json['product_pay_min_amount'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['is_buy'] != null) {
		data.isBuy = json['is_buy'].toString();
	}
	if (json['product_total_amount'] != null) {
		data.productTotalAmount = json['product_total_amount'].toString();
	}
	if (json['product_pool_amount'] != null) {
		data.productPoolAmount = json['product_pool_amount'].toString();
	}
	if (json['people_count'] != null) {
		data.peopleCount = json['people_count'].toString();
	}
	if (json['my_group'] != null) {
		data.myGroup = json['my_group'].toString();
	}
	if (json['my_pool'] != null) {
		data.myPool = json['my_pool'].toString();
	}
	if (json['activate_status'] != null) {
		data.activateStatus = json['activate_status'].toString();
	}
	return data;
}

Map<String, dynamic> poolDetailEntityToJson(PoolDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['product_period'] = entity.productPeriod;
	data['product_name'] = entity.productName;
	data['product_pay_currency'] = entity.productPayCurrency;
	data['product_pay_max_amount'] = entity.productPayMaxAmount;
	data['product_pay_min_amount'] = entity.productPayMinAmount;
	data['create_time'] = entity.createTime;
	data['is_buy'] = entity.isBuy;
	data['product_total_amount'] = entity.productTotalAmount;
	data['product_pool_amount'] = entity.productPoolAmount;
	data['people_count'] = entity.peopleCount;
	data['my_group'] = entity.myGroup;
	data['my_pool'] = entity.myPool;
	data['activate_status'] = entity.activateStatus;
	return data;
}