import 'package:mars/wallet/mobels/pledge_list_entity.dart';

pledgeListEntityFromJson(PledgeListEntity data, Map<String, dynamic> json) {
	if (json['pledge_id'] != null) {
		data.pledgeId = json['pledge_id'].toString();
	}
	if (json['uid'] != null) {
		data.uid = json['uid'].toString();
	}
	if (json['pledge_amount'] != null) {
		data.pledgeAmount = json['pledge_amount'].toString();
	}
	if (json['out_amount'] != null) {
		data.outAmount = json['out_amount'].toString();
	}
	if (json['out_fee_amount'] != null) {
		data.outFeeAmount = json['out_fee_amount'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['out_time'] != null) {
		data.outTime = json['out_time'].toString();
	}
	return data;
}

Map<String, dynamic> pledgeListEntityToJson(PledgeListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['pledge_id'] = entity.pledgeId;
	data['uid'] = entity.uid;
	data['pledge_amount'] = entity.pledgeAmount;
	data['out_amount'] = entity.outAmount;
	data['out_fee_amount'] = entity.outFeeAmount;
	data['status'] = entity.status;
	data['create_time'] = entity.createTime;
	data['out_time'] = entity.outTime;
	return data;
}