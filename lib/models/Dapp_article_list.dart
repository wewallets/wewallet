class DappArticleList {
  DappArticleList({
      this.dappArticleId, 
      this.dappArticleTitle, 
      this.dappArticleInro, 
      this.dappArticleUrl, 
      this.dappCategoryId, 
      this.createTime, 
      this.language, 
      this.group,this.dappArticleIcon});

  DappArticleList.fromJson(dynamic json) {
    dappArticleId = json['dapp_article_id'];
    dappArticleTitle = json['dapp_article_title'];
    dappArticleInro = json['dapp_article_inro'];
    dappArticleUrl = json['dapp_article_url'];
    dappCategoryId = json['dapp_category_id'];
    createTime = json['create_time'];
    language = json['language'];
    group = json['group'];
    dappArticleIcon = json['dapp_article_icon'];
  }
  String dappArticleId;
  String dappArticleTitle;
  String dappArticleInro;
  String dappArticleUrl;
  String dappCategoryId;
  String createTime;
  String language;
  String group;
  String dappArticleIcon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dapp_article_id'] = dappArticleId;
    map['dapp_article_title'] = dappArticleTitle;
    map['dapp_article_inro'] = dappArticleInro;
    map['dapp_article_url'] = dappArticleUrl;
    map['dapp_category_id'] = dappCategoryId;
    map['create_time'] = createTime;
    map['language'] = language;
    map['group'] = group;
    map['dapp_article_icon'] = dappArticleIcon;
    return map;
  }

}