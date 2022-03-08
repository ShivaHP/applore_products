import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late final SharedPreferences preferences;

  static Future<void> initialize() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void setString({required String key, required String value}) {
    preferences.setString(key, value);
  }

  static String getString(String key) {
    return preferences.getString(key) ?? "";
  }
}
