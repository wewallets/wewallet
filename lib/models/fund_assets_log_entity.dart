import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class FundAssetsLogEntity with JsonConvert<FundAssetsLogEntity> {
	String type;
	String amount;
	String currency;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "log_str")
	String logStr;
}
