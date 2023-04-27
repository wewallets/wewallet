class HistoryBean {
  int code;
  String msg;
  List<HistoryData> data;

  HistoryBean({this.code, this.msg, this.data});

  HistoryBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<HistoryData>();
      json['data'].forEach((v) {
        data.add(new HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryData {
  String id;
  String symbol;
  String tradeId;
  String amount;
  String price;
  String ts;
  String direction;
  String market1;
  String market2;

  HistoryData(
      {this.id,
      this.symbol,
      this.tradeId,
      this.amount,
      this.price,
      this.ts,
      this.direction,
      this.market1,
      this.market2});

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    tradeId = json['tradeId'];
    amount = json['amount'];
    price = json['price'];
    ts = json['ts'];
    direction = json['direction'];
    market1 = json['market1'];
    market2 = json['market2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['tradeId'] = this.tradeId;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['ts'] = this.ts;
    data['direction'] = this.direction;
    data['market1'] = this.market1;
    data['market2'] = this.market2;
    return data;
  }
}
