import 'package:shared_preferences/shared_preferences.dart';

class AdminPreferences {
  AdminPreferences._privateConstructor();
  static final AdminPreferences instance =
  AdminPreferences._privateConstructor();

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }
}