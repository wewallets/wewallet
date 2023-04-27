import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class BannerListEntity with JsonConvert<BannerListEntity> {
	@JSONField(name: "banner_url")
	String bannerUrl;
}
