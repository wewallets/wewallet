import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PooldetailEntity with JsonConvert<PooldetailEntity> {
	@JSONField(name: "log_list")
	List<PooldetailLogList> logList;
	@JSONField(name: "yesterday_award")
	String yesterdayAward;
	@JSONField(name: "total_award")
	String totalAward;
	@JSONField(name: "best_keep")
	String bestKeep;
	@JSONField(name: "min_keep")
	String minKeep;
}

class PooldetailLogList with JsonConvert<PooldetailLogList> {
	String date;
	String award;
}
