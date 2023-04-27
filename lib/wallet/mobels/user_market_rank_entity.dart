import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class UserMarketRankEntity with JsonConvert<UserMarketRankEntity> {
	@JSONField(name: "rank_year")
	List<UserMarketRankRankYear> rankYear;
	@JSONField(name: "rank_mouth")
	List<UserMarketRankRankMouth> rankMouth;
	@JSONField(name: "my_rank")
	String myRank;
	@JSONField(name: "my_rank_amount")
	String myRankAmount;
}

class UserMarketRankRankYear with JsonConvert<UserMarketRankRankYear> {
	@JSONField(name: "user_name")
	String userName;
	String code;
	String rank;
	String avatar;
	@JSONField(name: "rank_amount")
	String rankAmount;
}

class UserMarketRankRankMouth with JsonConvert<UserMarketRankRankMouth> {
	@JSONField(name: "user_name")
	String userName;
	String code;
	String rank;
	String avatar;
	@JSONField(name: "rank_amount")
	String rankAmount;
}
