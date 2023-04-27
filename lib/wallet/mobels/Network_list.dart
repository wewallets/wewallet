class NetworkList {
  NetworkList({
      this.name, 
      this.icon,});

  NetworkList.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
  }
  String name;
  String icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['icon'] = icon;
    return map;
  }

}