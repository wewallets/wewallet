import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

class SignRESUtil {
  static var _encryptSign;

  static init() async {
    String privateKeyString = '-----BEGIN RSA PRIVATE KEY-----' +
        '\nMIIBOgIBAAJBAOGnbu1lSm3W5PJsrWzCffqme5iGtmaHs+3LKzuN/jEG0DERfrmL' +
        '\nUjWiStIl3cLw9xv8to9pdFHA7ga3ieqcb80CAwEAAQJBAKfFas4KHzpnKbWsY4yX' +
        '\nVj8DhKU0k2zLvFUyVyRiP/mGJ14yXWN5l7ksHfmTr3fmDdPdoLnLKBi44WStIYCO' +
        '\nRYECIQD9nTRny73KmjeEbWMbOQ/g8eHs4Uvy8rtQOT7HIo5WHQIhAOPG4/7N0plB' +
        '\njkZLnhfKQI0B5PbNq6z1OZOaGL1/apFxAiATv1zoRB4IG4/9GMNhyESrQEpWNojC' +
        '\nZxIcwghYWyF4JQIgVLr4tyFjdQUw4q9gaOMgrhOFU9XgRd+XAnQxPdS3FNECIDyL' +
        '\nDnnr3ZcYwblzfHtPJK8l6OaV3eP7WHWsgs+bnXWY' +
        '\n-----END RSA PRIVATE KEY-----';
    RSAPrivateKey privateKey = RSAKeyParser().parse(privateKeyString);

    // _encryptSign = Signer(RSASigner(RSASignDigest.SHA256, privateKey: privateKey));
  }

  //加密
  static String encryption(String data) {
   return _encryptSign.sign(data).base64;
  }

}
