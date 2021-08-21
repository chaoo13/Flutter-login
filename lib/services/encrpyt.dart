import 'package:encrypt/encrypt.dart';
import 'dart:convert';

class SecureManager {
  String keyStr;

  static final _secureManager = SecureManager._internal();

  SecureManager._internal();

  factory SecureManager(String keyStr) {
    _secureManager.keyStr = keyStr;
    return _secureManager;
  }

  String getKey() {
    if (this.keyStr.length > 32) {
      return this.keyStr.substring(0, 32);
    } else {
      var length = 32 - this.keyStr.length;
      String key = keyStr;
      for (int i = 0; i < length; i++) {
        key += "0";
      }
      return key;
    }
  }

  String encypt(String plainText) {
    final key = Key.fromUtf8(getKey());
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decypt(String encrypted) {
    final key = Key.fromUtf8(getKey());
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final plainText =
        encrypter.decrypt(Encrypted(base64Decode(encrypted)), iv: iv);
    return plainText;
  }
}
