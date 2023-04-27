import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class StoreInfoEntity with JsonConvert<StoreInfoEntity> {
	@JSONField(name: "store_id")
	String storeId;
	@JSONField(name: "store_name")
	String storeName;
	@JSONField(name: "store_address")
	String storeAddress;
	@JSONField(name: "store_mobile")
	String storeMobile;
	@JSONField(name: "store_status")
	String storeStatus;
}
