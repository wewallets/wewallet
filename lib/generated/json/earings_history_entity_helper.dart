import 'package:mars/models/earings_history_entity.dart';

earingsHistoryEntityFromJson(EaringsHistoryEntity data, Map<String, dynamic> json) {
	if (json['Account'] != null) {
		data.account = json['Account'].toString();
	}
	if (json['StaticAmount'] != null) {
		data.staticAmount = json['StaticAmount'].toString();
	}
	if (json['TeamAmount'] != null) {
		data.teamAmount = json['TeamAmount'].toString();
	}
	if (json['CreateTime'] != null) {
		data.createTime = json['CreateTime'].toString();
	}
	if (json['State'] != null) {
		data.state = json['State'].toString();
	}
	return data;
}

Map<String, dynamic> earingsHistoryEntityToJson(EaringsHistoryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Account'] = entity.account;
	data['StaticAmount'] = entity.staticAmount;
	data['TeamAmount'] = entity.teamAmount;
	data['CreateTime'] = entity.createTime;
	data['State'] = entity.state;
	return data;
}