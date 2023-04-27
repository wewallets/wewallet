import 'package:mars/wallet/generated/json/base/json_convert_content.dart';
import 'package:mars/wallet/generated/json/base/json_field.dart';

class PlayArticleListEntity with JsonConvert<PlayArticleListEntity> {
	@JSONField(name: "article_id")
	String articleId;
	@JSONField(name: "article_title")
	String articleTitle;
	@JSONField(name: "article_content")
	dynamic articleContent;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "create_date")
	String createDate;
	@JSONField(name: "nick_name")
	String nickName;
	String avatar;
	@JSONField(name: "label_name")
	String labelName;
	List<PlayArticleListFile> file;
	@JSONField(name: "is_lkie")
	String isLkie;
	List<PlayArticleListLiker> liker;
	List<PlayArticleListCommant> comment;
}

class PlayArticleListFile with JsonConvert<PlayArticleListFile> {
	@JSONField(name: "file_url")
	String fileUrl;
	@JSONField(name: "file_type")
	String fileType;
	@JSONField(name: "file_cover")
	String fileCover;

}

class PlayArticleListLiker with JsonConvert<PlayArticleListLiker> {
	@JSONField(name: "nick_name")
	String nickName;
	String avatar;
}

class PlayArticleListCommant with JsonConvert<PlayArticleListCommant> {
	@JSONField(name: "comment_id")
	String commentId;
	@JSONField(name: "article_id")
	String articleId;
	String uid;
	@JSONField(name: "comment_content")
	String commentContent;
	@JSONField(name: "is_delete")
	String isDelete;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "create_date")
	String createDate;
	@JSONField(name: "nick_name")
	String nickName;
	String avatar;
}
