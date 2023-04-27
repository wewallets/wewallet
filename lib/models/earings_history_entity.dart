import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class EaringsHistoryEntity with JsonConvert<EaringsHistoryEntity> {
	@JSONField(name: "Account")
	String account;
	@JSONField(name: "StaticAmount")
	String staticAmount;
	@JSONField(name: "TeamAmount")
	String teamAmount;
	@JSONField(name: "CreateTime")
	String createTime;
	@JSONField(name: "State")
	String state;
}
