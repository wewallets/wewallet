import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class ReciveListEntity with JsonConvert<ReciveListEntity> {
	@JSONField(name: "coupon_id")
	String couponId;
	String name;
	@JSONField(name: "cat_id")
	String catId;
	String amount;
	@JSONField(name: "full_amount")
	String fullAmount;
	@JSONField(name: "vaild_start_time")
	String vaildStartTime;
	@JSONField(name: "vaild_end_time")
	String vaildEndTime;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "cat_name")
	String catName;
}
