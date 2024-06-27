import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/screens/aboutUs_screen.dart';
import 'package:flutter_read_api_project/news_api_module/screens/home.dart';
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: AboutUsScreen(),
    );
  }
}