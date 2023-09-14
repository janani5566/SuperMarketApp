import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<SharedPreferences> getInstance() async {
    return SharedPreferences.getInstance();
  }

  static Future<String?> getIpAddress() async {
    SharedPreferences prefs = await getInstance();
    return prefs.getString('ip_address');
  }

  static Future<void> saveIpAddress(String ipAddress) async {
    SharedPreferences prefs = await getInstance();
    await prefs.setString('ip_address', ipAddress);
  }
}
