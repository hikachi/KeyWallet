import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart';
import 'package:key_wallet/shared/repositories/const.dart';

main(){
  print(HashFunctions().getRandomPepper());
}
class HashFunctions {
  String calcSHA512(String password,String pepper, String salt) {
    String pass = pepper+salt+password;
    var bytes = utf8.encode(pass);
    var digest = crypto.sha512.convert(bytes);
    return '$digest';
  }
  String calcMD5(String text){
    var bytes = utf8.encode(text);
    var  digest = crypto.md5.convert(bytes);
    return '$digest';
  }
  String calcHmac(String password){
    var bytes = utf8.encode(password);
    var digest = crypto.Hmac(crypto.sha512, bytes);
    return '$digest';
  }
  String getRandomPepper(){
    var random = Random.secure();
    var values = List<int>.generate(20, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }
  String calcEnryptAes(String password,String key){
    final keyHash=Key.fromUtf8(calcMD5(key));
    final encrypter = Encrypter(AES(keyHash));
    final iv = IV.fromUtf8(Const.pepper);
    final encrypted = encrypter.encrypt(password,iv: iv);

    return encrypted.base64;
  }
  String calcDecryAes(String password, String key){
    final keyHash=Key.fromUtf8(calcMD5(key));
    final encrypter = Encrypter(AES(keyHash));
    final iv = IV.fromUtf8(Const.pepper);
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(password),iv: iv);
    return decrypted;
  }


}
