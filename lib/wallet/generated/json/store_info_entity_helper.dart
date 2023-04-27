import 'package:mars/wallet/mobels/store_info_entity.dart';

storeInfoEntityFromJson(StoreInfoEntity data, Map<String, dynamic> json) {
	if (json['store_id'] != null) {
		data.storeId = json['store_id'].toString();
	}
	if (json['store_name'] != null) {
		data.storeName = json['store_name'].toString();
	}
	if (json['store_address'] != null) {
		data.storeAddress = json['store_address'].toString();
	}
	if (json['store_mobile'] != null) {
		data.storeMobile = json['store_mobile'].toString();
	}
	if (json['store_status'] != null) {
		data.storeStatus = json['store_status'].toString();
	}
	return data;
}

Map<String, dynamic> storeInfoEntityToJson(StoreInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['store_id'] = entity.storeId;
	data['store_name'] = entity.storeName;
	data['store_address'] = entity.storeAddress;
	data['store_mobile'] = entity.storeMobile;
	data['store_status'] = entity.storeStatus;
	return data;
}