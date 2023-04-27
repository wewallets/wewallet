import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class SwapMinerListEntity with JsonConvert<SwapMinerListEntity> {
	String id;
	String account;
	@JSONField(name: "assets_RISE")
	String assetsRise;
	@JSONField(name: "user_pledge_USDT")
	String userPledgeUsdt;
	@JSONField(name: "team_pledge_USDT")
	String teamPledgeUsdt;
	@JSONField(name: "nick_name")
	String nickName;
}
