import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/news_app.dart';
import 'package:flutter_read_api_project/news_api_module/screens/favoriteprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: const NewsApp(),
    ),
  );
}
