import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class CollectionBalanceEntity with JsonConvert<CollectionBalanceEntity> {
	CollectionBalanceTotal total;
	@JSONField(name: "currency_list")
	List<CollectionBalanceCurrencyList> currencyList;
}

class CollectionBalanceTotal with JsonConvert<CollectionBalanceTotal> {
	@JSONField(name: "total_cny")
	String totalCny;
	@JSONField(name: "total_usd")
	String totalUsd;
}

class CollectionBalanceCurrencyList with JsonConvert<CollectionBalanceCurrencyList> {
	@JSONField(name: "net_currency_name")
	String netCurrencyName;
	String value;
	@JSONField(name: "cny_value")
	String cnyValue;
	@JSONField(name: "usd_value")
	String usdValue;
	String icon;
	@JSONField(name: "is_open_transfer")
	String isOpenTransfer;
	String freeze;
}
