// Модель данных для чата.
import 'message.dart';

class Chat {
  final String id;
  final String title;
  final String lastMessage;
  final String avatarUrl;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.avatarUrl,
    required this.messages,
  });
}
