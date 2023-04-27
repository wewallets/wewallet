import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class SwapProductListEntity with JsonConvert<SwapProductListEntity> {
	@JSONField(name: "product_list")
	List<SwapProductListProductList> productList;
	@JSONField(name: "up_currency_arr")
	List<String> upCurrencyArr;
	@JSONField(name: "down_currency_arr")
	List<String> downCurrencyArr;
	@JSONField(name: "symbol_arr")
	List<SwapProductListSymbolArr> symbolArr;
}

class SwapProductListProductList with JsonConvert<SwapProductListProductList> {
	@JSONField(name: "product_id")
	String productId;
	String symbol;
	String title;
	String icon;
	String currency;
	@JSONField(name: "total_pool")
	String totalPool;
	@JSONField(name: "to_currency")
	String toCurrency;
	@JSONField(name: "to_total_pool")
	String toTotalPool;
	@JSONField(name: "to_exchange_max")
	String toExchangeMax;
	@JSONField(name: "yester_price")
	String yesterPrice;
	@JSONField(name: "curr_price")
	String currPrice;
	@JSONField(name: "to_curr_price")
	String toCurrPrice;
	@JSONField(name: "curr_date")
	String currDate;
	@JSONField(name: "trade_amount")
	String tradeAmount;
	@JSONField(name: "rice_fall")
	String riceFall;
	@JSONField(name: "is_on_sale")
	String isOnSale;
	@JSONField(name: "create_time")
	String createTime;
}

class SwapProductListSymbolArr with JsonConvert<SwapProductListSymbolArr> {
	String symbol;
	String price;
}
