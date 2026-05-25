// Моковые данные фильмов для учебного онлайн-кинотеатра.

import '../models/movie.dart';

final List<Movie> mockMovies = [
  Movie(
    id: 'captain_marvel',
    title: 'Captain Marvel',
    posterUrl: 'https://via.placeholder.com/400x600?text=Captain+Marvel',
    description: 'Супергеройский фильм о Кэрол Данверс, которая становится одним из самых могущественных героев во вселенной.',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  ),
  Movie(
    id: 'big_buck_bunny',
    title: 'Big Buck Bunny',
    posterUrl: 'https://via.placeholder.com/400x600?text=Big+Buck+Bunny',
    description: 'Забавный анимационный фильм о большом добром кролике, который защищает лесных друзей.',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  ),
  Movie(
    id: 'sabrina',
    title: 'Сабрина',
    posterUrl: 'https://via.placeholder.com/400x600?text=Sabrina',
    description: 'Тёмная история о молодой ведьме и её приключениях в мире магии.',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  ),
  Movie(
    id: 'jessica_jones',
    title: 'Jessica Jones',
    posterUrl: 'https://via.placeholder.com/400x600?text=Jessica+Jones',
    description: 'Детектив-ветеран с суперсилой расследует опасные заговоры и своё прошлое.',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  ),
  Movie(
    id: 'arrow',
    title: 'Arrow',
    posterUrl: 'https://via.placeholder.com/400x600?text=Arrow',
    description: 'История героя-стрелка, сражающегося за справедливость в своём городе.',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
  ),
  Movie(
    id: 'game_of_thrones',
    title: 'Game of Thrones',
    posterUrl: 'https://via.placeholder.com/400x600?text=Game+of+Thrones',
    description: 'Эпическая сага о борьбе за Железный трон и судьбе королевств.',
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
  ),
];
