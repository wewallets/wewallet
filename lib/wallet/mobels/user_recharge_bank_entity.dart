import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class UserRechargeBankEntity with JsonConvert<UserRechargeBankEntity> {
	@JSONField(name: "bank_name")
	String bankName;
	@JSONField(name: "bank_account")
	String bankAccount;
	@JSONField(name: "bank_user")
	String bankUser;
	String remark;
}
