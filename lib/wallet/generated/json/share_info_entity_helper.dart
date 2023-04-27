import 'package:mars/wallet/mobels/share_info_entity.dart';

shareInfoEntityFromJson(ShareInfoEntity data, Map<String, dynamic> json) {
	if (json['user_grade'] != null) {
		data.userGrade = json['user_grade'].toString();
	}
	if (json['child_list'] != null) {
		data.childList = (json['child_list'] as List).map((v) => ShareInfoChildList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> shareInfoEntityToJson(ShareInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user_grade'] = entity.userGrade;
	data['child_list'] =  entity.childList?.map((v) => v.toJson())?.toList();
	return data;
}

shareInfoChildListFromJson(ShareInfoChildList data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['team_grade'] != null) {
		data.teamGrade = json['team_grade'].toString();
	}
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	return data;
}

Map<String, dynamic> shareInfoChildListToJson(ShareInfoChildList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['team_grade'] = entity.teamGrade;
	data['nick_name'] = entity.nickName;
	return data;
}