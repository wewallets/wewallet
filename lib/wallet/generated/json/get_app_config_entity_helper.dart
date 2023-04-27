import 'package:mars/wallet/mobels/get_app_config_entity.dart';

getAppConfigEntityFromJson(GetAppConfigEntity data, Map<String, dynamic> json) {
	if (json['config_id'] != null) {
		data.configId = json['config_id'].toString();
	}
	if (json['forced_update'] != null) {
		data.forcedUpdate = json['forced_update'].toString();
	}
	if (json['version_no'] != null) {
		data.versionNo = json['version_no'].toString();
	}
	if (json['tiltle'] != null) {
		data.tiltle = json['tiltle'].toString();
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	if (json['ios_addr'] != null) {
		data.iosAddr = json['ios_addr'].toString();
	}
	if (json['android_addr'] != null) {
		data.androidAddr = json['android_addr'].toString();
	}
	if (json['version'] != null) {
		data.version = json['version'].toString();
	}
	return data;
}

Map<String, dynamic> getAppConfigEntityToJson(GetAppConfigEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['config_id'] = entity.configId;
	data['forced_update'] = entity.forcedUpdate;
	data['version_no'] = entity.versionNo;
	data['tiltle'] = entity.tiltle;
	data['content'] = entity.content;
	data['ios_addr'] = entity.iosAddr;
	data['android_addr'] = entity.androidAddr;
	data['version'] = entity.version;
	return data;
}