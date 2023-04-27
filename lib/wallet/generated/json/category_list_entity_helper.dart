import 'package:mars/wallet/mobels/category_list_entity.dart';

categoryListEntityFromJson(CategoryListEntity data, Map<String, dynamic> json) {
	if (json['cat_id'] != null) {
		data.catId = json['cat_id'].toString();
	}
	if (json['cat_name'] != null) {
		data.catName = json['cat_name'].toString();
	}
	if (json['cat_icon'] != null) {
		data.catIcon = json['cat_icon'].toString();
	}
	return data;
}

Map<String, dynamic> categoryListEntityToJson(CategoryListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cat_id'] = entity.catId;
	data['cat_name'] = entity.catName;
	data['cat_icon'] = entity.catIcon;
	return data;
}