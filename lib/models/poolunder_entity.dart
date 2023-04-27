import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PoolunderEntity with JsonConvert<PoolunderEntity> {
  @JSONField(name: "assets_TH")
  String assets_TH;
  @JSONField(name: "assets_RISE")
  String assets_THC;
  @JSONField(name: "nick_name")
  String nickName;
  String address;
  String total_assets_EAE;
  String total_assets_TH;
  String total_assets_THC;
  String team_money;
}
