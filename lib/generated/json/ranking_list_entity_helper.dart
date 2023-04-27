import 'package:mars/models/ranking_list_entity.dart';

rankingListEntityFromJson(RankingListEntity data, Map<String, dynamic> json) {
	if (json['account'] != null) {
		data.account = json['account'].toString();
	}
	if (json['amount_sum'] != null) {
		data.amountSum = json['amount_sum'].toString();
	}
	return data;
}

Map<String, dynamic> rankingListEntityToJson(RankingListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['account'] = entity.account;
	data['amount_sum'] = entity.amountSum;
	return data;
}