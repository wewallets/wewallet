import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class AssetsListEntity with JsonConvert<AssetsListEntity> {
	String amount;
	String type;
	@JSONField(name: "modify_time")
	String modifyTime;
	@JSONField(name: "modify_date")
	String modifyDate;
	@JSONField(name: "assets_currency")
	String assetsCurrency;
	@JSONField(name: "type_str")
	String typeStr;
}
