// Простой виджет поля ввода с темной темой и закругленной обводкой.

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: AppTextStyles.input,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.subtitle,
        filled: true,
        fillColor: AppColors.fieldBackground,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.fieldBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blueAccent),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
