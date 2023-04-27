class BaseModel {
  int code;
  dynamic data;
  String msg;


  BaseModel({this.code, this.data, this.msg});

  BaseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    msg = json['msg'];
  }
}
