import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class CollectionListEntity with JsonConvert<CollectionListEntity> {
	@JSONField(name: "goods_id")
	String goodsId;
	@JSONField(name: "goods_name")
	String goodsName;
	@JSONField(name: "shop_price")
	String shopPrice;
	@JSONField(name: "market_price")
	String marketPrice;
	@JSONField(name: "goods_thumb")
	String goodsThumb;
	@JSONField(name: "goods_brief")
	String goodsBrief;
	String keywords;
	@JSONField(name: "is_gold")
	String isGold;
	@JSONField(name: "is_support_repo")
	String is_support_repo;
}
