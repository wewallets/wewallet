import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class ShareInfoEntity with JsonConvert<ShareInfoEntity> {
	@JSONField(name: "user_grade")
	String userGrade;
	@JSONField(name: "child_list")
	List<ShareInfoChildList> childList;
}

class ShareInfoChildList with JsonConvert<ShareInfoChildList> {
	String name;
	@JSONField(name: "team_grade")
	String teamGrade;
	@JSONField(name: "nick_name")
	String nickName;
}
