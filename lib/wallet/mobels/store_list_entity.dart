import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class StoreListEntity with JsonConvert<StoreListEntity> {
	@JSONField(name: "store_id")
	String storeId;
	@JSONField(name: "store_name_en")
	String storeNameEn;
	@JSONField(name: "store_address_en")
	String storeAddressEn;
	@JSONField(name: "store_mobile_en")
	String storeMobileEn;
	@JSONField(name: "store_name_vi")
	String storeNameVi;
	@JSONField(name: "store_address_vi")
	String storeAddressVi;
	@JSONField(name: "store_mobile_vi")
	String storeMobileVi;
	@JSONField(name: "store_status")
	String storeStatus;
	@JSONField(name: "store_address")
	String storeAddress;
	@JSONField(name: "store_name")
	String storeName;
	@JSONField(name: "store_mobile")
	String storeMobile;
}
