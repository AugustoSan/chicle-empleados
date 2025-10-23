import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthService {
  // Example method to hash password
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  static bool checkPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }
}
