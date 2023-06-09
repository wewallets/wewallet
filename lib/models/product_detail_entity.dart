import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class ProductDetailEntity with JsonConvert<ProductDetailEntity> {
	@JSONField(name: "zoon_id")
	String zoonId;
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
	String zoon_number;
	String status;
	String title;
	@JSONField(name: "title_en")
	String titleEn;
	@JSONField(name: "title_th")
	String titleTh;
	@JSONField(name: "title_ms")
	String titleMs;
	@JSONField(name: "platform_bonus_amount")
	String platformBonusAmount;
	@JSONField(name: "order_id")
	dynamic orderId;
	String icon;
	@JSONField(name: "is_buy")
	String isBuy;
	String str;
	@JSONField(name: "pay_min")
	String payMin;
	@JSONField(name: "pay_max")
	String payMax;
}
