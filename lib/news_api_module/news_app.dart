import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/home_screen/home.dart';
import 'package:flutter_read_api_project/news_api_module/home_screen/detail_screen.dart';
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: DetailScreen(),
    );
  }
}