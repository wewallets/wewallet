// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletActivityInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletActivityInfo _$WalletActivityInfoFromJson(Map<String, dynamic> json) {
  return WalletActivityInfo()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..ac_start_time = json['ac_start_time'] as String
    ..ac_end_time = json['ac_end_time'] as String
    ..sg_start_time = json['sg_start_time'] as String
    ..sg_end_time = json['sg_end_time'] as String
    ..limit_currency = json['limit_currency'] as String
    ..limit_num = json['limit_num'] as String
    ..create_time = json['create_time'] as String
    ..update_time = json['update_time'] as String
    ..user_id = json['user_id'] as String
    ..have_vote = json['have_vote'] as String
    ..status = json['status'] as String
    ..have_purse = json['have_purse'] as String
    ..remark = json['remark'] as String
    ..vote_status = json['vote_status'] as String;
}

Map<String, dynamic> _$WalletActivityInfoToJson(WalletActivityInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'ac_start_time': instance.ac_start_time,
      'ac_end_time': instance.ac_end_time,
      'sg_start_time': instance.sg_start_time,
      'sg_end_time': instance.sg_end_time,
      'limit_currency': instance.limit_currency,
      'limit_num': instance.limit_num,
      'create_time': instance.create_time,
      'update_time': instance.update_time,
      'user_id': instance.user_id,
      'have_vote': instance.have_vote,
      'status': instance.status,
      'have_purse': instance.have_purse,
      'remark': instance.remark,
      'vote_status': instance.vote_status
    };
