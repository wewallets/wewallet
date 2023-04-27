import 'package:mars/models/my_pool_entity.dart';

myPoolEntityFromJson(MyPoolEntity data, Map<String, dynamic> json) {
	if (json['investment_total'] != null) {
		data.investmentTotal = json['investment_total'].toString();
	}
	if (json['revenue_total'] != null) {
		data.revenueTotal = json['revenue_total'].toString();
	}
	if (json['investment_current'] != null) {
		data.investmentCurrent = json['investment_current'].toString();
	}
	if (json['investment_remind'] != null) {
		data.investmentRemind = json['investment_remind'].toString();
	}
	return data;
}

Map<String, dynamic> myPoolEntityToJson(MyPoolEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['investment_total'] = entity.investmentTotal;
	data['revenue_total'] = entity.revenueTotal;
	data['investment_current'] = entity.investmentCurrent;
	data['investment_remind'] = entity.investmentRemind;
	return data;
}