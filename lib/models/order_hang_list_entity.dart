import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class OrderHangListEntity with JsonConvert<OrderHangListEntity> {
	@JSONField(name: "product_url")
	String productUrl;
	@JSONField(name: "pay_amount")
	int payAmount;
	@JSONField(name: "pay_currency")
	String payCurrency;
	@JSONField(name: "keep_days")
	int keepDays;
	@JSONField(name: "hang_amount")
	int hangAmount;
	@JSONField(name: "order_id")
	String orderId;
}
