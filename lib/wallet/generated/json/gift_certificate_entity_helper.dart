import 'package:mars/wallet/mobels/gift_certificate_entity.dart';

giftCertificateEntityFromJson(GiftCertificateEntity data, Map<String, dynamic> json) {
	if (json['assets_gold'] != null) {
		data.assetsGold = json['assets_gold'].toString();
	}
	if (json['release_total'] != null) {
		data.releaseTotal = json['release_total'].toString();
	}
	if (json['release_frozen'] != null) {
		data.releaseFrozen = json['release_frozen'].toString();
	}
	if (json['release_lastday_total'] != null) {
		data.releaseLastdayTotal = json['release_lastday_total'].toString();
	}
	if (json['release_lastday_speed'] != null) {
		data.releaseLastdaySpeed = json['release_lastday_speed'].toString();
	}
	if (json['used'] != null) {
		data.used = json['used'].toString();
	}
	return data;
}

Map<String, dynamic> giftCertificateEntityToJson(GiftCertificateEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assets_gold'] = entity.assetsGold;
	data['release_total'] = entity.releaseTotal;
	data['release_frozen'] = entity.releaseFrozen;
	data['release_lastday_total'] = entity.releaseLastdayTotal;
	data['release_lastday_speed'] = entity.releaseLastdaySpeed;
	data['used'] = entity.used;
	return data;
}