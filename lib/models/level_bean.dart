class LevelBean {
  int code;
  String msg;
  LevelData data;

  LevelBean({this.code, this.msg, this.data});

  LevelBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new LevelData.fromJson(json['data']) : null;
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

class LevelData {
  LevelTick tick;

  LevelData({this.tick});

  LevelData.fromJson(Map<String, dynamic> json) {
    tick = json['tick'] != null ? new LevelTick.fromJson(json['tick']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tick != null) {
      data['tick'] = this.tick.toJson();
    }
    return data;
  }
}

class LevelTick {
  List<LevelInfo> buy;
  List<LevelInfo> sell;

  LevelTick({this.buy, this.sell});

  LevelTick.fromJson(Map<String, dynamic> json) {
    if (json['buy'] != null) {
      buy = new List<LevelInfo>();
      json['buy'].forEach((v) {
        buy.add(new LevelInfo.fromJson(v));
      });
    }
    if (json['sell'] != null) {
      sell = new List<LevelInfo>();
      json['sell'].forEach((v) {
        sell.add(new LevelInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.buy != null) {
      data['buy'] = this.buy.map((v) => v.toJson()).toList();
    }
    if (this.sell != null) {
      data['sell'] = this.sell.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LevelInfo {
  String orderId;
  String symbol;
  String orderSide;
  String orderType;
  String orderStatus;
  String orderPrice;
  String orderValue;
  String orderOrigTime;
  String orderSucValue;
  String account;
  String orderSucPrice;
  String lastValue;
  String valueMerge;
  String deci;
  LevelInfo(
      {this.orderId,
      this.symbol,
      this.orderSide,
      this.orderType,
      this.orderStatus,
      this.orderPrice,
      this.orderValue,
      this.orderOrigTime,
      this.orderSucValue,
      this.account,
      this.orderSucPrice,
      this.lastValue,
      this.valueMerge});

  LevelInfo.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    symbol = json['symbol'];
    orderSide = json['orderSide'];
    orderType = json['orderType'];
    orderStatus = json['orderStatus'];
    orderPrice = json['unit_price'];
    orderValue = json['orderValue'];
    orderOrigTime = json['orderOrigTime'];
    orderSucValue = json['suc_value_merge'];
    account = json['account'];
    orderSucPrice = json['orderSucPrice'];
    deci = json['deci'];
    lastValue = json['last_value_merge'];
    valueMerge = json['value_merge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['symbol'] = this.symbol;
    data['orderSide'] = this.orderSide;
    data['orderType'] = this.orderType;
    data['orderStatus'] = this.orderStatus;
    data['orderPrice'] = this.orderPrice;
    data['orderValue'] = this.orderValue;
    data['orderOrigTime'] = this.orderOrigTime;
    data['orderSucValue'] = this.orderSucValue;
    data['deci'] = this.deci;
    data['account'] = this.account;
    data['orderSucPrice'] = this.orderSucPrice;
    data['lastValue'] = this.lastValue;
    data['valueMerge'] = this.valueMerge;
    return data;
  }
}
