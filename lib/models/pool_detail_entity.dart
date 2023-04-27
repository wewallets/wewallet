import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolDetailEntity with JsonConvert<PoolDetailEntity> {
	String id;
	@JSONField(name: "product_period")
	String productPeriod;
	@JSONField(name: "product_name")
	String productName;
	@JSONField(name: "product_pay_currency")
	String productPayCurrency;
	@JSONField(name: "product_pay_max_amount")
	String productPayMaxAmount;
	@JSONField(name: "product_pay_min_amount")
	String productPayMinAmount;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "is_buy")
	String isBuy;
	@JSONField(name: "product_total_amount")
	String productTotalAmount;
	@JSONField(name: "product_pool_amount")
	String productPoolAmount;
	@JSONField(name: "people_count")
	String peopleCount;
	@JSONField(name: "my_group")
	String myGroup;
	@JSONField(name: "my_pool")
	String myPool;
	@JSONField(name: "activate_status")
	String activateStatus;

}
