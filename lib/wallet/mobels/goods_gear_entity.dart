import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class GoodsGearEntity with JsonConvert<GoodsGearEntity> {
	@JSONField(name: "gear_id")
	String gearId;
	@JSONField(name: "gear_amount")
	String gearAmount;
}
