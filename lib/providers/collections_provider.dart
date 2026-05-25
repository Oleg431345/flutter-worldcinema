// Провайдер для работы с коллекциями.
// Сохраняет коллекции в SharedPreferences и обновляет состояние приложения.

import 'package:flutter/material.dart';
import '../models/collection.dart';
import '../services/storage_service.dart';

class CollectionsProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<Collection> _collections = [];

  List<Collection> get collections => _collections;

  // Загружает коллекции из хранилища при старте.
  Future<void> loadCollections() async {
    _collections = await _storageService.loadCollections();
    if (_collections.isEmpty) {
      _collections = [
        Collection(id: 'favorites', name: 'Избранное', iconName: 'star'),
        Collection(id: 'later', name: 'Когда-нибудь', iconName: 'watch_later'),
        Collection(id: 'travel', name: 'В поездку', iconName: 'flight'),
      ];
      await _storageService.saveCollections(_collections);
    }
    notifyListeners();
  }

  // Добавляет новую коллекцию и сохраняет изменения.
  Future<void> addCollection(Collection collection) async {
    _collections.add(collection);
    await _storageService.saveCollections(_collections);
    notifyListeners();
  }
}
