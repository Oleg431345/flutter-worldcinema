// Сервис авторизации. Работает с SharedPreferences для сохранения статуса входа.

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _keyLoggedIn = 'is_logged_in';
  static const _keyEmail = 'user_email';

  // Сохраняет информацию о том, что пользователь вошел.
  Future<void> saveLoggedIn(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, true);
    await prefs.setString(_keyEmail, email);
  }

  // Удаляет информацию о входе.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoggedIn);
    await prefs.remove(_keyEmail);
  }

  // Проверяет, авторизован ли пользователь.
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  // Получает сохраненный email пользователя.
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }
}
