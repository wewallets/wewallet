import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class AssetsEntity with JsonConvert<AssetsEntity> {
	AssetsTotal total;
	@JSONField(name: "currency_list")
	List<AssetsCurrencyList> currencyList;
}

class AssetsTotal with JsonConvert<AssetsTotal> {
	@JSONField(name: "total_cny")
	String totalCny;
	@JSONField(name: "total_usd")
	String totalUsd;
}

class AssetsCurrencyList with JsonConvert<AssetsCurrencyList> {
	@JSONField(name: "currency_name")
	String currencyName;
	String value;
	String icon;
	@JSONField(name: "cny_value")
	String cnyValue;
	@JSONField(name: "usd_value")
	String usdValue;
}
