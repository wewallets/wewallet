class WalletAddressLog {
  WalletAddressLog({
      this.from, 
      this.to, 
      this.amount, 
      this.currency, 
      this.time, 
      this.hash, 
      this.status,});

  WalletAddressLog.fromJson(dynamic json) {
    from = json['from'];
    to = json['to'];
    amount = json['amount'];
    currency = json['currency'];
    time = json['time'];
    hash = json['hash'];
    status = json['status'];
  }
  String from;
  String to;
  String amount;
  String currency;
  String time;
  String hash;
  String status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = from;
    map['to'] = to;
    map['amount'] = amount;
    map['currency'] = currency;
    map['time'] = time;
    map['hash'] = hash;
    map['status'] = status;
    return map;
  }

}