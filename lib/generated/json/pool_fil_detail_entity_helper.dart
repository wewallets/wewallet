import 'package:mars/models/pool_fil_detail_entity.dart';

poolFilDetailEntityFromJson(PoolFilDetailEntity data, Map<String, dynamic> json) {
	if (json['log_list'] != null) {
		data.logList = (json['log_list'] as List).map((v) => PoolFilDetailLogList().fromJson(v)).toList();
	}
	if (json['assets_FIL'] != null) {
		data.assetsFil = json['assets_FIL'].toString();
	}
	if (json['use_FIL'] != null) {
		data.useFil = json['use_FIL'].toString();
	}
	if (json['7days_award'] != null) {
		data.x7daysAward = json['7days_award'].toString();
	}
	if (json['fil_pool_tlevel'] != null) {
		data.filPoolTlevel = json['fil_pool_tlevel'].toString();
	}
	if (json['fil_pool_real_tlevel'] != null) {
		data.filPoolRealTlevel = json['fil_pool_real_tlevel'].toString();
	}
	if (json['fil_pool_release_total'] != null) {
		data.filPoolReleaseTotal = json['fil_pool_release_total'].toString();
	}
	if (json['fil_pool_total'] != null) {
		data.filPoolTotal = json['fil_pool_total'].toString();
	}
	if (json['fil_pool_tlevel_percen'] != null) {
		data.filPoolTlevelPercen = json['fil_pool_tlevel_percen'].toString();
	}
	if (json['fil_pool_release_percen'] != null) {
		data.filPoolReleasePercen = json['fil_pool_release_percen'].toString();
	}
	return data;
}

Map<String, dynamic> poolFilDetailEntityToJson(PoolFilDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['log_list'] =  entity.logList?.map((v) => v.toJson())?.toList();
	data['assets_FIL'] = entity.assetsFil;
	data['use_FIL'] = entity.useFil;
	data['7days_award'] = entity.x7daysAward;
	data['fil_pool_tlevel'] = entity.filPoolTlevel;
	data['fil_pool_real_tlevel'] = entity.filPoolRealTlevel;
	data['fil_pool_release_total'] = entity.filPoolReleaseTotal;
	data['fil_pool_total'] = entity.filPoolTotal;
	data['fil_pool_tlevel_percen'] = entity.filPoolTlevelPercen;
	data['fil_pool_release_percen'] = entity.filPoolReleasePercen;
	return data;
}

poolFilDetailLogListFromJson(PoolFilDetailLogList data, Map<String, dynamic> json) {
	if (json['date'] != null) {
		data.date = json['date'].toString();
	}
	if (json['award'] != null) {
		data.award = json['award'].toString();
	}
	return data;
}

Map<String, dynamic> poolFilDetailLogListToJson(PoolFilDetailLogList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['award'] = entity.award;
	return data;
}