// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_activity_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet_activity_list _$Wallet_activity_listFromJson(Map<String, dynamic> json) {
  return Wallet_activity_list()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..ac_start_time = json['ac_start_time'] as String
    ..ac_end_time = json['ac_end_time'] as String
    ..sg_start_time = json['sg_start_time'] as String
    ..sg_end_time = json['sg_end_time'] as String
    ..limit_currency = json['limit_currency'] as String
    ..limit_num = json['limit_num'] as String
    ..ac_status = json['ac_status'] as String
    ..create_time = json['create_time'] as String
    ..update_time = json['update_time'] as String
    ..user_id = json['user_id'] as String
    ..have_vote = json['have_vote'] as String
    ..sg_status = json['sg_status'] as String
    ..vote_status = json['vote_status'] as String;
}

Map<String, dynamic> _$Wallet_activity_listToJson(
        Wallet_activity_list instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'ac_start_time': instance.ac_start_time,
      'ac_end_time': instance.ac_end_time,
      'sg_start_time': instance.sg_start_time,
      'sg_end_time': instance.sg_end_time,
      'limit_currency': instance.limit_currency,
      'limit_num': instance.limit_num,
      'ac_status': instance.ac_status,
      'create_time': instance.create_time,
      'update_time': instance.update_time,
      'user_id': instance.user_id,
      'have_vote': instance.have_vote,
      'sg_status': instance.sg_status,
      'vote_status': instance.vote_status
    };
