import 'package:mars/wallet/mobels/assets_entity.dart';

assetsEntityFromJson(AssetsEntity data, Map<String, dynamic> json) {
	if (json['total'] != null) {
		data.total = AssetsTotal().fromJson(json['total']);
	}
	if (json['currency_list'] != null) {
		data.currencyList = (json['currency_list'] as List).map((v) => AssetsCurrencyList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> assetsEntityToJson(AssetsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total'] = entity.total?.toJson();
	data['currency_list'] =  entity.currencyList?.map((v) => v.toJson())?.toList();
	return data;
}

assetsTotalFromJson(AssetsTotal data, Map<String, dynamic> json) {
	if (json['total_cny'] != null) {
		data.totalCny = json['total_cny'].toString();
	}
	if (json['total_usd'] != null) {
		data.totalUsd = json['total_usd'].toString();
	}
	return data;
}

Map<String, dynamic> assetsTotalToJson(AssetsTotal entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total_cny'] = entity.totalCny;
	data['total_usd'] = entity.totalUsd;
	return data;
}

assetsCurrencyListFromJson(AssetsCurrencyList data, Map<String, dynamic> json) {
	if (json['currency_name'] != null) {
		data.currencyName = json['currency_name'].toString();
	}
	if (json['value'] != null) {
		data.value = json['value'].toString();
	}
	if (json['icon'] != null) {
		data.icon = json['icon'].toString();
	}
	if (json['cny_value'] != null) {
		data.cnyValue = json['cny_value'].toString();
	}
	if (json['usd_value'] != null) {
		data.usdValue = json['usd_value'].toString();
	}
	return data;
}

Map<String, dynamic> assetsCurrencyListToJson(AssetsCurrencyList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['currency_name'] = entity.currencyName;
	data['value'] = entity.value;
	data['icon'] = entity.icon;
	data['cny_value'] = entity.cnyValue;
	data['usd_value'] = entity.usdValue;
	return data;
}