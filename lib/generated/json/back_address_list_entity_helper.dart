import 'package:mars/models/back_address_list_entity.dart';

backAddressListEntityFromJson(BackAddressListEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['ajm_address'] != null) {
		data.ajmAddress = json['ajm_address'].toString();
	}
	if (json['been_found'] != null) {
		data.beenFound = json['been_found'].toString();
	}
	return data;
}

Map<String, dynamic> backAddressListEntityToJson(BackAddressListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['ajm_address'] = entity.ajmAddress;
	data['been_found'] = entity.beenFound;
	return data;
}