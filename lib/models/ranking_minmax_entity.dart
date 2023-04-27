import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class RankingMinmaxEntity with JsonConvert<RankingMinmaxEntity> {
	RankingMinmaxMax max;
	RankingMinmaxMin min;
}

class RankingMinmaxMax with JsonConvert<RankingMinmaxMax> {
	@JSONField(name: "Account")
	String account;
	@JSONField(name: "max_amount")
	String maxAmount;
	@JSONField(name: "order_amount")
	String orderAmount;
	@JSONField(name: "profit_amount")
	String profitAmount;
}

class RankingMinmaxMin with JsonConvert<RankingMinmaxMin> {
	@JSONField(name: "Account")
	String account;
	@JSONField(name: "min_amount")
	String minAmount;
	@JSONField(name: "order_amount")
	String orderAmount;
	@JSONField(name: "profit_amount")
	String profitAmount;

}
