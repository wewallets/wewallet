// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketList _$MarketListFromJson(Map<String, dynamic> json) {
  return MarketList()
    ..trad_currency_name = json['trad_currency_name'] as String
    ..base_currency_name = json['base_currency_name'] as String
    ..symbol = json['symbol'] as String
    ..amount = json['amount'] as String
    ..count = json['count'] as String
    ..open = json['open'] as String
    ..low = json['low'] as String
    ..high = json['high'] as String
    ..vol = json['vol'] as String
    ..bid = json['bid'] as String
    ..bidSize = json['bidSize'] as String
    ..ask = json['ask'] as String
    ..askSize = json['askSize'] as String
    ..close = json['close'] as String
    ..rice_fall = json['rice_fall'] as String
    ..is_new = json['is_new'] as String
    ..cny_value = json['cny_value'] as String
    ..unit_price = json['unit_price'] as String;
}

Map<String, dynamic> _$MarketListToJson(MarketList instance) =>
    <String, dynamic>{
      'trad_currency_name': instance.trad_currency_name,
      'base_currency_name': instance.base_currency_name,
      'symbol': instance.symbol,
      'amount': instance.amount,
      'count': instance.count,
      'open': instance.open,
      'low': instance.low,
      'high': instance.high,
      'vol': instance.vol,
      'bid': instance.bid,
      'bidSize': instance.bidSize,
      'ask': instance.ask,
      'askSize': instance.askSize,
      'close': instance.close,
      'rice_fall': instance.rice_fall,
      'is_new': instance.is_new,
      'cny_value': instance.cny_value,
      'unit_price': instance.unit_price
    };
