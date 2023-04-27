import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class BankCardInfoEntity with JsonConvert<BankCardInfoEntity> {
	@JSONField(name: "bank_id")
	String bankId;
	@JSONField(name: "bank_name")
	String bankName;
	@JSONField(name: "bank_account")
	String bankAccount;
	@JSONField(name: "bank_user")
	String bankUser;
	@JSONField(name: "add_time")
	String addTime;
	@JSONField(name: "add_date")
	String addDate;
	@JSONField(name: "is_delete")
	String isDelete;
	@JSONField(name: "sort_order")
	String sortOrder;
}
