import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildBody(context, screenHeight, screenWidth),
    );
  }

  Widget _buildBody(BuildContext context, double screenHeight, double screenWidth) {
    List<Article> moreArticles = widget.articles.where((article) => article != widget.item).toList();

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.item.urlToImage.toString(),
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.share, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, screenHeight * 0.32, 8, 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
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
                Container(
                  padding: EdgeInsets.all(8),
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
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.item.description.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                _buildMoreNews(moreArticles),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildMoreNews(List<Article> articles) {
  return Container(
    height: 400, // Adjust height as needed
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(), // Disable scrolling
      child: Column(
        children: articles.map((article) => _buildItem(article)).toList(),
      ),
    ),
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
    child: Card(
      child: ListTile(
        title: Text(item.title.toString()),
        subtitle: Text(item.content.toString()),
      ),
    ),
  );
}
  
  }

