import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolListEntity with JsonConvert<PoolListEntity> {
	@JSONField(name: "YISE")
	PoolListRISE rISE;
	@JSONField(name: "FIL")
	PoolListFIL fIL;
}

class PoolListRISE with JsonConvert<PoolListRISE> {
	@JSONField(name: "yesterday_award")
	String yesterdayAward;
	@JSONField(name: "yesterday_award_usdt")
	String yesterdayAwardUsdt;
	@JSONField(name: "all_award")
	String allAward;
	@JSONField(name: "all_award_usdt")
	String allAwardUsdt;
	@JSONField(name: "process_award")
	String processAward;
	@JSONField(name: "popul_award")
	String populAward;
	@JSONField(name: "rise_pool_best_limit")
	String risePoolBestLimit;
	@JSONField(name: "rise_pool_min_keep")
	String risePoolMinKeep;
}

class PoolListFIL with JsonConvert<PoolListFIL> {
	@JSONField(name: "assets_FIL")
	String assetsFil;
	@JSONField(name: "use_FIL")
	String useFil;
	@JSONField(name: "7days_award")
	String x7daysAward;
	@JSONField(name: "fil_pool_release_total")
	String filPoolReleaseTotal;
	@JSONField(name: "fil_pool_total")
	String filPoolTotal;
	@JSONField(name: "fil_pool_release_percen")
	String filPoolReleasePercen;
}
