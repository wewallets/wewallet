import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class CollectionProductRandEntity with JsonConvert<CollectionProductRandEntity> {
  @JSONField(name: "unit_price")
  String unitPrice;
  @JSONField(name: "product_urls")
  String productUrls;
  List<CollectionProductRandIncome> income;
  @JSONField(name: "pay_amount")
  String payAmount;
  @JSONField(name: "year_award")
  String yearAward;
  String title;
  @JSONField(name: "refer_uprice")
  String referUprice;
  String day;
  @JSONField(name: "day_str")
  String dayStr;
  String amount;
  String remark;
  @JSONField(name: "product_id")
  String productId;
}

class CollectionProductRandIncome with JsonConvert<CollectionProductRandIncome> {
  String currency;
  String income;
}
