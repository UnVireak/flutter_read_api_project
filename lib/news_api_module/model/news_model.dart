import 'dart:convert';

NewsModel newsModelFromMap(String str) => NewsModel.fromMap(json.decode(str));

String newsModelToMap(NewsModel data) => json.encode(data.toMap());

class NewsModel {
  String status;
  int totalResults;
  List<Article> articles;

  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        status: json["status"] ?? '',
        totalResults: json["totalResults"] ?? 0,
        articles: List<Article>.from(
            json["articles"]?.map((x) => Article.fromMap(x)) ?? []),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
      };
}

class Article {
  Source source;
  String? author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        source: Source.fromMap(json["source"]),
        author: json["author"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        url: json["url"] ?? '',
        urlToImage: json["urlToImage"] ?? '',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "source": source.toMap(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  String? id;
  String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromMap(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}
