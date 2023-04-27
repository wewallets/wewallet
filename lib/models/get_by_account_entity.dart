import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class GetByAccountEntity with JsonConvert<GetByAccountEntity> {
	@JSONField(name: "product_url")
	String productUrl;
	@JSONField(name: "pay_amount")
	String payAmount;
	@JSONField(name: "pay_currency")
	String payCurrency;
	@JSONField(name: "keep_days")
	int keepDays;
	String type;
	@JSONField(name: "order_id")
	String orderId;
	@JSONField(name: "buy_back")
	String buyBack;

	List<GetByAccountIncome> income;
}

class GetByAccountIncome with JsonConvert<GetByAccountIncome> {
	String currency;
	String income;
}
