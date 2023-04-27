import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RESUtil {
  static var _encrypt;

  static init() async {
    String publicKeyString = await rootBundle.loadString('assets/rsa_pub_app.pem');
    RSAPublicKey publicKey = RSAKeyParser().parse(publicKeyString);
    String privateKeyString = await rootBundle.loadString('assets/rsa_prv.pem');
    RSAPrivateKey privateKey = RSAKeyParser().parse(privateKeyString);

    _encrypt = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey, encoding: RSAEncoding.OAEP));
  }

  //加密
  static String encryption(String data) {
    return _encrypt.encrypt(data).base64.toString();
  }

  //解密
  static String decrypt(String data) {
    return _encrypt.decrypt64(data);
  }
}
