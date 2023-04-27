import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class OrderListEntity with JsonConvert<OrderListEntity> {
	@JSONField(name: "order_express")
	dynamic orderExpress;
	@JSONField(name: "order_id")
	String orderId;
	@JSONField(name: "order_sn")
	String orderSn;
	@JSONField(name: "order_amount")
	String orderAmount;
	@JSONField(name: "shipping_status")
	String shippingStatus;
	@JSONField(name: "receipt_time")
	String receiptTime;
	@JSONField(name: "address_id")
	String addressId;
	String consignee;
	@JSONField(name: "province_name")
	String provinceName;
	@JSONField(name: "city_name")
	String cityName;
	@JSONField(name: "district_name")
	String districtName;
	String address;
	String mobile;
	@JSONField(name: "status_name")
	String statusName;
	@JSONField(name: "order_type")
	String orderType;
	@JSONField(name: "pay_type")
	String payType;
	@JSONField(name: "is_first")
	String isFirst;
	@JSONField(name: "add_time")
	String add_time;
	@JSONField(name: "shipping_time")
	String shipping_time;
	@JSONField(name: "pay_type")
	String pay_type;

	List<OrderListGood> goods;
}

class OrderListGood with JsonConvert<OrderListGood> {
	@JSONField(name: "rec_id")
	String recId;
	@JSONField(name: "goods_id")
	String goodsId;
	@JSONField(name: "goods_name")
	String goodsName;
	@JSONField(name: "goods_number")
	String goodsNumber;
	@JSONField(name: "goods_price")
	String goodsPrice;
	@JSONField(name: "goods_thumb")
	String goodsThumb;
	@JSONField(name: "shop_price")
	String shopPrice;

}
