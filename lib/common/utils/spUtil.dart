import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SpUtil {
  static SpUtil _instance;

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  static SharedPreferences _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      _instance = new SpUtil._();
      await _instance._init();
    }
    return _instance;
  }

  static Future<SpUtil> init() async {
    _instance = new SpUtil._();
    await _instance._init();
    return _instance;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  // 判断是否存在数据
  static bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  static Set<String> getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  static getString(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  static getStringKey(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  static Future<bool> putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf.setString(key, value);
  }

  static bool getBool(String key) {
    if (_beforeCheck()) return false;
    return _spf.getBool(key);
  }

  static Future<bool> putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf.setBool(key, value);
  }

  static int getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf.getInt(key);
  }

  static Future<bool> putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf.setInt(key, value);
  }

  static double getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf.getDouble(key);
  }

  static Future<bool> putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf.setDouble(key, value);
  }

  static List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  static Future<bool> putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  static Future<bool> remove(String key) {
    if (_beforeCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforeCheck()) return null;
    return _spf.clear();
  }

  static Future<bool> putObject(String key, Object value) {
    if (_spf == null) return null;
    return _spf.setString(key, value == null ? "" : json.encode(value));
  }

  static T getObj<T>(String key, T f(Map v), {T defValue}) {
    Map map = getObject(key);
    return map == null ? defValue : f(map);
  }

  static Map getObject(String key) {
    if (_spf == null) return null;
    String _data = _spf.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  static Future<bool> putObjectList(String key, List<Object> list) {
    if (_spf == null) return null;
    List<String> _dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return _spf.setStringList(key, _dataList);
  }

  static List<T> getObjList<T>(String key, T f(Map v), {List<T> defValue = const []}) {
    List<Map> dataList = getObjectList(key);
    List<T> list = dataList?.map((value) {
      return f(value);
    })?.toList();
    return list ?? defValue;
  }

  static List<Map> getObjectList(String key) {
    if (_spf == null) return null;
    List<String> dataLis = _spf.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }
}
