import 'package:mars/models/pooldetail_entity.dart';

pooldetailEntityFromJson(PooldetailEntity data, Map<String, dynamic> json) {
	if (json['log_list'] != null) {
		data.logList = (json['log_list'] as List).map((v) => PooldetailLogList().fromJson(v)).toList();
	}
	if (json['yesterday_award'] != null) {
		data.yesterdayAward = json['yesterday_award'].toString();
	}
	if (json['total_award'] != null) {
		data.totalAward = json['total_award'].toString();
	}
	if (json['best_keep'] != null) {
		data.bestKeep = json['best_keep'].toString();
	}
	if (json['min_keep'] != null) {
		data.minKeep = json['min_keep'].toString();
	}
	return data;
}

Map<String, dynamic> pooldetailEntityToJson(PooldetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['log_list'] =  entity.logList?.map((v) => v.toJson())?.toList();
	data['yesterday_award'] = entity.yesterdayAward;
	data['total_award'] = entity.totalAward;
	data['best_keep'] = entity.bestKeep;
	data['min_keep'] = entity.minKeep;
	return data;
}

pooldetailLogListFromJson(PooldetailLogList data, Map<String, dynamic> json) {
	if (json['date'] != null) {
		data.date = json['date'].toString();
	}
	if (json['award'] != null) {
		data.award = json['award'].toString();
	}
	return data;
}

Map<String, dynamic> pooldetailLogListToJson(PooldetailLogList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['award'] = entity.award;
	return data;
}