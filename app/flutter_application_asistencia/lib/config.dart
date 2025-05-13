import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static String baseUrl = '';

  static Future<void> loadBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    baseUrl = prefs.getString('base_url') ?? '';
  }

  static Future<void> saveBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('base_url', url);
    baseUrl = url;
  }
}