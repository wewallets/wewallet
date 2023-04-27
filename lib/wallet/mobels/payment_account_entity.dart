import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class PaymentAccountEntity with JsonConvert<PaymentAccountEntity> {
	String assets;
	@JSONField(name: "assets_gold")
	String assetsGold;
	@JSONField(name: "order_amount")
	String orderAmount;
}
