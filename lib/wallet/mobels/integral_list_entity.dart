import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class IntegralListEntity with JsonConvert<IntegralListEntity> {
	@JSONField(name: "order_amount")
	String orderAmount;
	@JSONField(name: "create_time")
	String createTime;
}
