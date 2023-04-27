import 'package:json_annotation/json_annotation.dart';

part 'minerList.g.dart';

@JsonSerializable()
class MinerList {
    MinerList();

    String id;
    String address;
    String parent_address;
    String add_time;
    String totle_income;
    String coin_power;
    String genera_power;
    String miner_remark;
    
    factory MinerList.fromJson(Map<String,dynamic> json) => _$MinerListFromJson(json);
    Map<String, dynamic> toJson() => _$MinerListToJson(this);
}
