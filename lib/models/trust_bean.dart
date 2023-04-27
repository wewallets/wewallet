class TrustBean {
  int code;
  String msg;
  List<TrustData> data;

  TrustBean({this.code, this.msg, this.data});

  TrustBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<TrustData>();
      json['data'].forEach((v) {
        data.add(new TrustData.fromJson(v));
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

class TrustData {
  String orderId;
  String tid;
  String symbol;
  String orderSide;
  String orderType;
  String orderPrice;
  String orderValue;
  String orderOrigTime;
  String orderSucValue;
  String account;
  String orderSucPrice;
  String orderStatus;
  String orderStatusStr;
  String direction;
  String takergetsCurrency;
  String takerpaysCurrency;
  String price;
  String amount;
  String priceSuc;
  String amountSuc;
  String unitPrice;
  String sucUnitPrice;
  String hash;

  TrustData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    symbol = json['symbol'];
    tid = json['tid'];
    orderSide = json['orderSide'];
    orderType = json['orderType'];
    orderStatus = json['order_status'];
    orderPrice = json['orderPrice'];
    orderValue = json['orderValue'];
//    orderOrigTime = json['orderOrigTime'];
    orderSucValue = json['orderSucValue'];
    account = json['account'];
    orderSucPrice = json['orderSucPrice'];
    direction = json['direction'];
    takergetsCurrency = json['takergets_currency'];
    takerpaysCurrency = json['takerpays_currency'];
    orderStatus = json['order_status'];
    orderStatusStr = json['order_status_str'];
    orderOrigTime = json['order_orig_time'];
    price = json['price'];
    amount = json['amount'];
    priceSuc = json['price_suc'];
    amountSuc = json['amount_suc'];
    unitPrice = json['unit_price'];
    sucUnitPrice = json['suc_unit_price'];
    hash = json['hash'];
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
    data['account'] = this.account;
    data['orderSucPrice'] = this.orderSucPrice;
    return data;
  }
}
