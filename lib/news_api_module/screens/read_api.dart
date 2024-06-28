import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/screens/favoriteprovider.dart';
import 'package:flutter_read_api_project/news_api_module/screens/favoritescreen.dart';
import 'package:flutter_read_api_project/services/news_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';
import 'package:flutter_read_api_project/news_api_module/screens/detail_screen.dart';

class Readapi extends StatefulWidget {
  const Readapi({super.key});

  @override
  State<Readapi> createState() => _ReadapiState();
}

class _ReadapiState extends State<Readapi> {
  late Future<NewModel> _api;

  @override
  void initState() {
    super.initState();
    _api = NewsServices.readAPI();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _api = NewsServices.readAPI();
        });
      },
      child: Center(child: FutureBuilder<NewModel>(
       future: _api,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildOutput(snapshot.data);
            } else {
              return const CircularProgressIndicator();
            }
          },
 
      ),),
    );
  }
  
  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _api = NewsServices.readAPI();
        });
      },
      child: Center(
        child: FutureBuilder<NewModel>(
          future: _api,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildOutput(snapshot.data);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildOutput(NewModel? model) {
    if (model == null || model.articles == null || model.articles.isEmpty) {
      return const Center(child: Text("No news available."));
    } else {
      return
 Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        elevation: 10,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigate to Favorites page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    articles: model.articles,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildListView(model.articles),
    );

    }
  }

  Widget _buildListView(List<Article> articles) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return _buildItem(articles, index);
      },
    );
  }

  String truncateWithEllipsis(int maxLength, String text) {
    return (text.length <= maxLength)
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  Widget _buildItem(List<Article> articles, int index) {
    Article article = articles[index];
    String? imgUrl = article.urlToImage;
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.favorites.contains(article);

    // Check for null or missing values
    if (article.title == "null" || article.title.isEmpty) {
      return const SizedBox.shrink(); // Hide the item if it has no title
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item: article,
              articles: articles,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: AspectRatio(
            aspectRatio: 4 / 3,
            child: imgUrl != null && imgUrl.isNotEmpty
                ? Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 50,
                    color: Colors.grey,
                    child: const Icon(Icons.image_not_supported),
                  ),
          ),
          title: Text(
            article.title.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            article.content ?? "No content available.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              if (isFavorite) {
                favoritesProvider.removeFavorite(article);
              } else {
                favoritesProvider.addFavorite(article);
              }
            },
          ),
        ),
      ),
    );
  }
}
