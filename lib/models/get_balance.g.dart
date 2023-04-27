// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Get_balance _$Get_balanceFromJson(Map<String, dynamic> json) {
  return Get_balance()
    ..currency = json['currency'] as String
    ..balance = json['balance'] as String
    ..order_value = json['order_value'] as String
    ..offer_value = json['offer_value'] as String;
}

Map<String, dynamic> _$Get_balanceToJson(Get_balance instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'balance': instance.balance,
      'order_value': instance.order_value,
      'offer_value': instance.offer_value
    };
