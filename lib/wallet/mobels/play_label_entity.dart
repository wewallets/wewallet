import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class PlayLabelEntity with JsonConvert<PlayLabelEntity> {
	@JSONField(name: "label_id")
	String labelId;
	@JSONField(name: "label_name")
	String labelName;
	@JSONField(name: "is_delete")
	String isDelete;
	@JSONField(name: "sort_order")
	String sortOrder;
}
