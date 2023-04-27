import 'package:mars/wallet/mobels/assets_list_entity.dart';

assetsListEntityFromJson(AssetsListEntity data, Map<String, dynamic> json) {
	if (json['amount'] != null) {
		data.amount = json['amount'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['modify_time'] != null) {
		data.modifyTime = json['modify_time'].toString();
	}
	if (json['modify_date'] != null) {
		data.modifyDate = json['modify_date'].toString();
	}
	if (json['assets_currency'] != null) {
		data.assetsCurrency = json['assets_currency'].toString();
	}
	if (json['type_str'] != null) {
		data.typeStr = json['type_str'].toString();
	}
	return data;
}

Map<String, dynamic> assetsListEntityToJson(AssetsListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['amount'] = entity.amount;
	data['type'] = entity.type;
	data['modify_time'] = entity.modifyTime;
	data['modify_date'] = entity.modifyDate;
	data['assets_currency'] = entity.assetsCurrency;
	data['type_str'] = entity.typeStr;
	return data;
}