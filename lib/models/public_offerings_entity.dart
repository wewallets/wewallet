import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PublicOfferingsEntity with JsonConvert<PublicOfferingsEntity> {
	String currency;
	@JSONField(name: "project_image")
	String projectImage;
	@JSONField(name: "auth_time")
	String authTime;
	String title;
	@JSONField(name: "product_people_each")
	String productPeopleEach;
	dynamic intro;
	dynamic explain;
	@JSONField(name: "issue_time")
	String issueTime;
	@JSONField(name: "issue_total")
	String issueTotal;
	String whitepaper;
	String website;
	String address;
	@JSONField(name: "product_status")
	String productStatus;
	@JSONField(name: "product_pay_currency")
	String productPayCurrency;
	@JSONField(name: "order_pay_amount")
	String orderPayAmount;
	@JSONField(name: "product_currency")
	String productCurrency;
	@JSONField(name: "order_amount")
	String orderAmount;
	@JSONField(name: "product_exchange_price")
	String productExchangePrice;
	@JSONField(name: "is_buy")
	String isBuy;
}
