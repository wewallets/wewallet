// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletAssets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletAssets _$WalletAssetsFromJson(Map<String, dynamic> json) {
  return WalletAssets()
    ..net_currency_name = json['net_currency_name'] as String
    ..net_account = json['net_account'] as String
    ..value = json['value'] as String
    ..cny_value = json['usd_value'] as String
    ..is_trust = json['is_trust'] as String
    ..is_open_in = json['is_open_in'] as String
    ..is_open_out = json['is_open_out'] as String
    ..icon = json['icon'] as String
    ..content = json['content'] as String
    ..min_out_number = json['min_out_number'] as String
    ..max_out_number = json['max_out_number'] as String
    ..service_charge = json['service_charge'] as String
    ..order_value = json['order_value'] as String
    ..freeze = json['freeze'] as String
    ..tron_service_charge = json['tron_service_charge'] as String
    ..tron_content = json['tron_content'] as String
    ..open_in = json['open_in'] as String
    ..tron_open_in = json['tron_open_in'] as String
    ..open_out = json['open_out'] as String
    ..tron_open_out = json['tron_open_out'] as String
    ..payment_fee_percent = json['payment_fee_percent'] as String
    ..payment_fee = json['payment_fee'] as String
    ..payment_currency = json['payment_currency'] as String
    ..open_payment = json['open_payment'] as String
    ..content_en = json['content_en'] as String
    ..tron_content_en = json['tron_content_en'] as String
    ..use_value = json['use_value'] as String
    ..recharge_in_net_list = json['recharge_in_net_list'] as List
    ..currency = json['currency'] as String;
}

Map<String, dynamic> _$WalletAssetsToJson(WalletAssets instance) => <String, dynamic>{
      'net_currency_name': instance.net_currency_name,
      'net_account': instance.net_account,
      'value': instance.value,
      'usd_value': instance.cny_value,
      'is_trust': instance.is_trust,
      'is_open_in_out': instance.is_open_in,
      'is_open_out': instance.is_open_out,
      'icon': instance.icon,
      'content': instance.content,
      'min_out_number': instance.min_out_number,
      'max_out_number': instance.max_out_number,
      'service_charge': instance.service_charge,
      'order_value': instance.order_value,
      'freeze': instance.freeze,
      'open_in': instance.open_in,
      'tron_open_in': instance.tron_open_in,
      'open_out': instance.open_out,
      'tron_open_out': instance.tron_open_out,
      'use_value': instance.use_value,
      'payment_fee_percent': instance.payment_fee_percent,
      'payment_fee': instance.payment_fee,
      'payment_currency': instance.payment_currency,
      'open_payment': instance.open_payment,
      'content_en': instance.content_en,
      'tron_content_en': instance.tron_content_en,
      'recharge_in_net_list': instance.recharge_in_net_list,
      'currency': instance.currency
    };
