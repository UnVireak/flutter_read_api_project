import 'package:flutter/material.dart';
import '../model/news_model.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Article> _favorites = [];

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
