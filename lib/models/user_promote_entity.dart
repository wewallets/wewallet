import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class UserPromoteEntity with JsonConvert<UserPromoteEntity> {
	@JSONField(name: "childs_number")
	String childsNumber;
	@JSONField(name: "level_RISE")
	String levelRise;
	@JSONField(name: "team_RISE")
	String teamRise;
	@JSONField(name: "childs_list")
	List<UserPromoteChildsList> childsList;
	@JSONField(name: "nick_name")
	String nickName;
	String head;
}

class UserPromoteChildsList with JsonConvert<UserPromoteChildsList> {
	String account;
	@JSONField(name: "raised_RISE")
	String raisedRise;
	@JSONField(name: "team_RISE")
	String teamRise;
}
