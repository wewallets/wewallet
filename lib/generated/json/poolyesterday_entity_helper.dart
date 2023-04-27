import 'package:mars/models/poolyesterday_entity.dart';

poolyesterdayEntityFromJson(PoolyesterdayEntity data, Map<String, dynamic> json) {
	if (json['yesterday_award'] != null) {
		data.yesterdayAward = json['yesterday_award'].toString();
	}
	if (json['yesterday_award_cny'] != null) {
		data.yesterdayAwardCny = json['yesterday_award_cny'].toString();
	}
	return data;
}

Map<String, dynamic> poolyesterdayEntityToJson(PoolyesterdayEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['yesterday_award'] = entity.yesterdayAward;
	data['yesterday_award_cny'] = entity.yesterdayAwardCny;
	return data;
}