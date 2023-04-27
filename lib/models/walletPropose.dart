import 'package:json_annotation/json_annotation.dart';

part 'walletPropose.g.dart';

@JsonSerializable()
class WalletPropose {
    WalletPropose();

    String account_id;
    String key_type;
    String master_key;
    String master_seed;
    String master_seed_hex;
    String public_key;
    String public_key_hex;
    String validation_key;
    String validation_seed;
    String tx_blob;
    String balance;
    
    factory WalletPropose.fromJson(Map<String,dynamic> json) => _$WalletProposeFromJson(json);
    Map<String, dynamic> toJson() => _$WalletProposeToJson(this);
}
