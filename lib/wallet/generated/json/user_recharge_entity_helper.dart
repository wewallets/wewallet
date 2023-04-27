import 'package:mars/wallet/mobels/user_recharge_entity.dart';

userRechargeEntityFromJson(UserRechargeEntity data, Map<String, dynamic> json) {
	if (json['assets_recharge'] != null) {
		data.assetsRecharge = json['assets_recharge'].toString();
	}
	if (json['bank'] != null) {
		data.bank = json['bank'].toString();
	}
	if (json['card_number'] != null) {
		data.cardNumber = json['card_number'].toString();
	}
	if (json['cardholder_name'] != null) {
		data.cardholderName = json['cardholder_name'].toString();
	}
	return data;
}

Map<String, dynamic> userRechargeEntityToJson(UserRechargeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assets_recharge'] = entity.assetsRecharge;
	data['bank'] = entity.bank;
	data['card_number'] = entity.cardNumber;
	data['cardholder_name'] = entity.cardholderName;
	return data;
}