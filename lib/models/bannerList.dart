import 'package:json_annotation/json_annotation.dart';

part 'bannerList.g.dart';

@JsonSerializable()
class BannerList {
    BannerList();

    String banner_url;
    
    factory BannerList.fromJson(Map<String,dynamic> json) => _$BannerListFromJson(json);
    Map<String, dynamic> toJson() => _$BannerListToJson(this);
}
