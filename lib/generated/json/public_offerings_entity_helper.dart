import 'package:mars/models/public_offerings_entity.dart';

publicOfferingsEntityFromJson(PublicOfferingsEntity data, Map<String, dynamic> json) {
	if (json['currency'] != null) {
		data.currency = json['currency'].toString();
	}
	if (json['project_image'] != null) {
		data.projectImage = json['project_image'].toString();
	}
	if (json['auth_time'] != null) {
		data.authTime = json['auth_time'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['product_people_each'] != null) {
		data.productPeopleEach = json['product_people_each'].toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro'];
	}
	if (json['explain'] != null) {
		data.explain = json['explain'];
	}
	if (json['issue_time'] != null) {
		data.issueTime = json['issue_time'].toString();
	}
	if (json['issue_total'] != null) {
		data.issueTotal = json['issue_total'].toString();
	}
	if (json['whitepaper'] != null) {
		data.whitepaper = json['whitepaper'].toString();
	}
	if (json['website'] != null) {
		data.website = json['website'].toString();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['product_status'] != null) {
		data.productStatus = json['product_status'].toString();
	}
	if (json['product_pay_currency'] != null) {
		data.productPayCurrency = json['product_pay_currency'].toString();
	}
	if (json['order_pay_amount'] != null) {
		data.orderPayAmount = json['order_pay_amount'].toString();
	}
	if (json['product_currency'] != null) {
		data.productCurrency = json['product_currency'].toString();
	}
	if (json['order_amount'] != null) {
		data.orderAmount = json['order_amount'].toString();
	}
	if (json['product_exchange_price'] != null) {
		data.productExchangePrice = json['product_exchange_price'].toString();
	}
	if (json['is_buy'] != null) {
		data.isBuy = json['is_buy'].toString();
	}
	return data;
}

Map<String, dynamic> publicOfferingsEntityToJson(PublicOfferingsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['currency'] = entity.currency;
	data['project_image'] = entity.projectImage;
	data['auth_time'] = entity.authTime;
	data['title'] = entity.title;
	data['product_people_each'] = entity.productPeopleEach;
	data['intro'] = entity.intro;
	data['explain'] = entity.explain;
	data['issue_time'] = entity.issueTime;
	data['issue_total'] = entity.issueTotal;
	data['whitepaper'] = entity.whitepaper;
	data['website'] = entity.website;
	data['address'] = entity.address;
	data['product_status'] = entity.productStatus;
	data['product_pay_currency'] = entity.productPayCurrency;
	data['order_pay_amount'] = entity.orderPayAmount;
	data['product_currency'] = entity.productCurrency;
	data['order_amount'] = entity.orderAmount;
	data['product_exchange_price'] = entity.productExchangePrice;
	data['is_buy'] = entity.isBuy;
	return data;
}