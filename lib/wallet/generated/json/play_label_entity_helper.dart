import 'package:mars/wallet/mobels/play_label_entity.dart';

playLabelEntityFromJson(PlayLabelEntity data, Map<String, dynamic> json) {
	if (json['label_id'] != null) {
		data.labelId = json['label_id'].toString();
	}
	if (json['label_name'] != null) {
		data.labelName = json['label_name'].toString();
	}
	if (json['is_delete'] != null) {
		data.isDelete = json['is_delete'].toString();
	}
	if (json['sort_order'] != null) {
		data.sortOrder = json['sort_order'].toString();
	}
	return data;
}

Map<String, dynamic> playLabelEntityToJson(PlayLabelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['label_id'] = entity.labelId;
	data['label_name'] = entity.labelName;
	data['is_delete'] = entity.isDelete;
	data['sort_order'] = entity.sortOrder;
	return data;
}