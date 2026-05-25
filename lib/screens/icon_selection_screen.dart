// Экран выбора иконки коллекции.
// Отображает сетку иконок, каждая из которых возвращается при выборе.

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class IconSelectionScreen extends StatelessWidget {
  const IconSelectionScreen({super.key});

  static const List<Map<String, IconData>> icons = [
    {'star': Icons.star},
    {'watch_later': Icons.watch_later},
    {'flight': Icons.flight},
    {'movie': Icons.movie},
    {'favorite': Icons.favorite},
    {'music_note': Icons.music_note},
    {'local_movies': Icons.local_movies},
    {'theaters': Icons.theaters},
    {'tv': Icons.tv},
    {'bookmark': Icons.bookmark},
    {'people': Icons.people},
    {'camera_alt': Icons.camera_alt},
    {'subscriptions': Icons.subscriptions},
    {'library_music': Icons.library_music},
    {'directions_bike': Icons.directions_bike},
    {'restaurant': Icons.restaurant},
    {'spa': Icons.spa},
    {'fitness_center': Icons.fitness_center},
    {'games': Icons.games},
    {'palette': Icons.palette},
    {'star_border': Icons.star_border},
    {'shopping_bag': Icons.shopping_bag},
    {'settings': Icons.settings},
    {'lightbulb': Icons.lightbulb},
    {'coffee': Icons.coffee},
    {'pets': Icons.pets},
    {'heart_broken': Icons.heart_broken},
    {'place': Icons.place},
    {'translate': Icons.translate},
    {'directions_boat': Icons.directions_boat},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.fieldBackground,
        title: Text('Выбрать иконку', style: AppTextStyles.title),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена',
                style: TextStyle(color: AppColors.blueAccent)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: icons.length,
          itemBuilder: (context, index) {
            final iconEntry = icons[index].entries.first;
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, iconEntry.key);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child:
                      Icon(iconEntry.value, color: AppColors.white, size: 30),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
