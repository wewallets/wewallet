import 'package:mars/models/pool_list_entity.dart';

poolListEntityFromJson(PoolListEntity data, Map<String, dynamic> json) {
	if (json['RISE'] != null) {
		data.rISE = PoolListRISE().fromJson(json['RISE']);
	}
	if (json['FIL'] != null) {
		data.fIL = PoolListFIL().fromJson(json['FIL']);
	}
	return data;
}

Map<String, dynamic> poolListEntityToJson(PoolListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['RISE'] = entity.rISE?.toJson();
	data['FIL'] = entity.fIL?.toJson();
	return data;
}

poolListRISEFromJson(PoolListRISE data, Map<String, dynamic> json) {
	if (json['yesterday_award'] != null) {
		data.yesterdayAward = json['yesterday_award'].toString();
	}
	if (json['yesterday_award_usdt'] != null) {
		data.yesterdayAwardUsdt = json['yesterday_award_usdt'].toString();
	}
	if (json['all_award'] != null) {
		data.allAward = json['all_award'].toString();
	}
	if (json['all_award_usdt'] != null) {
		data.allAwardUsdt = json['all_award_usdt'].toString();
	}
	if (json['process_award'] != null) {
		data.processAward = json['process_award'].toString();
	}
	if (json['popul_award'] != null) {
		data.populAward = json['popul_award'].toString();
	}
	if (json['rise_pool_best_limit'] != null) {
		data.risePoolBestLimit = json['rise_pool_best_limit'].toString();
	}
	if (json['rise_pool_min_keep'] != null) {
		data.risePoolMinKeep = json['rise_pool_min_keep'].toString();
	}
	return data;
}

Map<String, dynamic> poolListRISEToJson(PoolListRISE entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['yesterday_award'] = entity.yesterdayAward;
	data['yesterday_award_usdt'] = entity.yesterdayAwardUsdt;
	data['all_award'] = entity.allAward;
	data['all_award_usdt'] = entity.allAwardUsdt;
	data['process_award'] = entity.processAward;
	data['popul_award'] = entity.populAward;
	data['rise_pool_best_limit'] = entity.risePoolBestLimit;
	data['rise_pool_min_keep'] = entity.risePoolMinKeep;
	return data;
}

poolListFILFromJson(PoolListFIL data, Map<String, dynamic> json) {
	if (json['assets_FIL'] != null) {
		data.assetsFil = json['assets_FIL'].toString();
	}
	if (json['use_FIL'] != null) {
		data.useFil = json['use_FIL'].toString();
	}
	if (json['7days_award'] != null) {
		data.x7daysAward = json['7days_award'].toString();
	}
	if (json['fil_pool_release_total'] != null) {
		data.filPoolReleaseTotal = json['fil_pool_release_total'].toString();
	}
	if (json['fil_pool_total'] != null) {
		data.filPoolTotal = json['fil_pool_total'].toString();
	}
	if (json['fil_pool_release_percen'] != null) {
		data.filPoolReleasePercen = json['fil_pool_release_percen'].toString();
	}
	return data;
}

Map<String, dynamic> poolListFILToJson(PoolListFIL entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assets_FIL'] = entity.assetsFil;
	data['use_FIL'] = entity.useFil;
	data['7days_award'] = entity.x7daysAward;
	data['fil_pool_release_total'] = entity.filPoolReleaseTotal;
	data['fil_pool_total'] = entity.filPoolTotal;
	data['fil_pool_release_percen'] = entity.filPoolReleasePercen;
	return data;
}