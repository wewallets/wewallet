// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minerList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinerList _$MinerListFromJson(Map<String, dynamic> json) {
  return MinerList()
    ..id = json['id'] as String
    ..address = json['address'] as String
    ..parent_address = json['parent_address'] as String
    ..add_time = json['add_time'] as String
    ..totle_income = json['totle_income'] as String
    ..coin_power = json['coin_power'] as String
    ..genera_power = json['genera_power'] as String
    ..miner_remark = json['miner_remark'] as String;
}

Map<String, dynamic> _$MinerListToJson(MinerList instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'parent_address': instance.parent_address,
      'add_time': instance.add_time,
      'totle_income': instance.totle_income,
      'coin_power': instance.coin_power,
      'genera_power': instance.genera_power,
      'miner_remark': instance.miner_remark
    };
