// Модель данных для фильма.

class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String description;
  final String videoUrl;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.description,
    required this.videoUrl,
  });
}
