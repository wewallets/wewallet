// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profit _$ProfitFromJson(Map<String, dynamic> json) {
  return Profit()
    ..yesterday_profit = json['yesterday_profit'] as String
    ..yesterday_profit_cny = json['yesterday_profit_cny'] as String
    ..balance = json['balance'] as String
    ..balance_mpool = json['balance_mpool'] as String
    ..total_award = json['total_award'] as String
    ..all_profit = json['all_profit'] as String;
}

Map<String, dynamic> _$ProfitToJson(Profit instance) => <String, dynamic>{'yesterday_profit': instance.yesterday_profit, 'yesterday_profit_cny': instance.yesterday_profit_cny, 'balance': instance.balance, 'balance_mpool': instance.balance_mpool, 'all_profit': instance.all_profit};
