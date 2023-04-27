import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import '../../../common/utils/RESUtil.dart';
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
      contentType: Headers.formUrlEncodedContentType,
      connectTimeout: 20000, // 连接服务器超时时间，单位是毫秒.
      receiveTimeout: 10000, // 响应流上前后两次接受到数据的间隔，单位为毫秒, 这并不是接收数据的总时限.
    ));

    dio.interceptors.add(new LogsInterceptors());
    _getCookieJar().then((v) {
      dio.interceptors.add(CookieManager(v));
    });

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (url) => 'DIRECT';
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
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

  dynamic get(String url, Map<String, dynamic> params, {Function success, Function failure, isNo = false}) {
    return _doRequest(url, params, Method.get, success, failure, isNo: true);
  }

  dynamic post(String url, Map<String, dynamic> params, {Function success, Function failure, other, isLogin = true}) {
    // params = initLocale(params);
    if (isLogin) params = initLogin(params);

    return _doRequest(url, params, Method.post, success, failure, other: other);
  }

  uploading(String url, data, {Function success, Function failure}) {
    _doRequest(url, null, Method.post, success, failure, data: data);
  }

  Map<String, dynamic> initLogin(Map<String, dynamic> params, {isNetwork = true}) {
    if (params == null) params = Map();

    if (Global.isLogin) {
      if (isNetwork) params['network'] = Global.userWallet.network;
      params['address'] = Global.userWallet.wallet.address ?? null;
      params['account'] = Global.userWallet.wallet.address ?? null;

      if (Global.userWallet.network == 'YISE') {
        params['secret'] = RESUtil.encryption(Global.userWallet.wallet.privateKey);
      } else {
        params['secret'] = Global.userWallet.wallet.privateKey;
      }
    }

    return params;
  }

  toJsonData(Map<String, dynamic> params) {
    if (params == null || params.length == 0) return null;
    params['sign'] = hMacSHA1(params);
    return params;
  }

  Map<String, dynamic> initLocale(Map<String, dynamic> params) {
    if (params == null) params = Map();
    if (SpWalletUtil.getString('locale') != null) {
      params['_language'] = SpWalletUtil.getString('locale');
    } else {
      params['_language'] = 'en';
    }
    return params;
  }

  hMacSHA1(Map<String, dynamic> params) {
    var st = new SplayTreeMap<String, dynamic>();
    st.addAll(params);

    String paramsStr = '';

    st.forEach((key, value) {
      paramsStr += '${key.toString()}=${value.toString()}&';
    });
    paramsStr = paramsStr.replaceRange(paramsStr.length - 1, paramsStr.length, '');
    List<int> policy = utf8.encode(paramsStr);
    return Hmac(sha1, utf8.encode(Global.encryptionSHA1)).convert(policy).toString();
  }

  BaseModel resolveToBaseModel(Response<dynamic> res) {
    Map<String, dynamic> resJson = json.decode(res.toString());
    BaseModel _res = BaseModel.fromJson(resJson);
    return _res;
  }

  dynamic _doRequest(String url, Map<String, dynamic> params, Method method, Function successCallBack, Function failureCallBack, {data, other, isNo = false}) async {
    try {
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
            dio.options.contentType = 'multipart/form-data';
            response = await dio.post(url, data: data);
          } else if (params != null && params.isNotEmpty) {
            response = await dio.post(url, data: FormData.fromMap(params));
          } else {
            response = await dio.post(url);
          }
          break;
      }
      if (isNo == true) {
        successCallBack(response.toString());
        return;
      }
      Map<String, dynamic> result = json.decode(response.toString());

      // 打印信息
      print('header: ${dio.options.headers.toString()}');
      debugPrint('''Net print -- api: $url\nNet print -- params: $params\nNet print -- result: $result''');
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

        if (model.code == 50000008 || model.code == 20010) {
          SpWalletUtil.putBool('isLogin', false);
          SpWalletUtil.remove('assetsList');
          showToast('Your login has expired, please log in again');
          deleteAll();
          // Future.delayed(Duration(milliseconds: 0), () => navigatorContextPush(Global.getContext, PageRouter.login_Page));
        }
        if (failureCallBack != null) {
          failureCallBack(model.msg);
        }
      }

      return response;
    } catch (exception) {
      debugPrint('mistake:${exception.toString()}');
      if (failureCallBack != null) {
        failureCallBack('Request failed');
      }
    }
  }
}
