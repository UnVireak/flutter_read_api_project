import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/screens/detail_screen.dart';
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';
import 'package:flutter_read_api_project/services/news_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<NewModel> _api = NewsServices.readAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
    if (model == null) {
      return SizedBox();
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
    String? imgUrl = articles[index].urlToImage.toString();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item: articles[index],
              articles: articles,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: imgUrl != "null" ? Image.network(imgUrl) : SizedBox(),
          title: Text(articles[index].title.toString()),
          subtitle: Text(articles[index].content.toString()),
        ),
      ),
    );
  }
}
