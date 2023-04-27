class MarketDetailBean {
  String close;
  String amount;
  String count;
  String open;
  String low;
  String high;
  String vol;
  String symbol;
  String bid;
  String bidSize;
  String ask;
  String askSize;
  String riceFall;
  String amountCny;
  String ask_size;
  String rice_fall;
  String amount_cny;
  String is_other;
  String close_yesterday;

  MarketDetailBean({this.close, this.amount, this.count, this.open, this.low, this.high, this.vol, this.symbol, this.bid, this.bidSize, this.ask, this.askSize, this.riceFall, this.amountCny});

  MarketDetailBean.fromJson(Map<String, dynamic> json) {
    close = json['close'];
    amount = json['amount'];
    count = json['count'];
    open = json['open'];
    low = json['low'];
    high = json['high'];
    vol = json['vol'];
    symbol = json['symbol'];
    bid = json['bid'];
    bidSize = json['bidSize'];
    ask = json['ask'];
    askSize = json['askSize'];
    riceFall = json['riceFall'];
    amountCny = json['amountCny'];
    ask_size = json['ask_size'];
    rice_fall = json['rice_fall'];
    is_other = json['is_other'];
    amount_cny = json['amount_cny'];
    close_yesterday = json['close_yesterday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['close'] = this.close;
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['open'] = this.open;
    data['low'] = this.low;
    data['high'] = this.high;
    data['vol'] = this.vol;
    data['symbol'] = this.symbol;
    data['bid'] = this.bid;
    data['bidSize'] = this.bidSize;
    data['ask'] = this.ask;
    data['askSize'] = this.askSize;
    data['rice_fall'] = this.riceFall;
    data['amount_cny'] = this.amountCny;
    data['close_yesterday'] = this.close_yesterday;
    return data;
  }
}
