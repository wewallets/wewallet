import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class FundListEntity with JsonConvert<FundListEntity> {
	@JSONField(name: "product_id")
	String productId;
	@JSONField(name: "wheel_id")
	String wheelId;
	String total;
	String totaled;
	String number;
	String zoon_number;
	@JSONField(name: "raise_status")
	String raiseStatus;
	String status;
	@JSONField(name: "start_time")
	String startTime;
	@JSONField(name: "end_time")
	String endTime;
	String currency;
	String title;
	@JSONField(name: "title_en")
	String titleEn;
	@JSONField(name: "title_th")
	String titleTh;
	@JSONField(name: "title_ms")
	String titleMs;
	@JSONField(name: "platform_bonus_amount")
	String platformBonusAmount;
	String icon;
	String str;
	@JSONField(name: "str_time")
	String strTime;
	@JSONField(name: "is_buy")
	String isBuy;

}
