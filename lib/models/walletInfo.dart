import 'package:json_annotation/json_annotation.dart';

part 'walletInfo.g.dart';

@JsonSerializable()
class WalletInfo {
    WalletInfo();

    String account_id;
    String master_key;
    String wallet_name;
    String master_seed;
    String is_activation;
    String wallet_password;
    String balance;
    String balanceTh;

    factory WalletInfo.fromJson(Map<String,dynamic> json) => _$WalletInfoFromJson(json);
    Map<String, dynamic> toJson() => _$WalletInfoToJson(this);
}
