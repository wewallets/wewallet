// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noticeList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeList _$NoticeListFromJson(Map<String, dynamic> json) {
  return NoticeList()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..thumb = json['thumb'] as String
    ..create_time = json['create_time'] as String
    ..update_time = json['update_time'] as String
    ..introduction = json['introduction'] as String
    ..content = json['content'] as String
    ..status = json['status'] as String
    ..url = json['url'] as String
    ..publisher = json['publisher'] as String
    ..publisher_avatar = json['publisher_avatar'] as String;
}

Map<String, dynamic> _$NoticeListToJson(NoticeList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumb': instance.thumb,
      'create_time': instance.create_time,
      'update_time': instance.update_time,
      'introduction': instance.introduction,
      'content': instance.content,
      'status': instance.status,
      'url': instance.url,
      'publisher': instance.publisher,
      'publisher_avatar': instance.publisher_avatar
    };
