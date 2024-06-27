
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';

class NewsServices {
  static final String _key = "b91540dc515140c6b2781c2aee0d7186";
  // static final String baseUrl =
  //     "https://newsapi.org/v2/everything?q=tesla&from=2024-05-18&sortBy=publishedAt";

  static Future<NewModel> readAPI() async {
    final String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$_key";

    try {
      final http.Response res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        // Use compute to run expensive operation of parsing JSON in a separate isolate
        return compute(newModelFromMap, res.body);
      } else {
        throw Exception("Failed to load news: ${res.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}

