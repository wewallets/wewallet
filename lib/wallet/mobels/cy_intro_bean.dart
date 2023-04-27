class CyIntroBean {
  int code;
  String msg;
  CyIntroData data;

  CyIntroBean({this.code, this.msg, this.data});

  CyIntroBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new CyIntroData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CyIntroData {
  String currency;
  String time;
  String circulateCount;
  String issueCount;
  String price;
  String whiteBook;
  String webside;
  String blockSearch;
  String intro;

  CyIntroData(
      {this.currency,
      this.time,
      this.circulateCount,
      this.issueCount,
      this.price,
      this.whiteBook,
      this.webside,
      this.blockSearch,
      this.intro});

  CyIntroData.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    time = json['time'];
    circulateCount = json['circulate_count'];
    issueCount = json['issue_count'];
    price = json['price'];
    whiteBook = json['white_book'];
    webside = json['webside'];
    blockSearch = json['block_search'];
    intro = json['intro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['time'] = this.time;
    data['circulate_count'] = this.circulateCount;
    data['issue_count'] = this.issueCount;
    data['price'] = this.price;
    data['white_book'] = this.whiteBook;
    data['webside'] = this.webside;
    data['block_search'] = this.blockSearch;
    data['intro'] = this.intro;
    return data;
  }
}
