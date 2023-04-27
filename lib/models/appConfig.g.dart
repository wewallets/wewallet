// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appConfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) {
  return AppConfig()
    ..config_id = json['config_id'] as String
    ..forced_update = json['forced_update'] as String
    ..version_no = json['version_no'] as String
    ..tiltle = json['tiltle'] as String
    ..content = json['content'] as String
    ..ios_addr = json['ios_addr'] as String
    ..web_addr = json['web_addr'] as String
    ..android_addr = json['android_addr'] as String
    ..ios_version_no = json['ios_version_no'] as String
    ..ios_version = json['ios_version'] as String
    ..version = json['version'] as String;
}

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'config_id': instance.config_id,
      'forced_update': instance.forced_update,
      'version_no': instance.version_no,
      'tiltle': instance.tiltle,
      'content': instance.content,
      'ios_addr': instance.ios_addr,
      'web_addr': instance.web_addr,
      'android_addr': instance.android_addr,
      'ios_version_no': instance.ios_version_no,
      'ios_version': instance.ios_version,
      'version': instance.version
    };
