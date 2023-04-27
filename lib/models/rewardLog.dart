import 'package:json_annotation/json_annotation.dart';

part 'rewardLog.g.dart';

@JsonSerializable()
class RewardLog {
    RewardLog();

    String id;
    String uid;
    String pid;
    String amount;
    String day;
    String create_time;
    String type;
    String hash;
    String remark;
    
    factory RewardLog.fromJson(Map<String,dynamic> json) => _$RewardLogFromJson(json);
    Map<String, dynamic> toJson() => _$RewardLogToJson(this);
}
