// Экран регистрации.
// Пользователь может создать фейковый аккаунт и сразу перейти в приложение.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _showError = false;
  String _errorText = '';

  void _register() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      setState(() {
        _showError = true;
        _errorText = 'Заполните все поля.';
      });
      return;
    }

    if (password != confirm) {
      setState(() {
        _showError = true;
        _errorText = 'Пароли не совпадают.';
      });
      return;
    }

    await Provider.of<AuthProvider>(context, listen: false).login(email);
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
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
                'Создать аккаунт',
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Имя',
                controller: _firstNameController,
              ),
              const SizedBox(height: 12),
              CustomInputField(
                label: 'Фамилия',
                controller: _lastNameController,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              CustomInputField(
                label: 'Повторите пароль',
                controller: _confirmController,
                obscureText: true,
              ),
              if (_showError) ...[
                const SizedBox(height: 12),
                Text(
                  _errorText,
                  style: AppTextStyles.subtitle.copyWith(color: AppColors.redAccent),
                ),
              ],
              const SizedBox(height: 20),
              CustomButton(
                text: 'Зарегистрироваться',
                onPressed: _register,
                filled: true,
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'У меня уже есть аккаунт',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
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
