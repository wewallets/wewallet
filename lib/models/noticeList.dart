import 'package:json_annotation/json_annotation.dart';

part 'noticeList.g.dart';

@JsonSerializable()
class NoticeList {
    NoticeList();

    String id;
    String title;
    String thumb;
    String create_time;
    String update_time;
    String introduction;
    String content;
    String status;
    String url;
    String publisher;
    String publisher_avatar;
    
    factory NoticeList.fromJson(Map<String,dynamic> json) => _$NoticeListFromJson(json);
    Map<String, dynamic> toJson() => _$NoticeListToJson(this);
}
