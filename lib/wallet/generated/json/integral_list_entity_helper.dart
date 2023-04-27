import 'package:mars/wallet/mobels/integral_list_entity.dart';

integralListEntityFromJson(IntegralListEntity data, Map<String, dynamic> json) {
	if (json['order_amount'] != null) {
		data.orderAmount = json['order_amount'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	return data;
}

Map<String, dynamic> integralListEntityToJson(IntegralListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['order_amount'] = entity.orderAmount;
	data['create_time'] = entity.createTime;
	return data;
}