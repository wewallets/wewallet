import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class AccInfoEntity with JsonConvert<AccInfoEntity> {
	String address;
	@JSONField(name: "ai_level")
	String aiLevel;
	@JSONField(name: "user_earn")
	String userEarn;
	@JSONField(name: "team_earn")
	String teamEarn;
	@JSONField(name: "lj_earn")
	String ljEarn;
}
