import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class BannerListEntity with JsonConvert<BannerListEntity> {
	@JSONField(name: "banner_id")
	String bannerId;
	String img;
	@JSONField(name: "sort_order")
	String sortOrder;
	@JSONField(name: "is_show")
	String isShow;
	@JSONField(name: "goods_id")
	String goodsId;
}
