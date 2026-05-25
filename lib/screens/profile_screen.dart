// Экран профиля пользователя.
// Показывает информацию о пользователе, меню и кнопку выхода из приложения.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/chat_list_screen.dart';
import '../screens/login_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.fieldBackground,
        title: Text('Профиль', style: AppTextStyles.title),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            CircleAvatar(
              radius: 54,
              backgroundColor: AppColors.fieldBackground,
              child: CachedNetworkImage(
                imageUrl: 'https://via.placeholder.com/150?text=Avatar',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 52,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.person, size: 52, color: AppColors.white),
              ),
            ),
            const SizedBox(height: 12),
            Text('Воланд Иванов', style: AppTextStyles.title),
            const SizedBox(height: 6),
            Text(authProvider.email ?? 'voland.ivanov@gmail.com', style: AppTextStyles.subtitle),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.fieldBackground,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              onPressed: () {},
              child: const Text('Изменить', style: TextStyle(color: AppColors.white)),
            ),
            const SizedBox(height: 24),
            _buildMenuItem(context, Icons.chat_bubble_outline, 'Обсуждения', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatListScreen()),
              );
            }),
            _buildMenuItem(context, Icons.history, 'История', () {}),
            _buildMenuItem(context, Icons.settings, 'Настройки', () {}),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  await authProvider.logout();
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Выход', style: TextStyle(color: AppColors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: AppColors.blueAccent),
          title: Text(title, style: AppTextStyles.subtitle.copyWith(color: AppColors.white)),
          trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.grayText, size: 18),
          onTap: onTap,
        ),
        const Divider(color: AppColors.fieldBorder),
      ],
    );
  }
}
