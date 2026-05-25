// Провайдер для состояния авторизации.
// Хранит в памяти информацию о залогиненном пользователе и позволяет обновлять статус.

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  String? _email;

  bool get isLoggedIn => _isLoggedIn;
  String? get email => _email;

  // Загружает статус из SharedPreferences при старте приложения.
  Future<void> loadAuthStatus() async {
    _isLoggedIn = await _authService.isLoggedIn();
    _email = await _authService.getEmail();
    notifyListeners();
  }

  // Выполняет вход, сохраняя email и статус.
  Future<void> login(String email) async {
    await _authService.saveLoggedIn(email);
    _isLoggedIn = true;
    _email = email;
    notifyListeners();
  }

  // Выход из аккаунта.
  Future<void> logout() async {
    await _authService.logout();
    _isLoggedIn = false;
    _email = null;
    notifyListeners();
  }
}
