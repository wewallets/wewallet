import 'package:json_annotation/json_annotation.dart';

part 'appConfig.g.dart';

@JsonSerializable()
class AppConfig {
    AppConfig();

    String config_id;
    String forced_update;
    String version_no;
    String tiltle;
    String content;
    String ios_addr;
    String web_addr;
    String android_addr;
    String ios_version_no;
    String ios_version;
    String version;
    
    factory AppConfig.fromJson(Map<String,dynamic> json) => _$AppConfigFromJson(json);
    Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}
