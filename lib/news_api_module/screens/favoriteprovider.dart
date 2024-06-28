import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Article> _favorites = [];

  List<Article> get favorites => _favorites;

  void addFavorite(Article article) {
    if (!_favorites.contains(article)) {
      _favorites.add(article);
      notifyListeners();
    }
  }

  void removeFavorite(Article article) {
    if (_favorites.contains(article)) {
      _favorites.remove(article);
      notifyListeners();
    }
  }
}
