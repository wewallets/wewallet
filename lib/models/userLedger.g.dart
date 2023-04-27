// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userLedger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLedger _$UserLedgerFromJson(Map<String, dynamic> json) {
  return UserLedger()
    ..id = json['id'] as String
    ..account = json['account'] as String
    ..transaction_type = json['transaction_type'] as String
    ..ledger_index = json['ledger_index'] as String
    ..hash = json['hash'] as String
    ..fee = json['fee'] as String
    ..status = json['status'] as String
    ..validated = json['validated'] as String
    ..ripple_date = json['ripple_date'] as String
    ..tx_time = json['tx_time'] as String
    ..destination = json['destination'] as String
    ..currency = json['currency'] as String
    ..amount = json['amount'] as String
    ..balance = json['balance'] as String
    ..destination_balance = json['destination_balance'] as String
    ..description = json['description'] as String
    ..icon = json['icon'] as String
    ..is_detail = json['is_detail'] as String
    ..type = json['type'] as String
    ..reward_type_str = json['reward_type_str'] as String
    ..state_str = json['state_str'] as String;
}

Map<String, dynamic> _$UserLedgerToJson(UserLedger instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'transaction_type': instance.transaction_type,
      'ledger_index': instance.ledger_index,
      'hash': instance.hash,
      'fee': instance.fee,
      'status': instance.status,
      'validated': instance.validated,
      'ripple_date': instance.ripple_date,
      'tx_time': instance.tx_time,
      'destination': instance.destination,
      'currency': instance.currency,
      'amount': instance.amount,
      'balance': instance.balance,
      'destination_balance': instance.destination_balance,
      'description': instance.description,
      'icon': instance.icon,
      'is_detail': instance.is_detail,
      'state_str': instance.state_str
    };
