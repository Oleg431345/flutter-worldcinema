// Экран коллекций.
// Здесь отображаются сохраненные коллекции и доступна кнопка для создания новой.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/collections_provider.dart';
import '../screens/create_collection_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      Provider.of<CollectionsProvider>(context, listen: false).loadCollections();
      _loaded = true;
    }
  }

  IconData _iconFromName(String name) {
    switch (name) {
      case 'star':
        return Icons.star;
      case 'watch_later':
        return Icons.watch_later;
      case 'flight':
        return Icons.flight;
      case 'movie':
        return Icons.movie;
      case 'favorite':
        return Icons.favorite;
      case 'music_note':
        return Icons.music_note;
      default:
        return Icons.folder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.fieldBackground,
        title: Text('Коллекции', style: AppTextStyles.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateCollectionScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<CollectionsProvider>(
        builder: (context, provider, child) {
          final collections = provider.collections;
          if (collections.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: collections.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final collection = collections[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.blueAccent,
                      child: Icon(_iconFromName(collection.iconName), color: AppColors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        collection.name,
                        style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: AppColors.grayText, size: 18),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
