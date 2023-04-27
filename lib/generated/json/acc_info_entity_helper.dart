import 'package:mars/models/acc_info_entity.dart';

accInfoEntityFromJson(AccInfoEntity data, Map<String, dynamic> json) {
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['ai_level'] != null) {
		data.aiLevel = json['ai_level'].toString();
	}
	if (json['user_earn'] != null) {
		data.userEarn = json['user_earn'].toString();
	}
	if (json['team_earn'] != null) {
		data.teamEarn = json['team_earn'].toString();
	}
	if (json['lj_earn'] != null) {
		data.ljEarn = json['lj_earn'].toString();
	}
	return data;
}

Map<String, dynamic> accInfoEntityToJson(AccInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['address'] = entity.address;
	data['ai_level'] = entity.aiLevel;
	data['user_earn'] = entity.userEarn;
	data['team_earn'] = entity.teamEarn;
	data['lj_earn'] = entity.ljEarn;
	return data;
}