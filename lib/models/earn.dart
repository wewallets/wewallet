import 'package:json_annotation/json_annotation.dart';

part 'earn.g.dart';

@JsonSerializable()
class Earn {
    Earn();

    num my;
    num recom;
    num team;
    
    factory Earn.fromJson(Map<String,dynamic> json) => _$EarnFromJson(json);
    Map<String, dynamic> toJson() => _$EarnToJson(this);
}
