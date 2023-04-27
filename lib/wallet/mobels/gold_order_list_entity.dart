import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class GoldOrderListEntity with JsonConvert<GoldOrderListEntity> {
	@JSONField(name: "order_express")
	dynamic orderExpress;
	@JSONField(name: "gold_order_id")
	String goldOrderId;
	@JSONField(name: "order_sn")
	String orderSn;
	@JSONField(name: "order_amount")
	String orderAmount;
	@JSONField(name: "shipping_status")
	String shippingStatus;
	@JSONField(name: "receipt_time")
	String receiptTime;
	@JSONField(name: "pay_type")
	String payType;
	@JSONField(name: "add_time")
	String addTime;
	@JSONField(name: "shipping_time")
	String shippingTime;
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
	@JSONField(name: "shipping_type")
	String shippingType;
	@JSONField(name: "status_name")
	String statusName;
	@JSONField(name: "invoice_no")
	String invoiceNo;
	List<GoldOrderListGood> goods;
	@JSONField(name: "store_address")
	String storeAddress;
	@JSONField(name: "store_name")
	String storeName;
	@JSONField(name: "store_mobile")
	String storeMobile;
}

class GoldOrderListGood with JsonConvert<GoldOrderListGood> {
	@JSONField(name: "rec_id")
	String recId;
	@JSONField(name: "goods_id")
	String goodsId;
	@JSONField(name: "goods_name")
	String goodsName;
	@JSONField(name: "goods_number")
	String goodsNumber;
	@JSONField(name: "goods_thumb")
	String goodsThumb;
}
