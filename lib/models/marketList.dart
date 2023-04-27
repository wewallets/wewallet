import 'package:json_annotation/json_annotation.dart';

part 'marketList.g.dart';

@JsonSerializable()
class MarketList {
    MarketList();

    String trad_currency_name;
    String base_currency_name;
    String symbol;
    String amount;
    String count;
    String open;
    String low;
    String high;
    String vol;
    String bid;
    String bidSize;
    String ask;
    String askSize;
    String close;
    String rice_fall;
    String is_new;
    String cny_value;
    String unit_price;
    
    factory MarketList.fromJson(Map<String,dynamic> json) => _$MarketListFromJson(json);
    Map<String, dynamic> toJson() => _$MarketListToJson(this);
}
