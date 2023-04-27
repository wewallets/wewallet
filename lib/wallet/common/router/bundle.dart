class Bundle {
  Map<String, dynamic> _map = {};

  _setValue(var k, var v) => _map[k] = v;

  _getValue(String k) {
    if (!_map.containsKey(k)) {
      return null;
    }
    return _map[k];
  }

  isContainsKey(String k) {
    if (!_map.containsKey(k)) {
      return false;
    } else {
      return true;
    }
  }

  putInt(String k, int v) => _map[k] = v;

  putString(String k, String v) => _setValue(k, v);

  putBool(String k, bool v) => _setValue(k, v);

  putObject(String k, var v) => _setValue(k, v);

  putList<V>(String k, List<V> v) => _setValue(k, v);

  putMap<K, V>(String k, Map<K, V> v) => _setValue(k, v);

  int getInt(String k) => _getValue(k) as int;

  String getString(String k) => _getValue(k) as String;

  bool getBool(String k) => _getValue(k) as bool;

  List<V> getList<V>(String k) => _getValue(k) as List<V>;

  dynamic getObject(String k) => _getValue(k) as dynamic;

  Map<K, V> getMap<K, V>(String k) => _getValue(k) as Map<K, V>;

  @override
  String toString() {
    return _map.toString();
  }
}
