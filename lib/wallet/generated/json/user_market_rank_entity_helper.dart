import 'package:mars/wallet/mobels/user_market_rank_entity.dart';

userMarketRankEntityFromJson(UserMarketRankEntity data, Map<String, dynamic> json) {
	if (json['rank_year'] != null) {
		data.rankYear = (json['rank_year'] as List).map((v) => UserMarketRankRankYear().fromJson(v)).toList();
	}
	if (json['rank_mouth'] != null) {
		data.rankMouth = (json['rank_mouth'] as List).map((v) => UserMarketRankRankMouth().fromJson(v)).toList();
	}
	if (json['my_rank'] != null) {
		data.myRank = json['my_rank'].toString();
	}
	if (json['my_rank_amount'] != null) {
		data.myRankAmount = json['my_rank_amount'].toString();
	}
	return data;
}

Map<String, dynamic> userMarketRankEntityToJson(UserMarketRankEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rank_year'] =  entity.rankYear?.map((v) => v.toJson())?.toList();
	data['rank_mouth'] =  entity.rankMouth?.map((v) => v.toJson())?.toList();
	data['my_rank'] = entity.myRank;
	data['my_rank_amount'] = entity.myRankAmount;
	return data;
}

userMarketRankRankYearFromJson(UserMarketRankRankYear data, Map<String, dynamic> json) {
	if (json['user_name'] != null) {
		data.userName = json['user_name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['rank'] != null) {
		data.rank = json['rank'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['rank_amount'] != null) {
		data.rankAmount = json['rank_amount'].toString();
	}
	return data;
}

Map<String, dynamic> userMarketRankRankYearToJson(UserMarketRankRankYear entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user_name'] = entity.userName;
	data['code'] = entity.code;
	data['rank'] = entity.rank;
	data['avatar'] = entity.avatar;
	data['rank_amount'] = entity.rankAmount;
	return data;
}

userMarketRankRankMouthFromJson(UserMarketRankRankMouth data, Map<String, dynamic> json) {
	if (json['user_name'] != null) {
		data.userName = json['user_name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['rank'] != null) {
		data.rank = json['rank'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['rank_amount'] != null) {
		data.rankAmount = json['rank_amount'].toString();
	}
	return data;
}

Map<String, dynamic> userMarketRankRankMouthToJson(UserMarketRankRankMouth entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user_name'] = entity.userName;
	data['code'] = entity.code;
	data['rank'] = entity.rank;
	data['avatar'] = entity.avatar;
	data['rank_amount'] = entity.rankAmount;
	return data;
}