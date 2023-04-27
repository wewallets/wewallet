import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class ProductByCurrencyEntity with JsonConvert<ProductByCurrencyEntity> {
	@JSONField(name: "pay_currency")
	String payCurrency;
	@JSONField(name: "pay_min")
	String payMin;
	@JSONField(name: "pay_max")
	String payMax;
	@JSONField(name: "year_award")
	String yearAward;
	@JSONField(name: "icon_currency_url")
	String iconCurrencyUrl;
}
