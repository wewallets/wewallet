import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class MemberSystemEntity with JsonConvert<MemberSystemEntity> {
	String level;
	@JSONField(name: "total_grade")
	String totalGrade;
	@JSONField(name: "level_reward_total")
	String levelRewardTotal;
	@JSONField(name: "short_amount")
	String shortAmount;
	@JSONField(name: "level_percen")
	String levelPercen;
	@JSONField(name: "total_child")
	String totalChild;
	@JSONField(name: "list")
	List<MemberSystemList> xList;
}

class MemberSystemList with JsonConvert<MemberSystemList> {
	String type;
	String rank;
	String amount;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "user_name")
	String userName;
	@JSONField(name: "nick_name")
	String nickName;
	String avatar;
}
