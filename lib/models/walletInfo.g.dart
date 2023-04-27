// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletInfo _$WalletInfoFromJson(Map<String, dynamic> json) {
  return WalletInfo()
    ..account_id = json['account_id'] as String
    ..master_key = json['master_key'] as String
    ..wallet_name = json['wallet_name'] as String
    ..master_seed = json['master_seed'] as String
    ..is_activation = json['is_activation'] as String
    ..wallet_password = json['wallet_password'] as String
    ..balanceTh = json['balanceTh'] as String
    ..balance = json['balance'] as String;
}

Map<String, dynamic> _$WalletInfoToJson(WalletInfo instance) =>
    <String, dynamic>{
      'account_id': instance.account_id,
      'master_key': instance.master_key,
      'wallet_name': instance.wallet_name,
      'master_seed': instance.master_seed,
      'is_activation': instance.is_activation,
      'wallet_password': instance.wallet_password,
      'balanceTh': instance.balanceTh,
      'balance': instance.balance
    };
