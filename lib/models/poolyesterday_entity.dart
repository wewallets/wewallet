import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolyesterdayEntity with JsonConvert<PoolyesterdayEntity> {
	@JSONField(name: "yesterday_award")
	String yesterdayAward;
	@JSONField(name: "yesterday_award_cny")
	String yesterdayAwardCny;
}
