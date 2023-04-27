import 'package:dio/dio.dart';

class CacheObject {
  Response response;
  int timeStamp;

  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  int get hashCode => response.realUri.hashCode;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }
}
