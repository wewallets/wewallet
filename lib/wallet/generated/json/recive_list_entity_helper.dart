import 'package:mars/wallet/mobels/recive_list_entity.dart';

reciveListEntityFromJson(ReciveListEntity data, Map<String, dynamic> json) {
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

Map<String, dynamic> reciveListEntityToJson(ReciveListEntity entity) {
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