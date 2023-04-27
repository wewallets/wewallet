import 'package:mars/wallet/mobels/user_recharge_bank_entity.dart';

userRechargeBankEntityFromJson(UserRechargeBankEntity data, Map<String, dynamic> json) {
	if (json['bank_name'] != null) {
		data.bankName = json['bank_name'].toString();
	}
	if (json['bank_account'] != null) {
		data.bankAccount = json['bank_account'].toString();
	}
	if (json['bank_user'] != null) {
		data.bankUser = json['bank_user'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	return data;
}

Map<String, dynamic> userRechargeBankEntityToJson(UserRechargeBankEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bank_name'] = entity.bankName;
	data['bank_account'] = entity.bankAccount;
	data['bank_user'] = entity.bankUser;
	data['remark'] = entity.remark;
	return data;
}