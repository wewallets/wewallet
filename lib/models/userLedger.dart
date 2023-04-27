import 'package:json_annotation/json_annotation.dart';

part 'userLedger.g.dart';

@JsonSerializable()
class UserLedger {
  UserLedger();

  String id;
  String account;
  String transaction_type;
  String ledger_index;
  String hash;
  String fee;
  String status;
  String validated;
  String ripple_date;
  String tx_time;
  String destination;
  String currency;
  String amount;
  String balance;
  String destination_balance;
  String description;
  String icon;
  String is_detail;
  String state_str;
  String type;
  String reward_type_str;

  factory UserLedger.fromJson(Map<String, dynamic> json) => _$UserLedgerFromJson(json);

  Map<String, dynamic> toJson() => _$UserLedgerToJson(this);
}
