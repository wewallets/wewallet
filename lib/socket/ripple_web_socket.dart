import 'dart:convert';

import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/common/event_bus.dart';
import 'package:mars/common/http/api.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class RippleWebSocket {
  factory RippleWebSocket() => _getInstance();

  static RippleWebSocket get instance => _getInstance();

  static RippleWebSocket _instance;

  static RippleWebSocket _getInstance() {
    if (_instance == null) {
      _instance = RippleWebSocket._internal();
    }
    return _instance;
  }

  RippleWebSocket._internal() {
    connect();
  }

  static IOWebSocketChannel _webSocket;
  static EventCallback eventCallback;
  static bool isEventCallback = true;

  static void on(EventCallback event) {
    isEventCallback = true;
    eventCallback = event;
  }

  static void off() {
    isEventCallback = false;
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

  //创建钱包
  walletPropose() {
    sinkSend('{"id":"wallet_propose","command": "wallet_propose"}');
  }

  //导入钱包
  walletImport(seed) {
    sinkSend('{"id":"wallet_import","command": "wallet_propose","seed":"$seed"}');
  }

  //获取密钥
  validationCreate(secret) {
    sinkSend('{ "id": "validation_create", "command": "validation_create", "secret": "$secret"}');
  }

  //激活
  activation({secret, destination, account}) {
    sign('activation', '{"TransactionType" : "Payment","Account" : "$account","Destination" : "$destination","Fee": "1000","Amount" : 5000}', secret, isConnect: false);
  }

  //转账
  transferAccounts({secret, destination, account, amount, isConnect = false}) {
    sign('transferAccounts', '{"TransactionType" : "Payment","Account" : "$account","Fee": "1000","Destination" : "$destination","Amount" : "${(double.parse(amount) * 1000000).toInt()}"}', secret, isConnect: isConnect);
  }

  //提现
  withdrawCoin({secret, destination, account, currency, value, issuer}) {
    sign('withdrawCoin', '{"TransactionType" : "Payment","Account" : "$account","Fee": "1000","Destination" : "$destination","Amount" : {"currency" : "${LayoutUtil.getCoin(currency)}","value" : "$value","issuer" : "$issuer"}}', secret, isConnect: true);
  }

  //签名
  sign(id, txJson, secret, {isConnect = true}) {
    sinkSend('{"id": "$id","command": "sign","tx_json" : $txJson,"secret" : "$secret"}', isConnect: isConnect);
  }

  //加密提交数据
  submit({id, txBlob}) {
    sinkSend('{"id": "$id","command": "submit","tx_blob": "$txBlob"}', isConnect: false);
  }

  //查看用户信息(只有已激活用户可以获取到)
  accountInfo(account, {id, isConnect}) {
    sinkSend('{ "id": "${id ?? "account_info"}", "command": "account_info", "account": "$account" }', isConnect: isConnect);
  }

  //添加信任和取消信任
  trustSet({secret, issuer, currency, account, isTrust, sequence}) {
    sign('trustSet', '{"TransactionType": "TrustSet","Account": "$account","Fee": "1000","Flags": "131072","LimitAmount": {"currency": "${LayoutUtil.getCoin(currency)}","issuer": "$issuer","value": "${isTrust ? 9999999999 : 0}"},"Sequence":$sequence}', secret, isConnect: false);
  }

  //创建卖出挂单
  offerCreateSellOut({secret, account, takerGets, sequence, issuer, value, currency, takerCurrency, takerIssuer, takerValue}) {
    sign(
        'offerCreate',
        '{"TransactionType":"OfferCreate", "Account":"$account", "Fee":"1000",'
            ' "TakerGets":${takerGets == null ? '{"currency":"$takerCurrency", "issuer":"$takerIssuer", "value":"$takerValue"}' : "$takerGets"}, '
            '"TakerPays":{"currency":"${LayoutUtil.getCoin(currency)}", "issuer":"$issuer", "value":"$value"}, "Sequence":$sequence}',
        secret,
        isConnect: false);
  }

  //创建买入挂单
  offerCreatePurchase({secret, account, issuer, value, currency, takerPays, sequence, takerCurrency, takerIssuer, takerValue}) {
    sign(
        'offerCreate',
        '{"TransactionType":"OfferCreate", "Account":"$account", "Fee":"1000", "TakerGets":{"currency":"${LayoutUtil.getCoin(currency)}", "issuer":"$issuer", "value":"$value"}, "TakerPays":${takerPays == null ? '{"currency":"$takerCurrency","issuer":"$takerIssuer", "value":"$takerValue"}' : "$takerPays"}, "Sequence":$sequence}',
        secret,
        isConnect: false);
  }

  //取消挂单
  offerCancel({secret, account, offerSequence, sequence}) {
    sign('offerCancel', '{"TransactionType": "OfferCancel","Account": "$account","Fee": "1000","OfferSequence": "$offerSequence","Sequence": "$sequence"}', secret, isConnect: false);
  }

  //查询OfferSequence
  getOfferSequence({transaction}) {
    sinkSend('{"id": "getOfferSequence","command": "tx","transaction": "$transaction","binary": false}');
  }

  //查询账单记录
  getRecord({transaction}) {
    sinkSend('{"id": "getRecord","command": "tx","transaction": "$transaction","binary": false}');
  }
}
