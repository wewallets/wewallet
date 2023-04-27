import 'package:mars/models/ranking_minmax_entity.dart';

rankingMinmaxEntityFromJson(RankingMinmaxEntity data, Map<String, dynamic> json) {
	if (json['max'] != null) {
		data.max = RankingMinmaxMax().fromJson(json['max']);
	}
	if (json['min'] != null) {
		data.min = RankingMinmaxMin().fromJson(json['min']);
	}
	return data;
}

Map<String, dynamic> rankingMinmaxEntityToJson(RankingMinmaxEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['max'] = entity.max?.toJson();
	data['min'] = entity.min?.toJson();
	return data;
}

rankingMinmaxMaxFromJson(RankingMinmaxMax data, Map<String, dynamic> json) {
	if (json['Account'] != null) {
		data.account = json['Account'].toString();
	}
	if (json['max_amount'] != null) {
		data.maxAmount = json['max_amount'].toString();
	}
	if (json['order_amount'] != null) {
		data.orderAmount = json['order_amount'].toString();
	}
	if (json['profit_amount'] != null) {
		data.profitAmount = json['profit_amount'].toString();
	}
	return data;
}

Map<String, dynamic> rankingMinmaxMaxToJson(RankingMinmaxMax entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Account'] = entity.account;
	data['max_amount'] = entity.maxAmount;
	data['order_amount'] = entity.orderAmount;
	data['profit_amount'] = entity.profitAmount;
	return data;
}

rankingMinmaxMinFromJson(RankingMinmaxMin data, Map<String, dynamic> json) {
	if (json['Account'] != null) {
		data.account = json['Account'].toString();
	}
	if (json['min_amount'] != null) {
		data.minAmount = json['min_amount'].toString();
	}
	if (json['order_amount'] != null) {
		data.orderAmount = json['order_amount'].toString();
	}
	if (json['profit_amount'] != null) {
		data.profitAmount = json['profit_amount'].toString();
	}
	return data;
}

Map<String, dynamic> rankingMinmaxMinToJson(RankingMinmaxMin entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Account'] = entity.account;
	data['min_amount'] = entity.minAmount;
	data['order_amount'] = entity.orderAmount;
	data['profit_amount'] = entity.profitAmount;
	return data;
}