import 'package:json_annotation/json_annotation.dart';

part 'wallet_activity_info.g.dart';

@JsonSerializable()
class Wallet_activity_info {
    Wallet_activity_info();

    String active_id;
    String base_currency_id;
    String base_currency_name;
    String vote_num;
    String icon;
    String subscribe_total;
    String user_id;
    String user_account;
    String create_time;
    String have_vote;
    
    factory Wallet_activity_info.fromJson(Map<String,dynamic> json) => _$Wallet_activity_infoFromJson(json);
    Map<String, dynamic> toJson() => _$Wallet_activity_infoToJson(this);
}
