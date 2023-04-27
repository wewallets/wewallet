import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class PledgeListEntity with JsonConvert<PledgeListEntity> {
	@JSONField(name: "pledge_id")
	String pledgeId;
	String uid;
	@JSONField(name: "pledge_amount")
	String pledgeAmount;
	@JSONField(name: "out_amount")
	String outAmount;
	@JSONField(name: "out_fee_amount")
	String outFeeAmount;
	String status;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "out_time")
	String outTime;
}
