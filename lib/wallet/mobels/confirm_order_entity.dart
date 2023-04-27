import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class ConfirmOrderEntity with JsonConvert<ConfirmOrderEntity> {
	@JSONField(name: "coupon_recive")
	List<ConfirmOrderCouponRecive> couponRecive;
	@JSONField(name: "user_address")
	dynamic userAddress;
	List<ConfirmOrderGood> goods;
	@JSONField(name: "order_amount")
	String orderAmount;
}

class ConfirmOrderCouponRecive with JsonConvert<ConfirmOrderCouponRecive> {
	@JSONField(name: "coupon_id")
	String couponId;
	String name;
	@JSONField(name: "cat_id")
	String catId;
	String amount;
	@JSONField(name: "full_amount")
	String fullAmount;
	@JSONField(name: "vaild_start_time")
	String vaildStartTime;
	@JSONField(name: "vaild_end_time")
	String vaildEndTime;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "cat_name")
	String catName;
}

class ConfirmOrderGood with JsonConvert<ConfirmOrderGood> {
	@JSONField(name: "goods_id")
	String goodsId;
	@JSONField(name: "goods_name")
	String goodsName;
	@JSONField(name: "goods_sn")
	String goodsSn;
	@JSONField(name: "shop_price")
	String shopPrice;
	@JSONField(name: "goods_number")
	String goodsNumber;
	@JSONField(name: "market_price")
	String marketPrice;
	@JSONField(name: "goods_thumb")
	String goodsThumb;
	@JSONField(name: "goods_brief")
	String goodsBrief;
	@JSONField(name: "goods_desc")
	String goodsDesc;
	String keywords;
	@JSONField(name: "cat_id")
	String catId;
}
