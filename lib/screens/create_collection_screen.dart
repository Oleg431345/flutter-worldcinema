// Экран создания коллекции.
// Позволяет задать название коллекции и выбрать иконку из набора.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/collection.dart';
import '../providers/collections_provider.dart';
import '../screens/icon_selection_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class CreateCollectionScreen extends StatefulWidget {
  const CreateCollectionScreen({super.key});

  @override
  State<CreateCollectionScreen> createState() => _CreateCollectionScreenState();
}

class _CreateCollectionScreenState extends State<CreateCollectionScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedIcon = 'star';
  bool _showError = false;

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
      case 'local_movies':
        return Icons.local_movies;
      default:
        return Icons.folder;
    }
  }

  Future<void> _chooseIcon() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const IconSelectionScreen()),
    );

    if (result != null) {
      setState(() {
        _selectedIcon = result;
      });
    }
  }

  Future<void> _saveCollection() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _showError = true;
      });
      return;
    }

    final collection = Collection(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      iconName: _selectedIcon,
    );

    await Provider.of<CollectionsProvider>(context, listen: false).addCollection(collection);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.fieldBackground,
        title: Text('Создать коллекцию', style: AppTextStyles.title),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputField(
              label: 'Название',
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            Text('Иконка', style: AppTextStyles.subtitle.copyWith(color: AppColors.white)),
            const SizedBox(height: 12),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.fieldBackground,
                child: Icon(_iconFromName(_selectedIcon), size: 36, color: AppColors.blueAccent),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Выбрать иконку',
              onPressed: _chooseIcon,
              filled: false,
            ),
            if (_showError) ...[
              const SizedBox(height: 12),
              Text(
                'Введите название коллекции.',
                style: AppTextStyles.subtitle.copyWith(color: AppColors.redAccent),
              ),
            ],
            const Spacer(),
            CustomButton(
              text: 'Сохранить',
              onPressed: _saveCollection,
              filled: true,
            ),
          ],
        ),
      ),
    );
  }
}
