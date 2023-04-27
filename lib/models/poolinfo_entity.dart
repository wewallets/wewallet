import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolinfoEntity with JsonConvert<PoolinfoEntity> {
	@JSONField(name: "total_award")
	String totalAward;
	@JSONField(name: "yesterday_award")
	String yesterdayAward;
	@JSONField(name: "total_destroy")
	String totalDestroy;
	@JSONField(name: "yesterday_destroy")
	String yesterdayDestroy;
	@JSONField(name: "ledger_index")
	String ledgerIndex;
}
