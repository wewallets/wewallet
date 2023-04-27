// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewardLog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardLog _$RewardLogFromJson(Map<String, dynamic> json) {
  return RewardLog()
    ..id = json['id'] as String
    ..uid = json['uid'] as String
    ..pid = json['pid'] as String
    ..amount = json['amount'] as String
    ..day = json['day'] as String
    ..create_time = json['create_time'] as String
    ..type = json['type'] as String
    ..hash = json['hash'] as String
    ..remark = json['remark'] as String;
}

Map<String, dynamic> _$RewardLogToJson(RewardLog instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'pid': instance.pid,
      'amount': instance.amount,
      'day': instance.day,
      'create_time': instance.create_time,
      'type': instance.type,
      'hash': instance.hash,
      'remark': instance.remark
    };
