import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class ChildListEntity with JsonConvert<ChildListEntity> {
	String account;
	@JSONField(name: "nick_name")
	String nickName;
}
