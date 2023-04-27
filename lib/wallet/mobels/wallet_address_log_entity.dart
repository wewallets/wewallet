import 'package:mars/generated/json/base/json_convert_content.dart';

class WalletAddressLogEntity with JsonConvert<WalletAddressLogEntity> {
	String from;
	String to;
	String amount;
	String currency;
	String time;
	String hash;
	String status;
}
