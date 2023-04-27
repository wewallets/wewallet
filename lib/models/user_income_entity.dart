import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class UserIncomeEntity with JsonConvert<UserIncomeEntity> {
	@JSONField(name: "income_dynamic")
	String incomeDynamic;
	@JSONField(name: "income_static")
	String incomeStatic;
	@JSONField(name: "income_dividend")
	String incomeDividend;
	@JSONField(name: "assets_RISE")
	String assetsRise;
	@JSONField(name: "assets_ai_RISE")
	String assetsAiRise;
	@JSONField(name: "consum_RISE")
	String consumRise;
	String freeze;

}
