import 'package:mars/wallet/generated/json/base/json_convert_content.dart';

class WalletEntity with JsonConvert<WalletEntity> {
	String name;
	String password;
	String network;
	WalletWallet wallet;
}

class WalletWallet with JsonConvert<WalletWallet> {
	String address;
	String privateKey;
	String propose;
}
