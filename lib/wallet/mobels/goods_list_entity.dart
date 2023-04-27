import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class GoodsListEntity with JsonConvert<GoodsListEntity> {
	@JSONField(name: "goods_id")
	String goodsId;
	@JSONField(name: "goods_name")
	String goodsName;
	@JSONField(name: "shop_price")
	String shopPrice;
	@JSONField(name: "market_price")
	String marketPrice;
	@JSONField(name: "keywords")
	String keywords;
	@JSONField(name: "must_know")
	String mustKnow;
	@JSONField(name: "goods_thumb")
	String goodsThumb;
	String gcount;
	String type;
	@JSONField(name: "goods_sn")
	String goodsSn;
	@JSONField(name: "goods_weight")
	String goodsWeight;
	@JSONField(name: "goods_unit")
	String goodsUnit;
	@JSONField(name: "goods_brief")
	String goodsBrief;
	@JSONField(name: "goods_desc")
	String goodsDesc;
	@JSONField(name: "add_time")
	String add_time;
	@JSONField(name: "shipping_time")
	String shipping_time;
	@JSONField(name: "is_collection")
	String is_collection;
	@JSONField(name: "is_gold")
	String isGold;
	@JSONField(name: "is_support_repo")
	String is_support_repo;

}
