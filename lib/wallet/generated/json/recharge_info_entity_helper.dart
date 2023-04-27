import 'package:mars/wallet/mobels/recharge_info_entity.dart';

rechargeInfoEntityFromJson(RechargeInfoEntity data, Map<String, dynamic> json) {
	if (json['recharge_amount'] != null) {
		data.rechargeAmount = json['recharge_amount'].toString();
	}
	if (json['add_time'] != null) {
		data.addTime = json['add_time'].toString();
	}
	if (json['add_date'] != null) {
		data.addDate = json['add_date'].toString();
	}
	if (json['recharge_number'] != null) {
		data.rechargeNumber = json['recharge_number'].toString();
	}
	if (json['bank_name'] != null) {
		data.bankName = json['bank_name'].toString();
	}
	if (json['bank_account'] != null) {
		data.bankAccount = json['bank_account'].toString();
	}
	if (json['bank_user'] != null) {
		data.bankUser = json['bank_user'].toString();
	}
	if (json['recharge_status'] != null) {
		data.rechargeStatus = json['recharge_status'].toString();
	}
	if (json['recharge_status_str'] != null) {
		data.rechargeStatusStr = json['recharge_status_str'].toString();
	}
	return data;
}

Map<String, dynamic> rechargeInfoEntityToJson(RechargeInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['recharge_amount'] = entity.rechargeAmount;
	data['add_time'] = entity.addTime;
	data['add_date'] = entity.addDate;
	data['recharge_number'] = entity.rechargeNumber;
	data['bank_name'] = entity.bankName;
	data['bank_account'] = entity.bankAccount;
	data['bank_user'] = entity.bankUser;
	data['recharge_status'] = entity.rechargeStatus;
	data['recharge_status_str'] = entity.rechargeStatusStr;
	return data;
}