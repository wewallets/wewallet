// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Earn _$EarnFromJson(Map<String, dynamic> json) {
  return Earn()
    ..my = json['my'] as num
    ..recom = json['recom'] as num
    ..team = json['team'] as num;
}

Map<String, dynamic> _$EarnToJson(Earn instance) => <String, dynamic>{
      'my': instance.my,
      'recom': instance.recom,
      'team': instance.team
    };
