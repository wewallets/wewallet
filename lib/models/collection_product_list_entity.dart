import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class CollectionProductListEntity with JsonConvert<CollectionProductListEntity> {
	@JSONField(name: "refer_currency")
	String referCurrency;
	@JSONField(name: "icon_url")
	String iconUrl;
}
