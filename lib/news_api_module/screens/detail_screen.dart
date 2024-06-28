import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';
import 'package:flutter_read_api_project/news_api_module/screens/favoriteprovider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Article item;
  final List<Article> articles;
  const DetailScreen({super.key, required this.item, required this.articles});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.favorites.contains(widget.item);
    List<Article> moreArticles =
        widget.articles.where((article) => article != widget.item).toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300.0,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var top = constraints.biggest.height;
              bool isCollapsed =
                  top <= kToolbarHeight + MediaQuery.of(context).padding.top;
              return FlexibleSpaceBar(
                title: isCollapsed
                    ? Container(
                        margin: const EdgeInsets.only(right: 65),
                        child: Text(
                          widget.item.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      )
                    : null,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    widget.item.urlToImage != null &&
                            widget.item.urlToImage!.isNotEmpty
                        ? Image.network(
                            widget.item.urlToImage.toString(),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 100,),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey,
                          size: 15,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(
                              widget.item.publishedAt.toString())),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          favoritesProvider.removeFavorite(widget.item);
                        } else {
                          favoritesProvider.addFavorite(widget.item);
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.item.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.item.description.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 35),
                child: Text('Top trending',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              _buildMoreNews(moreArticles),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 8),
                child: Text('Recommend for you',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              _buildMoreNews2(moreArticles),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoreNews(List<Article> articles) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildItem(articles[index]);
      },
    );
  }

  Widget _buildItem(Article item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item: item,
              articles:
                  widget.articles.where((article) => article != item).toList(),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            // border: Border.all(color: Colors.grey, width: 1), // Add border if needed
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item.urlToImage.toString() != "null"
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          item.urlToImage.toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(Icons.image, size: 50),
                      ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        item.content.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreNews2(List<Article> articles) {
    return SizedBox(
      height: 300.0, // Set a fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Make the list scroll horizontally
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return _buildHorizontalItem(articles[index]);
        },
      ),
    );
  }

  Widget _buildHorizontalItem(Article item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item: item,
              articles:
                  widget.articles.where((article) => article != item).toList(),
            ),
          ),
        );
      },
      child: Container(
        width: 280.0, // Set a fixed width for each item
        height: 300,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          // border: Border.all(color: Colors.grey, width: 1), // Add border if needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.urlToImage.toString() != "null"
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        item.urlToImage.toString(),
                        width: 280, // Adjust width as needed
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(
                      width: 280,
                      height: 150,
                      child: Icon(Icons.image, size: 50),
                    ),
              const SizedBox(height: 8.0),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Text(
                item.content.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
