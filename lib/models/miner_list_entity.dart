import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class MinerListEntity with JsonConvert<MinerListEntity> {
	String address;
	@JSONField(name: "child_number")
	String childNumber;
	@JSONField(name: "investment_current")
	String investmentCurrent;
	@JSONField(name: "revenue_current")
	String revenueCurrent;
	@JSONField(name: "balance_total")
	String balanceTotal;
}
