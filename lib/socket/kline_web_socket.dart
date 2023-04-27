import 'dart:async';
import 'dart:convert';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/event_bus.dart';
import 'package:mars/common/http/api.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class KlineWebSocket {
  factory KlineWebSocket() => _getInstance();

  static KlineWebSocket get instance => _getInstance();

  static KlineWebSocket _instance;

  static KlineWebSocket _getInstance() {
    if (_instance == null) {
      _instance = KlineWebSocket._internal();
    }
    return _instance;
  }

  KlineWebSocket._internal() {
    connect();
    if (newsTimer == null) timeNews();
  }

  static IOWebSocketChannel _webSocket;
  static EventCallback eventCallback;
  static bool isEventCallback = true;
  static Timer newsTimer;

  static void on(EventCallback event) {
    isEventCallback = true;
    eventCallback = event;
  }

  static void off() {
    isEventCallback = false;
  }

  timeNews() async {
    newsTimer = Timer.periodic(Duration(milliseconds: 5000), (timer) {
      if (isEventCallback) connect();
    });
  }

  //开启连接
  connect() {
    try {
      _webSocket = IOWebSocketChannel.connect(ApiTransaction.KLINE_SERVICE);
      _webSocket.stream.listen((data) {
        Map<String, dynamic> result = json.decode(data.toString());
        if (eventCallback != null && isEventCallback == true) eventCallback(arg: result);
      });
    } catch (e) {}
  }

  //关闭连接
  closeWebSocket() {
    _webSocket.sink.close(status.goingAway);
  }

  //开始发送
  sinkSend(json, {bool isConnect = true}) {
    if (isConnect == null || isConnect == true) connect();

    _webSocket.sink.add(json);
  }
}
