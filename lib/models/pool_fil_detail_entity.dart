import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolFilDetailEntity with JsonConvert<PoolFilDetailEntity> {
	@JSONField(name: "log_list")
	List<PoolFilDetailLogList> logList;
	@JSONField(name: "assets_FIL")
	String assetsFil;
	@JSONField(name: "use_FIL")
	String useFil;
	@JSONField(name: "7days_award")
	String x7daysAward;
	@JSONField(name: "fil_pool_tlevel")
	String filPoolTlevel;
	@JSONField(name: "fil_pool_real_tlevel")
	String filPoolRealTlevel;
	@JSONField(name: "fil_pool_release_total")
	String filPoolReleaseTotal;
	@JSONField(name: "fil_pool_total")
	String filPoolTotal;
	@JSONField(name: "fil_pool_tlevel_percen")
	String filPoolTlevelPercen;
	@JSONField(name: "fil_pool_release_percen")
	String filPoolReleasePercen;
}

class PoolFilDetailLogList with JsonConvert<PoolFilDetailLogList> {
	String date;
	String award;
}
