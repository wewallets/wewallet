import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class OrderPayEntity with JsonConvert<OrderPayEntity> {
	String bank;
	@JSONField(name: "card_number")
	String cardNumber;
	@JSONField(name: "cardholder_name")
	String cardholderName;
}
