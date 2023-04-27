import 'package:mars/models/miner_list_entity.dart';

minerListEntityFromJson(MinerListEntity data, Map<String, dynamic> json) {
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['child_number'] != null) {
		data.childNumber = json['child_number'].toString();
	}
	if (json['investment_current'] != null) {
		data.investmentCurrent = json['investment_current'].toString();
	}
	if (json['revenue_current'] != null) {
		data.revenueCurrent = json['revenue_current'].toString();
	}
	if (json['balance_total'] != null) {
		data.balanceTotal = json['balance_total'].toString();
	}
	return data;
}

Map<String, dynamic> minerListEntityToJson(MinerListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['address'] = entity.address;
	data['child_number'] = entity.childNumber;
	data['investment_current'] = entity.investmentCurrent;
	data['revenue_current'] = entity.revenueCurrent;
	data['balance_total'] = entity.balanceTotal;
	return data;
}