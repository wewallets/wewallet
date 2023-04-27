import 'package:mars/wallet/mobels/store_list_entity.dart';

storeListEntityFromJson(StoreListEntity data, Map<String, dynamic> json) {
	if (json['store_id'] != null) {
		data.storeId = json['store_id'].toString();
	}
	if (json['store_name_en'] != null) {
		data.storeNameEn = json['store_name_en'].toString();
	}
	if (json['store_address_en'] != null) {
		data.storeAddressEn = json['store_address_en'].toString();
	}
	if (json['store_mobile_en'] != null) {
		data.storeMobileEn = json['store_mobile_en'].toString();
	}
	if (json['store_name_vi'] != null) {
		data.storeNameVi = json['store_name_vi'].toString();
	}
	if (json['store_address_vi'] != null) {
		data.storeAddressVi = json['store_address_vi'].toString();
	}
	if (json['store_mobile_vi'] != null) {
		data.storeMobileVi = json['store_mobile_vi'].toString();
	}
	if (json['store_status'] != null) {
		data.storeStatus = json['store_status'].toString();
	}
	if (json['store_address'] != null) {
		data.storeAddress = json['store_address'].toString();
	}
	if (json['store_name'] != null) {
		data.storeName = json['store_name'].toString();
	}
	if (json['store_mobile'] != null) {
		data.storeMobile = json['store_mobile'].toString();
	}
	return data;
}

Map<String, dynamic> storeListEntityToJson(StoreListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['store_id'] = entity.storeId;
	data['store_name_en'] = entity.storeNameEn;
	data['store_address_en'] = entity.storeAddressEn;
	data['store_mobile_en'] = entity.storeMobileEn;
	data['store_name_vi'] = entity.storeNameVi;
	data['store_address_vi'] = entity.storeAddressVi;
	data['store_mobile_vi'] = entity.storeMobileVi;
	data['store_status'] = entity.storeStatus;
	data['store_address'] = entity.storeAddress;
	data['store_name'] = entity.storeName;
	data['store_mobile'] = entity.storeMobile;
	return data;
}