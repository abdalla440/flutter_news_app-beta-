import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  // declare [sharedPreferences] object of type SharedPreferences
  static SharedPreferences? sharedPreferences;
  static init() async {
    /// Loads and parses the [SharedPreferences] for this app from disk.
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool({
    required String key,
    required bool value,
  }) async {
    // set key value pair in the memory to save the bool value
    return await sharedPreferences!.setBool(key, value);
  }
  static bool? getBool({required String key}) {
    return sharedPreferences!.getBool(key);
  }
  static Future<bool> putString({
    required String key,
    required String value,
  }) async {
    // set key value pair in the memory to save the bool value
    return await sharedPreferences!.setString(key, value);
  }

  static String? getString({required String key}) {
    return sharedPreferences!.getString(key);
  }
}
