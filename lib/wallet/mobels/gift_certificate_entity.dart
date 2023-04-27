import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class GiftCertificateEntity with JsonConvert<GiftCertificateEntity> {
	@JSONField(name: "assets_gold")
	String assetsGold;
	@JSONField(name: "release_total")
	String releaseTotal;
	@JSONField(name: "release_frozen")
	String releaseFrozen;
	@JSONField(name: "release_lastday_total")
	String releaseLastdayTotal;
	@JSONField(name: "release_lastday_speed")
	String releaseLastdaySpeed;
	String used;
}
