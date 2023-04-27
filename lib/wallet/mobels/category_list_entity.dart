import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class CategoryListEntity with JsonConvert<CategoryListEntity> {
	@JSONField(name: "cat_id")
	String catId;
	@JSONField(name: "cat_name")
	String catName;
	@JSONField(name: "cat_icon")
	String catIcon;

}
