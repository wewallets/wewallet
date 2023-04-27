import 'package:json_annotation/json_annotation.dart';

part 'get_balance.g.dart';

@JsonSerializable()
class Get_balance {
    Get_balance();

    String currency;
    String balance;
    String order_value;
    String offer_value;
    
    factory Get_balance.fromJson(Map<String,dynamic> json) => _$Get_balanceFromJson(json);
    Map<String, dynamic> toJson() => _$Get_balanceToJson(this);
}
