import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class FundDetailEntity with JsonConvert<FundDetailEntity> {
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
	@JSONField(name: "pay_min")
	String payMin;
	@JSONField(name: "pay_max")
	String payMax;
	@JSONField(name: "raise_status")
	String raiseStatus;
	String icon;
}
