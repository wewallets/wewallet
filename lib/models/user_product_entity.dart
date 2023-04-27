import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class UserProductEntity with JsonConvert<UserProductEntity> {
	@JSONField(name: "pay_amount")
	String payAmount;
	@JSONField(name: "pay_time")
	String payTime;
	@JSONField(name: "product_id")
	String productId;
	@JSONField(name: "wheel_id")
	String wheelId;
	String total;
	String totaled;
	String currency;
	@JSONField(name: "start_time")
	String startTime;
	@JSONField(name: "end_time")
	String endTime;
	String number;
	@JSONField(name: "raise_status")
	String raiseStatus;
	String title;
	@JSONField(name: "title_en")
	String titleEn;
	@JSONField(name: "title_th")
	String titleTh;
	@JSONField(name: "title_ms")
	String titleMs;
	@JSONField(name: "platform_bonus_amount")
	String platformBonusAmount;
	String income;
	String icon;
	@JSONField(name: "raise_status_str")
	String raiseStatusStr;
	String zoon_number;

}
