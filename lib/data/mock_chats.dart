// Моковые данные чатов для учебного приложения.

import '../models/chat.dart';
import '../models/message.dart';

final List<Chat> mockChats = [
  Chat(
    id: 'got',
    title: 'Игра престолов',
    lastMessage: 'За Железным троном снова битва.',
    avatarUrl: 'https://via.placeholder.com/80?text=GoT',
    messages: [
      Message(
        id: 'got_1',
        author: 'Алексей',
        text: 'Кто ваш любимый персонаж?',
        time: '10:12',
        isMine: false,
        dateLabel: '19 апреля',
      ),
      Message(
        id: 'got_2',
        author: 'Вы',
        text: 'Мне нравится Тирион, он умный.',
        time: '10:15',
        isMine: true,
        dateLabel: '19 апреля',
      ),
    ],
  ),
  Chat(
    id: 'arrow',
    title: 'Стрела',
    lastMessage: 'Новый сезон уже на подходе.',
    avatarUrl: 'https://via.placeholder.com/80?text=Arrow',
    messages: [
      Message(
        id: 'arrow_1',
        author: 'Маша',
        text: 'Ты уже посмотрел последний эпизод?',
        time: '12:20',
        isMine: false,
        dateLabel: 'Сегодня',
      ),
      Message(
        id: 'arrow_2',
        author: 'Вы',
        text: 'Еще нет, планирую вечером.',
        time: '12:24',
        isMine: true,
        dateLabel: 'Сегодня',
      ),
    ],
  ),
  Chat(
    id: 'jessica',
    title: 'Джессика Джонс',
    lastMessage: 'Расследование приближается к концу.',
    avatarUrl: 'https://via.placeholder.com/80?text=JJ',
    messages: [
      Message(
        id: 'jessica_1',
        author: 'Олег',
        text: 'Как тебе актёрская игра?',
        time: '09:40',
        isMine: false,
        dateLabel: '18 апреля',
      ),
      Message(
        id: 'jessica_2',
        author: 'Вы',
        text: 'Очень сильная, особенно в драматических сценах.',
        time: '09:45',
        isMine: true,
        dateLabel: '18 апреля',
      ),
    ],
  ),
  Chat(
    id: 'sabrina',
    title: 'Леденящие душу приключения Сабрины',
    lastMessage: 'Мистика выглядит потрясающе.',
    avatarUrl: 'https://via.placeholder.com/80?text=Sabrina',
    messages: [
      Message(
        id: 'sabrina_1',
        author: 'Аня',
        text: 'Это одна из моих любимых историй.',
        time: '14:05',
        isMine: false,
        dateLabel: 'Сегодня',
      ),
      Message(
        id: 'sabrina_2',
        author: 'Вы',
        text: 'Да, атмосфера просто класс!',
        time: '14:10',
        isMine: true,
        dateLabel: 'Сегодня',
      ),
    ],
  ),
];
