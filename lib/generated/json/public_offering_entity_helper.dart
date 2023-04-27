import 'package:mars/models/public_offering_entity.dart';

publicOfferingEntityFromJson(PublicOfferingEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['currency'] != null) {
		data.currency = json['currency'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['project_image'] != null) {
		data.projectImage = json['project_image'].toString();
	}
	if (json['auth_time'] != null) {
		data.authTime = json['auth_time'].toString();
	}
	if (json['auth_status'] != null) {
		data.authStatus = json['auth_status'].toString();
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
	if (json['intro'] != null) {
		data.intro = json['intro'].toString();
	}
	if (json['intro_en'] != null) {
		data.introEn = json['intro_en'];
	}
	if (json['explain'] != null) {
		data.explain = json['explain'].toString();
	}
	if (json['explain_en'] != null) {
		data.explainEn = json['explain_en'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['order_id'] != null) {
		data.orderId = json['order_id'];
	}
	if (json['order_tid'] != null) {
		data.orderTid = json['order_tid'];
	}
	if (json['product_start_time'] != null) {
		data.productStartTime = json['product_start_time'].toString();
	}
	if (json['product_end_time'] != null) {
		data.productEndTime = json['product_end_time'].toString();
	}
	return data;
}

Map<String, dynamic> publicOfferingEntityToJson(PublicOfferingEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['currency'] = entity.currency;
	data['title'] = entity.title;
	data['project_image'] = entity.projectImage;
	data['auth_time'] = entity.authTime;
	data['auth_status'] = entity.authStatus;
	data['issue_time'] = entity.issueTime;
	data['issue_total'] = entity.issueTotal;
	data['whitepaper'] = entity.whitepaper;
	data['website'] = entity.website;
	data['address'] = entity.address;
	data['intro'] = entity.intro;
	data['intro_en'] = entity.introEn;
	data['explain'] = entity.explain;
	data['explain_en'] = entity.explainEn;
	data['status'] = entity.status;
	data['order_id'] = entity.orderId;
	data['order_tid'] = entity.orderTid;
	data['product_start_time'] = entity.productStartTime;
	data['product_end_time'] = entity.productEndTime;
	return data;
}