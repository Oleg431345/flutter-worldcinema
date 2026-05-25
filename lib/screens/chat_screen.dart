// Экран чата.
// Отображается история сообщений и поле для ввода нового сообщения.

import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Message> _messages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = List.of(widget.chat.messages);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: 'Вы',
        text: text,
        time: 'Сейчас',
        isMine: true,
        dateLabel: 'Сегодня',
      ));
    });
    _controller.clear();
  }

  List<Widget> _buildMessageWidgets() {
    final widgets = <Widget>[];
    String? currentDate;

    for (var message in _messages) {
      if (message.dateLabel != currentDate) {
        currentDate = message.dateLabel;
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(message.dateLabel, style: AppTextStyles.subtitle.copyWith(color: AppColors.grayText)),
            ),
          ),
        );
      }

      widgets.add(_buildMessageBubble(message));
    }

    return widgets;
  }

  Widget _buildMessageBubble(Message message) {
    final alignment = message.isMine ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = message.isMine ? AppColors.blueAccent : AppColors.fieldBackground;
    final textColor = message.isMine ? AppColors.white : AppColors.white;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.author, style: AppTextStyles.subtitle.copyWith(color: AppColors.grayText, fontSize: 12)),
            const SizedBox(height: 4),
            Text(message.text, style: AppTextStyles.subtitle.copyWith(color: textColor)),
            const SizedBox(height: 6),
            Text(message.time, style: AppTextStyles.subtitle.copyWith(color: AppColors.grayText, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.fieldBackground,
        title: Text(widget.chat.title, style: AppTextStyles.title),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: _buildMessageWidgets(),
            ),
          ),
          Container(
            color: AppColors.fieldBackground,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: AppTextStyles.input,
                    decoration: const InputDecoration(
                      hintText: 'Сообщение',
                      hintStyle: TextStyle(color: AppColors.grayText),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: AppColors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
