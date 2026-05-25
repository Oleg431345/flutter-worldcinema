// Главный файл приложения, точка входа Flutter.
// Здесь подключаются провайдеры и настраивается тема приложения.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/collections_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const WorldCinemaApp());
}

class WorldCinemaApp extends StatelessWidget {
  const WorldCinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CollectionsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WorldCinema',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          primaryColor: AppColors.blueAccent,
          fontFamily: 'Roboto',
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: AppColors.fieldBackground,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.fieldBorder),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            hintStyle: TextStyle(color: AppColors.grayText),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
