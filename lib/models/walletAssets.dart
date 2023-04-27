import 'package:json_annotation/json_annotation.dart';

part 'walletAssets.g.dart';

@JsonSerializable()
class WalletAssets {
  WalletAssets();

  String net_currency_name;
  String net_account;
  String value;
  String cny_value;
  String is_trust;
  String is_open_in;
  String is_open_out;
  String icon;
  String content;
  String min_out_number;
  String max_out_number;
  String service_charge;
  String order_value;
  String freeze;
  String currency;
  String tron_service_charge;
  String tron_content;
  String open_in;
  String tron_open_in;
  String open_out;
  String tron_open_out;
  String payment_fee_percent;
  String payment_fee;
  String open_payment;
  String payment_currency;
  String content_en;
  String tron_content_en;
  String use_value;
  List recharge_in_net_list;

  factory WalletAssets.fromJson(Map<String, dynamic> json) => _$WalletAssetsFromJson(json);

  Map<String, dynamic> toJson() => _$WalletAssetsToJson(this);
}
