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
              // Calculate opacity based on app bar's expanded height
              var top = constraints.biggest.height;
              bool isCollapsed = top <= kToolbarHeight + MediaQuery.of(context).padding.top;
              return FlexibleSpaceBar(
                title: isCollapsed
                    ? Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(right: 65),
                      child: Text(
                          widget.item.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
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
                    Container(
                      color: Colors.black45,
                    ),
                  ],
                ),
              );
            },
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                // Implement share functionality
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
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('More News', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              _buildMoreNews(moreArticles),
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
      itemCount: articles.length,
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
      child: Card(
        child: ListTile(
          leading: item.urlToImage.toString() != "null" ? Image.network(item.urlToImage.toString()) : SizedBox(),
          title: Text(item.title),
          subtitle: Text(item.content.toString()),
        ),
      ),
    );
  }
}
