import 'package:mars/wallet/mobels/goods_gear_entity.dart';

goodsGearEntityFromJson(GoodsGearEntity data, Map<String, dynamic> json) {
	if (json['gear_id'] != null) {
		data.gearId = json['gear_id'].toString();
	}
	if (json['gear_amount'] != null) {
		data.gearAmount = json['gear_amount'].toString();
	}
	return data;
}

Map<String, dynamic> goodsGearEntityToJson(GoodsGearEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['gear_id'] = entity.gearId;
	data['gear_amount'] = entity.gearAmount;
	return data;
}