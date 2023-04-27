import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class BackAddressListEntity with JsonConvert<BackAddressListEntity> {
	String name;
	@JSONField(name: "ajm_address")
	String ajmAddress;
	@JSONField(name: "been_found")
	String beenFound;
}
