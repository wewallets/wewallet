import 'package:mars/models/poolunder_entity.dart';

poolunderEntityFromJson(PoolunderEntity data, Map<String, dynamic> json) {
	if (json['assets_TH'] != null) {
		data.assets_TH = json['assets_TH'].toString();
	}
	if (json['assets_RISE'] != null) {
		data.assets_THC = json['assets_RISE'].toString();
	}
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['total_assets_EAE'] != null) {
		data.total_assets_EAE = json['total_assets_EAE'].toString();
	}
	if (json['total_assets_TH'] != null) {
		data.total_assets_TH = json['total_assets_TH'].toString();
	}
	if (json['total_assets_THC'] != null) {
		data.total_assets_THC = json['total_assets_THC'].toString();
	}
	return data;
}

Map<String, dynamic> poolunderEntityToJson(PoolunderEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assets_TH'] = entity.assets_TH;
	data['assets_RISE'] = entity.assets_THC;
	data['nick_name'] = entity.nickName;
	data['address'] = entity.address;
	data['total_assets_EAE'] = entity.total_assets_EAE;
	data['total_assets_TH'] = entity.total_assets_TH;
	data['total_assets_THC'] = entity.total_assets_THC;
	return data;
}