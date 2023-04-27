import 'package:json_annotation/json_annotation.dart';

part 'profit.g.dart';

@JsonSerializable()
class Profit {
    Profit();

    String yesterday_profit;
    String yesterday_profit_cny;
    String balance;
    String balance_mpool;
    String all_profit;
    String total_award;

    factory Profit.fromJson(Map<String,dynamic> json) => _$ProfitFromJson(json);
    Map<String, dynamic> toJson() => _$ProfitToJson(this);
}
