import 'package:mars/wallet/mobels/member_system_entity.dart';

memberSystemEntityFromJson(MemberSystemEntity data, Map<String, dynamic> json) {
	if (json['level'] != null) {
		data.level = json['level'].toString();
	}
	if (json['total_grade'] != null) {
		data.totalGrade = json['total_grade'].toString();
	}
	if (json['level_reward_total'] != null) {
		data.levelRewardTotal = json['level_reward_total'].toString();
	}
	if (json['short_amount'] != null) {
		data.shortAmount = json['short_amount'].toString();
	}
	if (json['level_percen'] != null) {
		data.levelPercen = json['level_percen'].toString();
	}
	if (json['total_child'] != null) {
		data.totalChild = json['total_child'].toString();
	}
	if (json['list'] != null) {
		data.xList = (json['list'] as List).map((v) => MemberSystemList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> memberSystemEntityToJson(MemberSystemEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['level'] = entity.level;
	data['total_grade'] = entity.totalGrade;
	data['level_reward_total'] = entity.levelRewardTotal;
	data['short_amount'] = entity.shortAmount;
	data['level_percen'] = entity.levelPercen;
	data['total_child'] = entity.totalChild;
	data['list'] =  entity.xList?.map((v) => v.toJson())?.toList();
	return data;
}

memberSystemListFromJson(MemberSystemList data, Map<String, dynamic> json) {
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['rank'] != null) {
		data.rank = json['rank'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['user_name'] != null) {
		data.userName = json['user_name'].toString();
	}
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	return data;
}

Map<String, dynamic> memberSystemListToJson(MemberSystemList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['type'] = entity.type;
	data['rank'] = entity.rank;
	data['amount'] = entity.amount;
	data['create_time'] = entity.createTime;
	data['user_name'] = entity.userName;
	data['nick_name'] = entity.nickName;
	data['avatar'] = entity.avatar;
	return data;
}