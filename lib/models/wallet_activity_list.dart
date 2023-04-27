import 'package:json_annotation/json_annotation.dart';

part 'wallet_activity_list.g.dart';

@JsonSerializable()
class Wallet_activity_list {
    Wallet_activity_list();

    String id;
    String title;
    String ac_start_time;
    String ac_end_time;
    String sg_start_time;
    String sg_end_time;
    String limit_currency;
    String limit_num;
    String ac_status;
    String create_time;
    String update_time;
    String user_id;
    String have_vote;
    String sg_status;
    String vote_status;
    
    factory Wallet_activity_list.fromJson(Map<String,dynamic> json) => _$Wallet_activity_listFromJson(json);
    Map<String, dynamic> toJson() => _$Wallet_activity_listToJson(this);
}
