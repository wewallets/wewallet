import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class RechargeInfoEntity with JsonConvert<RechargeInfoEntity> {
	@JSONField(name: "recharge_amount")
	String rechargeAmount;
	@JSONField(name: "add_time")
	String addTime;
	@JSONField(name: "add_date")
	String addDate;
	@JSONField(name: "recharge_number")
	String rechargeNumber;
	@JSONField(name: "bank_name")
	String bankName;
	@JSONField(name: "bank_account")
	String bankAccount;
	@JSONField(name: "bank_user")
	String bankUser;
	@JSONField(name: "recharge_status")
	String rechargeStatus;
	@JSONField(name: "recharge_status_str")
	String rechargeStatusStr;
}
