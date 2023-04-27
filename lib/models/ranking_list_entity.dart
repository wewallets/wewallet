import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class RankingListEntity with JsonConvert<RankingListEntity> {
	String account;
	@JSONField(name: "amount_sum")
	String amountSum;
}
