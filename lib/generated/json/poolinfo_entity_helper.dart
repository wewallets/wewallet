import 'package:mars/models/poolinfo_entity.dart';

poolinfoEntityFromJson(PoolinfoEntity data, Map<String, dynamic> json) {
	if (json['total_award'] != null) {
		data.totalAward = json['total_award'].toString();
	}
	if (json['yesterday_award'] != null) {
		data.yesterdayAward = json['yesterday_award'].toString();
	}
	if (json['total_destroy'] != null) {
		data.totalDestroy = json['total_destroy'].toString();
	}
	if (json['yesterday_destroy'] != null) {
		data.yesterdayDestroy = json['yesterday_destroy'].toString();
	}
	if (json['ledger_index'] != null) {
		data.ledgerIndex = json['ledger_index'].toString();
	}
	return data;
}

Map<String, dynamic> poolinfoEntityToJson(PoolinfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total_award'] = entity.totalAward;
	data['yesterday_award'] = entity.yesterdayAward;
	data['total_destroy'] = entity.totalDestroy;
	data['yesterday_destroy'] = entity.yesterdayDestroy;
	data['ledger_index'] = entity.ledgerIndex;
	return data;
}