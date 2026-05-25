// Экран входа.
// Пользователь вводит email и пароль, затем происходит проверка и переход на главный экран.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/register_screen.dart';
import '../screens/main_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showError = false;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _showError = true;
      });
      return;
    }

    await Provider.of<AuthProvider>(context, listen: false).login(email);
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'WorldCinema',
                  style: AppTextStyles.title,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Вход в аккаунт',
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Email',
                controller: _emailController,
              ),
              const SizedBox(height: 12),
              CustomInputField(
                label: 'Пароль',
                controller: _passwordController,
                obscureText: true,
              ),
              if (_showError) ...[
                const SizedBox(height: 12),
                Text(
                  'Пожалуйста, заполните все поля.',
                  style: AppTextStyles.subtitle.copyWith(color: AppColors.redAccent),
                ),
              ],
              const SizedBox(height: 20),
              CustomButton(
                text: 'Войти',
                onPressed: _login,
                filled: true,
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Регистрация',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                filled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
