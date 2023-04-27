import 'package:mars/wallet/mobels/article_list_entity.dart';

articleListEntityFromJson(ArticleListEntity data, Map<String, dynamic> json) {
	if (json['article_id'] != null) {
		data.articleId = json['article_id'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	if (json['add_time'] != null) {
		data.addTime = json['add_time'].toString();
	}
	if (json['sort_order'] != null) {
		data.sortOrder = json['sort_order'].toString();
	}
	return data;
}

Map<String, dynamic> articleListEntityToJson(ArticleListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['article_id'] = entity.articleId;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['add_time'] = entity.addTime;
	data['sort_order'] = entity.sortOrder;
	return data;
}