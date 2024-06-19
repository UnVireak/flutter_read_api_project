import 'package:flutter/material.dart';
import 'package:flutter_read_api_project/news_api_module/model/news_model.dart';
import 'package:flutter_read_api_project/services/news_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   late Future<NewsModel> _api = NewsServices.readAPI();
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
        child: FutureBuilder<NewsModel>(
          future: _api,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildOuptut(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
    Widget _buildOuptut(NewsModel? model) {
    if (model == null) {
      return SizedBox();
    } else {
      return _buildListView(model.articles);
    }
  }

   Widget _buildListView(List<Article> results) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return _buildItem(results[index]);
      },
    );
  }

  Widget _buildItem(Article item) {
    return InkWell(
      // onTap: () {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => ItemDetailScreen(item),
      //     ),
      //   );
      // },
      child: Card(
        child: ListTile(
          leading: Image.network(item.urlToImage.toString()),
          title: Text(item.title.toString()),
          subtitle: Text(item.description.toString()),
          // trailing: Text("USD ${item.price}"),
        ),
      ),
    );
  }
}