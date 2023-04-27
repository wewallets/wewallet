import 'package:mars/wallet/mobels/assets_log_entity.dart';

assetsLogEntityFromJson(AssetsLogEntity data, Map<String, dynamic> json) {
	if (json['assets'] != null) {
		data.assets = json['assets'].toString();
	}
	if (json['list'] != null) {
		data.xList = (json['list'] as List).map((v) => AssetsLogList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> assetsLogEntityToJson(AssetsLogEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assets'] = entity.assets;
	data['list'] =  entity.xList?.map((v) => v.toJson())?.toList();
	return data;
}

assetsLogListFromJson(AssetsLogList data, Map<String, dynamic> json) {
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
	if (json['recharge_remark'] != null) {
		data.rechargeRemark = json['recharge_remark'].toString();
	}
	return data;
}

Map<String, dynamic> assetsLogListToJson(AssetsLogList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['amount'] = entity.amount;
	data['type'] = entity.type;
	data['modify_time'] = entity.modifyTime;
	data['modify_date'] = entity.modifyDate;
	data['assets_currency'] = entity.assetsCurrency;
	data['type_str'] = entity.typeStr;
	data['recharge_remark'] = entity.rechargeRemark;
	return data;
}