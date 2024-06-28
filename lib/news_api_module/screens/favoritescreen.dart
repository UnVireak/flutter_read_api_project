import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/screens/favoriteprovider.dart';
import 'package:provider/provider.dart';
import '../model/news_model.dart';
import 'detail_screen.dart';
//import '../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites yet."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return _buildFavoriteItem(context, favorites[index]);
              },
            ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, Article article) {
    String? imgUrl = article.urlToImage;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item: article,
              articles: [article],
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: imgUrl != null && imgUrl.isNotEmpty
              ? Image.network(
                  imgUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey,
                  child: Icon(Icons.image_not_supported),
                ),
          title: Text(
            article.title ?? 'No title',
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            article.description ?? 'No description',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
