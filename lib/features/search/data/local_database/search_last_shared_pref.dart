import 'dart:convert';
import 'package:flowery_app/features/search/data/model/last_search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLastSharedPref {
  static const _key = 'search_history';
  static const int maxResults = 20;

  static Future<void> addQuery(SearchQuery newQuery) async {
    final pref = await SharedPreferences.getInstance();
    final currentList = await getAllQueries();

    currentList.removeWhere((q) => q.title.toLowerCase() == newQuery.title.toLowerCase());

    currentList.add(SearchQuery(
      id: newQuery.id,
      title: newQuery.title,
      dateTime: DateTime.now(),
    ));

    currentList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    if (currentList.length > maxResults) {
      currentList.removeRange(maxResults, currentList.length);
    }

    final encoded = jsonEncode(currentList.map((e) => e.toJson()).toList());
    await pref.setString(_key, encoded);
  }

  static Future<List<SearchQuery>> getAllQueries() async {
    final pref = await SharedPreferences.getInstance();
    final jsonString = pref.getString(_key);
    if (jsonString == null) return [];
    final decoded = jsonDecode(jsonString) as List;
    return decoded.map((e) => SearchQuery.fromJson(e)).toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  static Future<void> clearAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_key);
  }

  static Future<void> removeQueryById(String id) async {
    final pref = await SharedPreferences.getInstance();
    final currentList = await getAllQueries();
    currentList.removeWhere((q) => q.id == id);
    final encoded = jsonEncode(currentList.map((e) => e.toJson()).toList());
    await pref.setString(_key, encoded);
  }
}
