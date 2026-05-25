// Экран списка обсуждений.
// Показывает список доступных чатов с последними сообщениями.

import 'package:flutter/material.dart';
import '../data/mock_chats.dart';
import '../models/chat.dart';
import '../screens/chat_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.fieldBackground,
        title: Text('Обсуждения', style: AppTextStyles.title),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: mockChats.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final Chat chat = mockChats[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen(chat: chat)),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.fieldBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.blueAccent,
                    backgroundImage: NetworkImage(chat.avatarUrl),
                    child: chat.avatarUrl.isEmpty ? const Icon(Icons.person, color: AppColors.white) : null,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(chat.title, style: AppTextStyles.subtitle.copyWith(color: AppColors.white)),
                        const SizedBox(height: 4),
                        Text(chat.lastMessage, style: AppTextStyles.subtitle),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.grayText),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
