import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';
import 'package:flutter_read_api_project/news_api_module/screens/detail_screen.dart';
import 'package:flutter_read_api_project/news_api_module/screens/favoriteprovider.dart';
import 'package:flutter_read_api_project/news_api_module/screens/favoritescreen.dart';
import 'package:flutter_read_api_project/services/news_services.dart';
import 'package:provider/provider.dart';

class Readapi extends StatefulWidget {
  final Function(int) ref;

  const Readapi({Key? key, required this.ref}) : super(key: key);

  @override
  _ReadapiState createState() => _ReadapiState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to Favorites page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
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
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildOutput(NewModel? model) {
    if (model == null || model.articles == null || model.articles.isEmpty) {
      return Center(child: Text("No news available."));
    } else {
      return _buildListView(model.articles);
    }
  }

  Widget _buildListView(List<Article> articles) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return _buildItem(articles, index);
      },
    );
  }

  Widget _buildItem(List<Article> articles, int index) {
    Article article = articles[index];
    String? imgUrl = article.urlToImage;
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.favorites.contains(article);

    return ListTile(
      leading: imgUrl != null && imgUrl.isNotEmpty
          ? Image.network(imgUrl)
          : Container(
              width: 50,
              height: 50,
              color: Colors.grey,
              child: Icon(Icons.image_not_supported),
            ),
      title: Text(
        article.title ?? "No title available.",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        article.content ?? "No content available.",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
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
    );
  }
}
