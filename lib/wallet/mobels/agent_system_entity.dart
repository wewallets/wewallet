import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class AgentSystemEntity with JsonConvert<AgentSystemEntity> {
	@JSONField(name: "agent_level")
	String agentLevel;
	@JSONField(name: "total_grade")
	String totalGrade;
	@JSONField(name: "short_amount")
	String shortAmount;
	@JSONField(name: "level_percen")
	String levelPercen;
	@JSONField(name: "total_child")
	String totalChild;
	@JSONField(name: "list")
	List<AgentSystemList> xList;
}

class AgentSystemList with JsonConvert<AgentSystemList> {
	String uid;
	@JSONField(name: "user_name")
	String userName;
	@JSONField(name: "nick_name")
	String nickName;
	String avatar;
	@JSONField(name: "agent_list")
	List<AgentSystemListAgentList> agentList;
}

class AgentSystemListAgentList with JsonConvert<AgentSystemListAgentList> {
	@JSONField(name: "agent_level")
	String agentLevel;
	@JSONField(name: "agent_count")
	String agentCount;
}
