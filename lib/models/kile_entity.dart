import 'package:mars/generated/json/base/json_convert_content.dart';
import 'package:mars/generated/json/base/json_field.dart';

class KileEntity with JsonConvert<KileEntity> {
	String amount;
	String open;
	String close;
	String high;
	String count;
	String low;
	String vol;
	String symbol;
	@JSONField(name: "kline_type")
	String klineType;
	@JSONField(name: "currency_name")
	String currencyName;
	String id;
}
