// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_activity_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet_activity_info _$Wallet_activity_infoFromJson(Map<String, dynamic> json) {
  return Wallet_activity_info()
    ..active_id = json['active_id'] as String
    ..base_currency_id = json['base_currency_id'] as String
    ..base_currency_name = json['base_currency_name'] as String
    ..vote_num = json['vote_num'] as String
    ..icon = json['icon'] as String
    ..subscribe_total = json['subscribe_total'] as String
    ..user_id = json['user_id'] as String
    ..user_account = json['user_account'] as String
    ..create_time = json['create_time'] as String
    ..have_vote = json['have_vote'] as String;
}

Map<String, dynamic> _$Wallet_activity_infoToJson(
        Wallet_activity_info instance) =>
    <String, dynamic>{
      'active_id': instance.active_id,
      'base_currency_id': instance.base_currency_id,
      'base_currency_name': instance.base_currency_name,
      'vote_num': instance.vote_num,
      'icon': instance.icon,
      'subscribe_total': instance.subscribe_total,
      'user_id': instance.user_id,
      'user_account': instance.user_account,
      'create_time': instance.create_time,
      'have_vote': instance.have_vote
    };
