import 'package:mars/wallet/common/component_index.dart';

import '../../../common/utils/num_util.dart';
import '../entity/k_entity.dart';

class KLineEntity extends KEntity {
  double open;
  double high;
  double low;
  double close;
  double vol;
  double amount;
  double change;
  double ratio;
  int time;
  String id;
  String kline_type;
  String currency_name;
  String symbol;
  String rice_fall;
  String rice;
  String amplitude;
  double percent;

  KLineEntity.fromJson(Map<String, dynamic> json) {
    try {
      open = double.parse(json['open'] ?? '0.0');
      high = double.parse(json['high'] ?? '0.0');
      symbol = json['kline_type'] ?? '0.0';
      currency_name = json['currency_name'] ?? '0.0';
      kline_type = json['kline_type'] ?? '0.0';
      low = double.parse(json['low'] ?? '0.0');
      close = double.parse(json['close'] ?? '0.0');
      vol = double.parse(json['vol'] ?? '0.0');
      amount = double.parse(json['amount'] ?? '0.0');
      ratio = double.parse(json['ratio'] ?? '0.0');
      change = NumUtil.formatNum(double.parse(json['change'] ?? '0.0').toString(), 2);
      amplitude = json['amplitude'] ?? '0.0';
      percent = NumUtil.formatNum((double.parse(json['percent'] ?? '0.0') * 100).toString(), 2);
      id = json['id'] ?? '0';
      rice_fall = json['rice_fall'] ?? '0.0';
      rice = json['rice'] ?? '0.0';

      //兼容火币数据
      if (time == null) {
        time = int.parse(json['id'] ?? '0');
        if (time != null) {
          time *= 1000;
        }
      }
    } catch (e) {
      showToast('类型转货错误');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['open'] = this.open;
    data['close'] = this.close;
    data['high'] = this.high;
    data['low'] = this.low;
    data['vol'] = this.vol;
    data['amount'] = this.amount;
    data['ratio'] = this.ratio;
    data['change'] = this.change;
    return data;
  }

  @override
  String toString() {
    return 'MarketModel{open: $open, high: $high, low: $low, close: $close, vol: $vol, time: $time, amount: $amount, ratio: $ratio, change: $change}';
  }
}
