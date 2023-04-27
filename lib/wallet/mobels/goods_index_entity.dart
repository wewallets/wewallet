import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class GoodsIndexEntity with JsonConvert<GoodsIndexEntity> {
	@JSONField(name: "goods_list")
	List<GoodsIndexGoodsList> goodsList;
	@JSONField(name: "index_bmg")
	String indexBmg;
}

class GoodsIndexGoodsList with JsonConvert<GoodsIndexGoodsList> {
	@JSONField(name: "goods_id")
	String goodsId;
	@JSONField(name: "goods_name")
	String goodsName;
	@JSONField(name: "shop_price")
	String shopPrice;
	@JSONField(name: "goods_thumb")
	String goodsThumb;
	String gcount;
}
