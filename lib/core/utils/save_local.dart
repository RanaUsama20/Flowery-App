import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLocal {
 static Future<void> saveString(String key, String value) async {
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}