import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolDetailsEntity with JsonConvert<PoolDetailsEntity> {
	@JSONField(name: "log_list")
	List<PoolDetailsLogList> logList;
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
	@JSONField(name: "popul_award")
	String populAward;

}

class PoolDetailsLogList with JsonConvert<PoolDetailsLogList> {
	String date;
	String award;
	@JSONField(name: "rate_return")
	String rateReturn;
}
