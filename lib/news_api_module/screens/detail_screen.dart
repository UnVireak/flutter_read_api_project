
import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final Article item;
  final List<Article> articles;
  DetailScreen({required this.item, required this.articles});

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
    List<Article> moreArticles = widget.articles.where((article) => article != widget.item).toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300.0,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var top = constraints.biggest.height;
              bool isCollapsed = top <= kToolbarHeight + MediaQuery.of(context).padding.top;
              return FlexibleSpaceBar(
                title: isCollapsed
                    ? Container(
                      margin: EdgeInsets.only(right: 65),
                      child: Text(
                          widget.item.title,
                          style: TextStyle(
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
                    Image.network(
                      widget.item.urlToImage.toString(),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            },
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,  color: Colors.black,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: Colors.black,),
              onPressed: () {
               
              },
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.item.publishedAt.toString())),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.item.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.item.description.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, top: 35),
                child: Text('Top trending', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)),
              ),
             
              _buildMoreNews(moreArticles),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 8),
                child: Text('Recommend for you', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              _buildMoreNews2(moreArticles),
              SizedBox(height: 20,)
            ],
          ),
        ),
        
      ],
    );
  }

  Widget _buildMoreNews(List<Article> articles) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
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
              articles: widget.articles.where((article) => article != item).toList(),
            ),
          ),
        );
      },
      child: Container(
  margin: EdgeInsets.only(top: 0),
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      // border: Border.all(color: Colors.grey, width: 1), // Add border if needed
    ),
    child: Padding(
      padding: EdgeInsets.all(0),
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
              : SizedBox(
                  width: 100,
                  height: 100,
                  child: Icon(Icons.image, size: 50),
                ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.0),
                Text(
                  item.content.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
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
  return Container(
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
            articles: widget.articles.where((article) => article != item).toList(),
          ),
        ),
      );
    },
   child: Container(
  width: 280.0, // Set a fixed width for each item
  height: 300,
  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    // border: Border.all(color: Colors.grey, width: 1), // Add border if needed
  ),
  child: Padding(
    padding: EdgeInsets.all(0),
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
            : SizedBox(
                width: 280,
                height: 150,
                child: Icon(Icons.image, size: 50),
              ),
        SizedBox(height: 8.0),
        Text(
          item.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.0),
        Text(
          item.content.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
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
