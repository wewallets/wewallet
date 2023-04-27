// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletPropose.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletPropose _$WalletProposeFromJson(Map<String, dynamic> json) {
  return WalletPropose()
    ..account_id = json['account_id'] as String
    ..key_type = json['key_type'] as String
    ..master_key = json['master_key'] as String
    ..master_seed = json['master_seed'] as String
    ..master_seed_hex = json['master_seed_hex'] as String
    ..public_key = json['public_key'] as String
    ..public_key_hex = json['public_key_hex'] as String
    ..validation_key = json['validation_key'] as String
    ..validation_seed = json['validation_seed'] as String
    ..tx_blob = json['tx_blob'] as String
    ..balance = json['balance'] as String;
}

Map<String, dynamic> _$WalletProposeToJson(WalletPropose instance) =>
    <String, dynamic>{
      'account_id': instance.account_id,
      'key_type': instance.key_type,
      'master_key': instance.master_key,
      'master_seed': instance.master_seed,
      'master_seed_hex': instance.master_seed_hex,
      'public_key': instance.public_key,
      'public_key_hex': instance.public_key_hex,
      'validation_key': instance.validation_key,
      'validation_seed': instance.validation_seed,
      'tx_blob': instance.tx_blob,
      'balance': instance.balance
    };
