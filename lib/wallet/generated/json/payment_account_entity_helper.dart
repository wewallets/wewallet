import 'package:mars/wallet/mobels/payment_account_entity.dart';

paymentAccountEntityFromJson(PaymentAccountEntity data, Map<String, dynamic> json) {
	if (json['assets'] != null) {
		data.assets = json['assets'].toString();
	}
	if (json['assets_gold'] != null) {
		data.assetsGold = json['assets_gold'].toString();
	}
	if (json['order_amount'] != null) {
		data.orderAmount = json['order_amount'].toString();
	}
	return data;
}

Map<String, dynamic> paymentAccountEntityToJson(PaymentAccountEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assets'] = entity.assets;
	data['assets_gold'] = entity.assetsGold;
	data['order_amount'] = entity.orderAmount;
	return data;
}