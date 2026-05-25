// Модель данных для сообщения в чате.

class Message {
  final String id;
  final String author;
  final String text;
  final String time;
  final bool isMine;
  final String dateLabel;

  Message({
    required this.id,
    required this.author,
    required this.text,
    required this.time,
    required this.isMine,
    required this.dateLabel,
  });
}
