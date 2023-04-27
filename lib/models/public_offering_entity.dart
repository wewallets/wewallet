import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class PublicOfferingEntity with JsonConvert<PublicOfferingEntity> {
	String id;
	String currency;
	String title;
	@JSONField(name: "project_image")
	String projectImage;
	@JSONField(name: "auth_time")
	String authTime;
	@JSONField(name: "auth_status")
	String authStatus;
	@JSONField(name: "issue_time")
	String issueTime;
	@JSONField(name: "issue_total")
	String issueTotal;
	String whitepaper;
	String website;
	String address;
	String intro;
	@JSONField(name: "intro_en")
	dynamic introEn;
	String explain;
	@JSONField(name: "explain_en")
	dynamic explainEn;
	dynamic status;
	@JSONField(name: "order_id")
	dynamic orderId;
	@JSONField(name: "order_tid")
	dynamic orderTid;
	@JSONField(name: "product_start_time")
	String productStartTime;
	@JSONField(name: "product_end_time")
	String productEndTime;
}
