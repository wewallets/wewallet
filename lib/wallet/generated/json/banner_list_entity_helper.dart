import 'package:mars/wallet/mobels/banner_list_entity.dart';

bannerListEntityFromJson(BannerListEntity data, Map<String, dynamic> json) {
	if (json['banner_id'] != null) {
		data.bannerId = json['banner_id'].toString();
	}
	if (json['img'] != null) {
		data.img = json['img'].toString();
	}
	if (json['sort_order'] != null) {
		data.sortOrder = json['sort_order'].toString();
	}
	if (json['is_show'] != null) {
		data.isShow = json['is_show'].toString();
	}
	if (json['goods_id'] != null) {
		data.goodsId = json['goods_id'].toString();
	}
	return data;
}

Map<String, dynamic> bannerListEntityToJson(BannerListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['banner_id'] = entity.bannerId;
	data['img'] = entity.img;
	data['sort_order'] = entity.sortOrder;
	data['is_show'] = entity.isShow;
	data['goods_id'] = entity.goodsId;
	return data;
}