import 'package:mars/wallet/mobels/play_article_list_entity.dart';

playArticleListEntityFromJson(PlayArticleListEntity data, Map<String, dynamic> json) {
	if (json['article_id'] != null) {
		data.articleId = json['article_id'].toString();
	}
	if (json['article_title'] != null) {
		data.articleTitle = json['article_title'].toString();
	}
	if (json['article_content'] != null) {
		data.articleContent = json['article_content'];
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['create_date'] != null) {
		data.createDate = json['create_date'].toString();
	}
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['label_name'] != null) {
		data.labelName = json['label_name'].toString();
	}
	if (json['file'] != null) {
		data.file = (json['file'] as List).map((v) => PlayArticleListFile().fromJson(v)).toList();
	}
	if (json['is_lkie'] != null) {
		data.isLkie = json['is_lkie'].toString();
	}
	if (json['liker'] != null) {
		data.liker = (json['liker'] as List).map((v) => PlayArticleListLiker().fromJson(v)).toList();
	}
	if (json['comment'] != null) {
		data.comment = (json['comment'] as List).map((v) => PlayArticleListCommant().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> playArticleListEntityToJson(PlayArticleListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['article_id'] = entity.articleId;
	data['article_title'] = entity.articleTitle;
	data['article_content'] = entity.articleContent;
	data['create_time'] = entity.createTime;
	data['create_date'] = entity.createDate;
	data['nick_name'] = entity.nickName;
	data['avatar'] = entity.avatar;
	data['label_name'] = entity.labelName;
	data['file'] =  entity.file?.map((v) => v.toJson())?.toList();
	data['is_lkie'] = entity.isLkie;
	data['liker'] =  entity.liker?.map((v) => v.toJson())?.toList();
	data['comment'] =  entity.comment?.map((v) => v.toJson())?.toList();
	return data;
}

playArticleListFileFromJson(PlayArticleListFile data, Map<String, dynamic> json) {
	if (json['file_url'] != null) {
		data.fileUrl = json['file_url'].toString();
	}
	if (json['file_type'] != null) {
		data.fileType = json['file_type'].toString();
	}
	if (json['file_cover'] != null) {
		data.fileCover = json['file_cover'].toString();
	}
	return data;
}

Map<String, dynamic> playArticleListFileToJson(PlayArticleListFile entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['file_url'] = entity.fileUrl;
	data['file_type'] = entity.fileType;
	data['file_cover'] = entity.fileCover;
	return data;
}

playArticleListLikerFromJson(PlayArticleListLiker data, Map<String, dynamic> json) {
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	return data;
}

Map<String, dynamic> playArticleListLikerToJson(PlayArticleListLiker entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['nick_name'] = entity.nickName;
	data['avatar'] = entity.avatar;
	return data;
}

playArticleListCommantFromJson(PlayArticleListCommant data, Map<String, dynamic> json) {
	if (json['comment_id'] != null) {
		data.commentId = json['comment_id'].toString();
	}
	if (json['article_id'] != null) {
		data.articleId = json['article_id'].toString();
	}
	if (json['uid'] != null) {
		data.uid = json['uid'].toString();
	}
	if (json['comment_content'] != null) {
		data.commentContent = json['comment_content'].toString();
	}
	if (json['is_delete'] != null) {
		data.isDelete = json['is_delete'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['create_date'] != null) {
		data.createDate = json['create_date'].toString();
	}
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	return data;
}

Map<String, dynamic> playArticleListCommantToJson(PlayArticleListCommant entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['comment_id'] = entity.commentId;
	data['article_id'] = entity.articleId;
	data['uid'] = entity.uid;
	data['comment_content'] = entity.commentContent;
	data['is_delete'] = entity.isDelete;
	data['create_time'] = entity.createTime;
	data['create_date'] = entity.createDate;
	data['nick_name'] = entity.nickName;
	data['avatar'] = entity.avatar;
	return data;
}