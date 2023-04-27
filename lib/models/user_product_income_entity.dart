import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class UserProductIncomeEntity with JsonConvert<UserProductIncomeEntity> {
	String type;
	String currency;
	String amount;
	@JSONField(name: "consum_amount")
	String consumAmount;
	@JSONField(name: "create_time")
	String createTime;
	String number;
	String icon;
	@JSONField(name: "type_str")
	String typeStr;
	@JSONField(name: "log_str")
	String logStr;
}
