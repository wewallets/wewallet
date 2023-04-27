import 'package:json_annotation/json_annotation.dart';

part 'trustHistory.g.dart';

@JsonSerializable()
class TrustHistory {
    TrustHistory();

    String id;
    String symbol;
    String tradeId;
    String amount;
    String price;
    String ts;
    String direction;
    String market1;
    String market2;
    String address1;
    String address2;
    String fee1;
    String fee2;
    String unit_price;
    String prev_amount;
    String prev_price;
    String amount_sum;
    String price_sum;
    String prev_amount_sum;
    String prev_price_sum;
    String prev_unit_price;
    String total_amount;
    String order_status;
    
    factory TrustHistory.fromJson(Map<String,dynamic> json) => _$TrustHistoryFromJson(json);
    Map<String, dynamic> toJson() => _$TrustHistoryToJson(this);
}
