import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class ArticleListEntity with JsonConvert<ArticleListEntity> {
	@JSONField(name: "article_id")
	String articleId;
	String title;
	String content;
	@JSONField(name: "add_time")
	String addTime;
	@JSONField(name: "sort_order")
	String sortOrder;
}
