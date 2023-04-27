class DappCategory {
  DappCategory({
      this.dappCategoryId, 
      this.dappCategoryName,});

  DappCategory.fromJson(dynamic json) {
    dappCategoryId = json['dapp_category_id'];
    dappCategoryName = json['dapp_category_name'];
  }
  String dappCategoryId;
  String dappCategoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dapp_category_id'] = dappCategoryId;
    map['dapp_category_name'] = dappCategoryName;
    return map;
  }

}