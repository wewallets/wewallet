import 'package:json_annotation/json_annotation.dart';

part 'walletActivityInfo.g.dart';

@JsonSerializable()
class WalletActivityInfo {
    WalletActivityInfo();

    String id;
    String title;
    String ac_start_time;
    String ac_end_time;
    String sg_start_time;
    String sg_end_time;
    String limit_currency;
    String limit_num;
    String create_time;
    String update_time;
    String user_id;
    String have_vote;
    String status;
    String have_purse;
    String remark;
    String vote_status;
    
    factory WalletActivityInfo.fromJson(Map<String,dynamic> json) => _$WalletActivityInfoFromJson(json);
    Map<String, dynamic> toJson() => _$WalletActivityInfoToJson(this);
}
