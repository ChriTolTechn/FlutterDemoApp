import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordHelper {
  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password);
    final saltBytes = utf8.encode(salt);
    return sha256.convert(bytes + saltBytes).toString();
  }

  static bool isCorrectPassword(String passwordHash, String passwordInputHash) {
    return passwordHash == passwordInputHash;
  }
}
