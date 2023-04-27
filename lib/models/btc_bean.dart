class BTCBean {
  String tradName;
  String baseName;
  String price;
  String riceFall;

  BTCBean({
    this.tradName,
    this.baseName,
    this.price,
    this.riceFall
  });

  BTCBean.fromJson(Map<String, dynamic> json) {
    tradName = json['trad_currency_name'];
    baseName = json['base_currency_name'];
    price = json['unit_price'];
    riceFall = json['rice_fall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trad_currency_name'] = this.tradName;
    data['base_currency_name'] = this.baseName;
    data['unit_price'] = this.price;
    data['rice_fall'] = this.riceFall;
    return data;
  }
}
