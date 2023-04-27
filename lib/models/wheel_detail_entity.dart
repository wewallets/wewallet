import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class WheelDetailEntity with JsonConvert<WheelDetailEntity> {
	@JSONField(name: "product_list")
	List<WheelDetailProductList> productList;
}

class WheelDetailProductList with JsonConvert<WheelDetailProductList> {
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
	@JSONField(name: "is_buy")
	String isBuy;
}
