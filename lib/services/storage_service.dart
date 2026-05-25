// Сервис хранения коллекций и других данных в SharedPreferences.

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/collection.dart';

class StorageService {
  static const _keyCollections = 'collections_data';

  // Сохраняет список коллекций в SharedPreferences.
  Future<void> saveCollections(List<Collection> collections) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = collections
        .map((collection) => {
              'id': collection.id,
              'name': collection.name,
              'iconName': collection.iconName,
            })
        .toList();
    await prefs.setString(_keyCollections, jsonEncode(jsonList));
  }

  // Загружает список коллекций из SharedPreferences.
  Future<List<Collection>> loadCollections() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyCollections);
    if (jsonString == null) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) {
      return Collection(
        id: item['id'] as String,
        name: item['name'] as String,
        iconName: item['iconName'] as String,
      );
    }).toList();
  }
}
