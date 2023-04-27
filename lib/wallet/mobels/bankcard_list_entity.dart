import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class BankcardListEntity with JsonConvert<BankcardListEntity> {
	@JSONField(name: "card_id")
	String cardId;
	@JSONField(name: "card_number")
	String cardNumber;
	String bank;
	String payee;
	String mobile;
	String countrycode;
	@JSONField(name: "create_time")
	String createTime;
}
