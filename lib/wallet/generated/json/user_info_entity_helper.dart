import 'package:mars/wallet/mobels/user_info_entity.dart';

userInfoEntityFromJson(UserInfoEntity data, Map<String, dynamic> json) {
	if (json['user_name'] != null) {
		data.userName = json['user_name'].toString();
	}
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	if (json['coupon'] != null) {
		data.coupon = json['coupon'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['assets'] != null) {
		data.assets = json['assets'].toString();
	}
	if (json['assets_gold'] != null) {
		data.assetsGold = json['assets_gold'].toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile'].toString();
	}
	if (json['total_member'] != null) {
		data.totalMember = json['total_member'].toString();
	}
	if (json['total_agent'] != null) {
		data.totalAgent = json['total_agent'].toString();
	}
	if (json['is_spell_show'] != null) {
		data.isSpellShow = json['is_spell_show'].toString();
	}
	return data;
}

Map<String, dynamic> userInfoEntityToJson(UserInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user_name'] = entity.userName;
	data['nick_name'] = entity.nickName;
	data['coupon'] = entity.coupon;
	data['avatar'] = entity.avatar;
	data['assets'] = entity.assets;
	data['assets_gold'] = entity.assetsGold;
	data['mobile'] = entity.mobile;
	data['total_member'] = entity.totalMember;
	data['total_agent'] = entity.totalAgent;
	data['is_spell_show'] = entity.isSpellShow;
	return data;
}