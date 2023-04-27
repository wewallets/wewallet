import 'package:mars/wallet/mobels/wallet_entity.dart';

walletEntityFromJson(WalletEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['password'] != null) {
		data.password = json['password'].toString();
	}
	if (json['network'] != null) {
		data.network = json['network'].toString();
	}
	if (json['wallet'] != null) {
		data.wallet = WalletWallet().fromJson(json['wallet']);
	}
	return data;
}

Map<String, dynamic> walletEntityToJson(WalletEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['password'] = entity.password;
	data['network'] = entity.network;
	data['wallet'] = entity.wallet?.toJson();
	return data;
}

walletWalletFromJson(WalletWallet data, Map<String, dynamic> json) {
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['privateKey'] != null) {
		data.privateKey = json['privateKey'].toString();
	}
	if (json['propose'] != null) {
		data.propose = json['propose'].toString();
	}
	return data;
}

Map<String, dynamic> walletWalletToJson(WalletWallet entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['address'] = entity.address;
	data['privateKey'] = entity.privateKey;
	data['propose'] = entity.propose;
	return data;
}