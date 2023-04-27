import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolListsEntity with JsonConvert<PoolListsEntity> {
	@JSONField(name: "log_list")
	List<PoolListsLogList> logList;
	@JSONField(name: "total_award_yesterday")
	String totalAwardYesterday;
	@JSONField(name: "total_award_yesterday_usdt")
	String totalAwardYesterdayUsdt;
	@JSONField(name: "total_award")
	String totalAward;
	@JSONField(name: "rise_pool_best_limit")
	String risePoolBestLimit;
	@JSONField(name: "rise_pool_min_keep")
	String risePoolMinKeep;
	@JSONField(name: "process_award")
	String processAward;
	@JSONField(name: "keep_award")
	String keepAward;
}

class PoolListsLogList with JsonConvert<PoolListsLogList> {
	String date;
	String award;
	@JSONField(name: "rate_return")
	String rateReturn;
}
