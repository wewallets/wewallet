class BackupItem {
  //内容
  String content;

  //是否顺序错误
  bool isCorrect = false;

  //是否可以选择
  bool isUse = false;

  BackupItem({this.content, this.isCorrect, this.isUse});
}
