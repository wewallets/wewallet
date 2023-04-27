import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'base_dialog.dart';

//行情
class QuotationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      widget: Container(
        color: Colours.transparent,
        child: Row(
          children: <Widget>[
            Container(width: ScreenUtil().setWidth(550), color: Colours.white),
          ],
        ),
      ),
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      cornerRadius: 0.0,
      entryAnimation: EntryAnimation.LEFT,
    );
  }
  // static Future<String> encrypt(String text) async {
  //   String publicKeyString = await rootBundle.loadString('keys/public_key.pem');
  //   RSAPublicKey publicKey = RSAKeyParser().parse(publicKeyString);
  //   //创建加密器
  //   final encrypter = Encrypter(RSA(publicKey: publicKey));
  //   return encrypter.encrypt(text).base64;
  // }
}
