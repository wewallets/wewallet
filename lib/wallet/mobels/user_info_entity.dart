import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
	@JSONField(name: "user_name")
	String userName;
	@JSONField(name: "nick_name")
	String nickName;
	String coupon;
	String avatar;
	String assets;
	@JSONField(name: "assets_gold")
	String assetsGold;
	@JSONField(name: "mobile")
	String mobile;
	@JSONField(name: "total_member")
	String totalMember;
	@JSONField(name: "total_agent")
	String totalAgent;
	@JSONField(name: "is_spell_show")
	String isSpellShow;
}
