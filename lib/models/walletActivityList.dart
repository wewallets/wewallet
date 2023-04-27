import 'package:json_annotation/json_annotation.dart';

part 'walletActivityList.g.dart';

@JsonSerializable()
class WalletActivityList {
    WalletActivityList();

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
    
    factory WalletActivityList.fromJson(Map<String,dynamic> json) => _$WalletActivityListFromJson(json);
    Map<String, dynamic> toJson() => _$WalletActivityListToJson(this);
}
