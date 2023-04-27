import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class AssetsLogEntity with JsonConvert<AssetsLogEntity> {
	String address;
	String fee;
	@JSONField(name: "asset_type")
	String assetType;
	String type;
	String amount;
	String currency;
	String before;
	String after;
	@JSONField(name: "create_date")
	String createDate;
	String zoon_number;
	dynamic number;
	dynamic title;
	@JSONField(name: "title_en")
	dynamic titleEn;
	@JSONField(name: "title_th")
	dynamic titleTh;
	@JSONField(name: "title_ms")
	dynamic titleMs;
	String icon;
	@JSONField(name: "log_str")
	String logStr;
}
