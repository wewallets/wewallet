import 'package:mars/wallet/mobels/bankcard_list_entity.dart';

bankcardListEntityFromJson(BankcardListEntity data, Map<String, dynamic> json) {
	if (json['card_id'] != null) {
		data.cardId = json['card_id'].toString();
	}
	if (json['card_number'] != null) {
		data.cardNumber = json['card_number'].toString();
	}
	if (json['bank'] != null) {
		data.bank = json['bank'].toString();
	}
	if (json['payee'] != null) {
		data.payee = json['payee'].toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile'].toString();
	}
	if (json['countrycode'] != null) {
		data.countrycode = json['countrycode'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	return data;
}

Map<String, dynamic> bankcardListEntityToJson(BankcardListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['card_id'] = entity.cardId;
	data['card_number'] = entity.cardNumber;
	data['bank'] = entity.bank;
	data['payee'] = entity.payee;
	data['mobile'] = entity.mobile;
	data['countrycode'] = entity.countrycode;
	data['create_time'] = entity.createTime;
	return data;
}