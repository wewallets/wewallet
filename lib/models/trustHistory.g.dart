// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trustHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrustHistory _$TrustHistoryFromJson(Map<String, dynamic> json) {
  return TrustHistory()
    ..id = json['id'] as String
    ..symbol = json['symbol'] as String
    ..tradeId = json['tradeId'] as String
    ..amount = json['amount'] as String
    ..price = json['price'] as String
    ..ts = json['ts'] as String
    ..direction = json['direction'] as String
    ..market1 = json['market1'] as String
    ..market2 = json['market2'] as String
    ..address1 = json['address1'] as String
    ..address2 = json['address2'] as String
    ..fee1 = json['fee1'] as String
    ..fee2 = json['fee2'] as String
    ..unit_price = json['unit_price'] as String
    ..prev_amount = json['prev_amount'] as String
    ..prev_price = json['prev_price'] as String
    ..amount_sum = json['amount_sum'] as String
    ..price_sum = json['price_sum'] as String
    ..prev_amount_sum = json['prev_amount_sum'] as String
    ..prev_price_sum = json['prev_price_sum'] as String
    ..prev_unit_price = json['prev_unit_price'] as String
    ..total_amount = json['total_amount'] as String
    ..order_status = json['order_status'] as String;
}

Map<String, dynamic> _$TrustHistoryToJson(TrustHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'tradeId': instance.tradeId,
      'amount': instance.amount,
      'price': instance.price,
      'ts': instance.ts,
      'direction': instance.direction,
      'market1': instance.market1,
      'market2': instance.market2,
      'address1': instance.address1,
      'address2': instance.address2,
      'fee1': instance.fee1,
      'fee2': instance.fee2,
      'unit_price': instance.unit_price,
      'prev_amount': instance.prev_amount,
      'prev_price': instance.prev_price,
      'amount_sum': instance.amount_sum,
      'price_sum': instance.price_sum,
      'prev_amount_sum': instance.prev_amount_sum,
      'prev_price_sum': instance.prev_price_sum,
      'prev_unit_price': instance.prev_unit_price,
      'total_amount': instance.total_amount,
      'order_status': instance.order_status
    };
