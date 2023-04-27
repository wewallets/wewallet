import 'package:dio/dio.dart';

class LogsInterceptors extends InterceptorsWrapper {

  static String session = '';

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    print("请求baseUrl：${options.baseUrl}");
    print("请求url：${options.path}");
    print('请求头: ' + options.headers.toString());
    if (options.data != null) {
      print('请求参数: ' + options.data.toString());
    }
    options.headers={"Cookie":session};
    print('请求头:'+options.headers.toString());
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err,ErrorInterceptorHandler handler) async{
    print('请求异常: ' + err.toString());
    print('请求异常信息: ' + err?.toString() ?? "");
    return super.onError(err, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async{
    if (response != null) {
      if(response.headers['set-cookie']!=null){
        session = response.headers['set-cookie'][0].toString().split(";")[0];
        print('返回接口session内容: ' + session);
      }
      print('返回接口内容: ' + response.headers.toString());
    }

    return super.onResponse(response, handler);
  }
}
