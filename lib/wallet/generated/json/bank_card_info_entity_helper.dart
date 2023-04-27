import 'package:mars/wallet/mobels/bank_card_info_entity.dart';

bankCardInfoEntityFromJson(BankCardInfoEntity data, Map<String, dynamic> json) {
	if (json['bank_id'] != null) {
		data.bankId = json['bank_id'].toString();
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
	if (json['add_time'] != null) {
		data.addTime = json['add_time'].toString();
	}
	if (json['add_date'] != null) {
		data.addDate = json['add_date'].toString();
	}
	if (json['is_delete'] != null) {
		data.isDelete = json['is_delete'].toString();
	}
	if (json['sort_order'] != null) {
		data.sortOrder = json['sort_order'].toString();
	}
	return data;
}

Map<String, dynamic> bankCardInfoEntityToJson(BankCardInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bank_id'] = entity.bankId;
	data['bank_name'] = entity.bankName;
	data['bank_account'] = entity.bankAccount;
	data['bank_user'] = entity.bankUser;
	data['add_time'] = entity.addTime;
	data['add_date'] = entity.addDate;
	data['is_delete'] = entity.isDelete;
	data['sort_order'] = entity.sortOrder;
	return data;
}