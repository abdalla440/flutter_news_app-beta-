import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  // declare [sharedPreferences] object of type SharedPreferences
  static SharedPreferences? sharedPreferences;
  static init() async {
    /// Loads and parses the [SharedPreferences] for this app from disk.
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    // set key value pair in the memory to save the bool value
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getData({required String key}) {
    return sharedPreferences!.getBool(key);
  }
}
