import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Singleton pattern to ensure only one instance of SharedPreferencesService
  SharedPreferencesService._privateConstructor();
  static final SharedPreferencesService instance =
      SharedPreferencesService._privateConstructor();

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> savePomodoroSettings({
    required int focusTime,
    required int shortBreakTime,
    required int longBreakTime,
    required String intervals,
  }) async {
    await SharedPreferencesService.instance.setInt('focusTime', focusTime);
    await SharedPreferencesService.instance
        .setInt('shortBreakTime', shortBreakTime);
    await SharedPreferencesService.instance
        .setInt('longBreakTime', longBreakTime);
    await SharedPreferencesService.instance.setString('intervals', intervals);
  }

  Future<Map<String, dynamic>> loadPomodoroSettings() async {
    final focusTime =
        await SharedPreferencesService.instance.getInt('focusTime') ??
            60; // Varsayılan 25 dakika
    final shortBreakTime =
        await SharedPreferencesService.instance.getInt('shortBreakTime') ??
            300; // Varsayılan 5 dakika
    final longBreakTime =
        await SharedPreferencesService.instance.getInt('longBreakTime') ??
            300; // Varsayılan 5 dakika
    final intervals =
        await SharedPreferencesService.instance.getString('intervals') ??
            '4 intervals'; // Varsayılan 4 interval

    return {
      'focusTime': focusTime,
      'shortBreakTime': shortBreakTime,
      'longBreakTime': longBreakTime,
      'intervals': intervals,
    };
  }
}
