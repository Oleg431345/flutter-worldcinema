// Константы текстовых стилей для приложения.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final title = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final subtitle = GoogleFonts.roboto(
    color: AppColors.grayText,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final button = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final input = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 14,
  );
}
