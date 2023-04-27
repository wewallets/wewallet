import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PledgeGroupEntity with JsonConvert<PledgeGroupEntity> {
	@JSONField(name: "pay_currency")
	String payCurrency;
	String icon;
	@JSONField(name: "max_rate")
	String maxRate;
	@JSONField(name: "min_rate")
	String minRate;
	@JSONField(name: "max_day")
	String maxDay;
	@JSONField(name: "min_day")
	String minDay;
}
