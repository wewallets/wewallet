import 'package:mars/models/poolcontribution_entity.dart';

poolcontributionEntityFromJson(PoolcontributionEntity data, Map<String, dynamic> json) {
	if (json['team_amount'] != null) {
		data.teamAmount = json['team_amount'].toString();
	}
	if (json['genera_power'] != null) {
		data.generaPower = json['genera_power'].toString();
	}
	if (json['genera_award'] != null) {
		data.generaAward = json['genera_award'].toString();
	}
	if (json['process_award'] != null) {
		data.processAward = json['process_award'].toString();
	}
	if (json['miners_team'] != null) {
		data.minersTeam = json['miners_team'].toString();
	}
	if (json['best_keep_limit'] != null) {
		data.bestKeepLimit = json['best_keep_limit'].toString();
	}
	if (json['min_keep_limit'] != null) {
		data.minKeepLimit = json['min_keep_limit'].toString();
	}
	return data;
}

Map<String, dynamic> poolcontributionEntityToJson(PoolcontributionEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['team_amount'] = entity.teamAmount;
	data['genera_power'] = entity.generaPower;
	data['genera_award'] = entity.generaAward;
	data['process_award'] = entity.processAward;
	data['miners_team'] = entity.minersTeam;
	data['best_keep_limit'] = entity.bestKeepLimit;
	data['min_keep_limit'] = entity.minKeepLimit;
	return data;
}