import 'package:mars/wallet/mobels/order_pay_entity.dart';

orderPayEntityFromJson(OrderPayEntity data, Map<String, dynamic> json) {
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

Map<String, dynamic> orderPayEntityToJson(OrderPayEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bank'] = entity.bank;
	data['card_number'] = entity.cardNumber;
	data['cardholder_name'] = entity.cardholderName;
	return data;
}