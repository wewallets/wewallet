import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/utils/dateUtil.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/SignRESUtil.dart';
import 'base_model.dart';
import 'logsInterceptors.dart';

enum Method { get, post }

class Net {
  /// 工厂模式
  factory Net() => _getInstance();

  static Net get instance => _getInstance();
  static Net _instance;
  static PersistCookieJar cj;

  Dio dio;

  Net._internal() {
    // 初始化
    dio = Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      connectTimeout: 60000, // 连接服务器超时时间，单位是毫秒.
      receiveTimeout: 10000, // 响应流上前后两次接受到数据的间隔，单位为毫秒, 这并不是接收数据的总时限.
    ));

    dio.interceptors.add(new LogsInterceptors());
    _getCookieJar().then((v) {
      dio.interceptors.add(CookieManager(v));
    });

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.findProxy = (url) => 'DIRECT';
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    // };
  }

  deleteAll() {
    cj.deleteAll();
  }

  // 单列模式
  static Net _getInstance() {
    if (_instance == null) {
      _instance = Net._internal();
    }
    return _instance;
  }

  static Future<CookieJar> _getCookieJar() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    cj = new PersistCookieJar(storage: FileStorage(tempPath));
    return cj;
  }

  get(String url, Map<String, dynamic> params, {Function success, Function failure}) {
    _doRequest(url, params, Method.get, success, failure);
  }

  post(String url, Map<String, dynamic> params, {Function success, Function failure, other, isLogin = true, type}) {
    if (isLogin) params = initLogin(params);
    params = initLocale(params);
    params = initSign(params);
    _doRequest(url, params, Method.post, success, failure, other: other, type: type);
  }

  Map<String, dynamic> initLogin(Map<String, dynamic> params) {
    if (GlobalTransaction.isLogin) {
      if (params == null) params = Map();
      params['account'] = GlobalTransaction.walletInfo?.account_id ?? null;
      params['secret'] = RESUtil.encryption(GlobalTransaction.walletInfo.master_seed);
    }
    return params;
  }

  Map<String, dynamic> initLocale(Map<String, dynamic> params) {
    if (params == null) params = Map();
    if (SpUtil.getString('locale') != null) {
      params['_language'] = SpUtil.getString('locale');
    } else {
      params['_language'] = 'en';
    }
    return params;
  }

  Map<String, dynamic> initSign(Map<String, dynamic> params) {
    if (params == null) params = Map();
    Map<String, dynamic> newParams = Map();
    var st = new SplayTreeMap<String, dynamic>();
    var paramsStr = '';
    params['timestamp'] = DateUtil.getNowDateStr();
    newParams.addAll(params);
    newParams['devId'] = 'lj7elj234889Q';
    newParams = keySort(newParams);

    st.addAll(newParams);

    st.forEach((key, value) {
      paramsStr += '${key.toString()}=${value.toString()}&';
    });
    paramsStr = paramsStr.replaceRange(paramsStr.length - 1, paramsStr.length, '');

    params['sign'] = generateMD5(paramsStr);
    return params;
  }

  String generateMD5(String data) {
    Uint8List content = new Utf8Encoder().convert(data);
    Digest digest = md5.convert(content);
    return digest.toString();
  }

  uploading(String url, data, {Function success, Function failure}) {
    _doRequest(url, null, Method.post, success, failure, data: data);
  }

  void _doRequest(String url, Map<String, dynamic> params, Method method, Function successCallBack, Function failureCallBack, {data, other, type}) async {
    try {
      if (type == 1) showToast('开始发送请求');

      Response response;
      switch (method) {
        case Method.get:
          if (params != null && params.isNotEmpty) {
            response = await dio.get(url, queryParameters: params);
          } else {
            response = await dio.get(url);
          }
          break;
        case Method.post:
          if (data != null) {
            response = await dio.post(url, data: data);
          } else if (params != null && params.isNotEmpty) {
            response = await dio.post(url, data: FormData.fromMap(params));
          } else {
            response = await dio.post(url);
          }
          break;
      }
      if (type == 1) showToast('请求成功，开始实体化数据\n数据：${response.toString()}', gravity: ToastGravity.TOP);

      Map<String, dynamic> result = json.decode(response.toString());

      if (type == 1) showToast('实体化数据成功\n解析数据：${result.toString()}', gravity: ToastGravity.TOP);

      // 打印信息
      if (!url.contains('pull_order_market')) debugPrint('''api: $url\nparams: $params\nresult: $result''');
      // 转化为model
      BaseModel model = BaseModel.fromJson(result);
      if (model.code == 0) {
        // 200 请求成功
        if (successCallBack != null && other != null) {
          successCallBack(model.data, other);
        } else if (successCallBack != null) {
          //返回请求数据
          successCallBack(model.data);
        }
      } else {
        //TODO 处理失败情况
        //直接使用Toast弹出错误信息
        //返回失败信息
        if (failureCallBack != null) {
          // if (model.code == 50000008 || model.code == 20010) {
          //   if (Global.isLogin)
          //     Net().post(Api.RIPPLE_LOGIN, {'address': Global.walletInfo.account_id, 'secret': Global.walletInfo.master_seed}, success: (data) {
          //       Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '操作失败，请重试');
          //       Global.saveToken(data['token']);
          //     });
          // }
          failureCallBack('code:${model.code}msg:${model.msg}');
        }
      }
    } catch (exception) {
      failureCallBack('接口请求失败\n${exception.toString()}', gravity: ToastGravity.BOTTOM);

      debugPrint('错误：${exception.toString()}');
      if (failureCallBack != null) {
        failureCallBack('请求失败');
      }
    }
  }
}
