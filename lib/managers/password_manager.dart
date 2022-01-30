import 'dart:convert';
import 'package:flutter/services.dart';

class PasswordManager {
  Future<String> getKey() async {
    Map map = await rootBundle.loadStructuredData(
      "assets/files/api_key.json",
      (String s) => Future(
        () => jsonDecode(s),
      ),
    );

    return map["api_key"];
  }
}
