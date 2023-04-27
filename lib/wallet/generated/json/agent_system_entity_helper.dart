import 'package:mars/wallet/mobels/agent_system_entity.dart';

agentSystemEntityFromJson(AgentSystemEntity data, Map<String, dynamic> json) {
	if (json['agent_level'] != null) {
		data.agentLevel = json['agent_level'].toString();
	}
	if (json['total_grade'] != null) {
		data.totalGrade = json['total_grade'].toString();
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
		data.xList = (json['list'] as List).map((v) => AgentSystemList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> agentSystemEntityToJson(AgentSystemEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['agent_level'] = entity.agentLevel;
	data['total_grade'] = entity.totalGrade;
	data['short_amount'] = entity.shortAmount;
	data['level_percen'] = entity.levelPercen;
	data['total_child'] = entity.totalChild;
	data['list'] =  entity.xList?.map((v) => v.toJson())?.toList();
	return data;
}

agentSystemListFromJson(AgentSystemList data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid'].toString();
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
	if (json['agent_list'] != null) {
		data.agentList = (json['agent_list'] as List).map((v) => AgentSystemListAgentList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> agentSystemListToJson(AgentSystemList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['user_name'] = entity.userName;
	data['nick_name'] = entity.nickName;
	data['avatar'] = entity.avatar;
	data['agent_list'] =  entity.agentList?.map((v) => v.toJson())?.toList();
	return data;
}

agentSystemListAgentListFromJson(AgentSystemListAgentList data, Map<String, dynamic> json) {
	if (json['agent_level'] != null) {
		data.agentLevel = json['agent_level'].toString();
	}
	if (json['agent_count'] != null) {
		data.agentCount = json['agent_count'].toString();
	}
	return data;
}

Map<String, dynamic> agentSystemListAgentListToJson(AgentSystemListAgentList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['agent_level'] = entity.agentLevel;
	data['agent_count'] = entity.agentCount;
	return data;
}