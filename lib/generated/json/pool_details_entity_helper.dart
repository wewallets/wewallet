import 'package:mars/models/pool_details_entity.dart';

poolDetailsEntityFromJson(PoolDetailsEntity data, Map<String, dynamic> json) {
	if (json['log_list'] != null) {
		data.logList = (json['log_list'] as List).map((v) => PoolDetailsLogList().fromJson(v)).toList();
	}
	if (json['total_award_yesterday'] != null) {
		data.totalAwardYesterday = json['total_award_yesterday'].toString();
	}
	if (json['total_award_yesterday_usdt'] != null) {
		data.totalAwardYesterdayUsdt = json['total_award_yesterday_usdt'].toString();
	}
	if (json['total_award'] != null) {
		data.totalAward = json['total_award'].toString();
	}
	if (json['rise_pool_best_limit'] != null) {
		data.risePoolBestLimit = json['rise_pool_best_limit'].toString();
	}
	if (json['rise_pool_min_keep'] != null) {
		data.risePoolMinKeep = json['rise_pool_min_keep'].toString();
	}
	if (json['process_award'] != null) {
		data.processAward = json['process_award'].toString();
	}
	if (json['keep_award'] != null) {
		data.keepAward = json['keep_award'].toString();
	}
	return data;
}

Map<String, dynamic> poolDetailsEntityToJson(PoolDetailsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['log_list'] =  entity.logList?.map((v) => v.toJson())?.toList();
	data['total_award_yesterday'] = entity.totalAwardYesterday;
	data['total_award_yesterday_usdt'] = entity.totalAwardYesterdayUsdt;
	data['total_award'] = entity.totalAward;
	data['rise_pool_best_limit'] = entity.risePoolBestLimit;
	data['rise_pool_min_keep'] = entity.risePoolMinKeep;
	data['process_award'] = entity.processAward;
	data['keep_award'] = entity.keepAward;
	return data;
}

poolDetailsLogListFromJson(PoolDetailsLogList data, Map<String, dynamic> json) {
	if (json['date'] != null) {
		data.date = json['date'].toString();
	}
	if (json['award'] != null) {
		data.award = json['award'].toString();
	}
	if (json['rate_return'] != null) {
		data.rateReturn = json['rate_return'].toString();
	}
	return data;
}

Map<String, dynamic> poolDetailsLogListToJson(PoolDetailsLogList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['award'] = entity.award;
	data['rate_return'] = entity.rateReturn;
	return data;
}