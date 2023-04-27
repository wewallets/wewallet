class DepthEntity {
  double price;
  double vol;
  double fullSize;
  double sucSize;

  DepthEntity.fromJson(Map<String, dynamic> json) {
    price = double.parse(json['price'].toString());
    vol = double.parse(json['size'].toString());
    fullSize = double.parse(json['full_size'].toString());
    sucSize = double.parse(json['suc_size'].toString());
  }

  @override
  String toString() {
    return 'Data{price: $price, vol: $vol}';
  }
}
