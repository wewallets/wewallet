import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class MyPoolEntity with JsonConvert<MyPoolEntity> {
	@JSONField(name: "investment_total")
	String investmentTotal;
	@JSONField(name: "revenue_total")
	String revenueTotal;
	@JSONField(name: "investment_current")
	String investmentCurrent;
	@JSONField(name: "investment_remind")
	String investmentRemind;
}
