import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class GetAppConfigEntity with JsonConvert<GetAppConfigEntity> {
	@JSONField(name: "config_id")
	String configId;
	@JSONField(name: "forced_update")
	String forcedUpdate;
	@JSONField(name: "version_no")
	String versionNo;
	String tiltle;
	String content;
	@JSONField(name: "ios_addr")
	String iosAddr;
	@JSONField(name: "android_addr")
	String androidAddr;
	String version;
}
