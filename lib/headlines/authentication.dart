import 'package:flutter/material.dart';
import 'package:headlines/headlines/model/news_headlines.dart';

import 'network/network.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  static const API_KEY = '22786b65d5cf428db068e348f6c90492';
  String url = 'https://newsapi.org/v2/top-headlines?' +
    'country=ng&apiKey=' + API_KEY;
    
  Future<NewsHeadlines> newsHeadlines;
  @override
  void initState() {
    super.initState();
    newsHeadlines = Network.fetchData(url);
    // newsHeadlines.then((headlines) {
    //   headlines.articles.forEach((element) {
    //     print(element.title);
    //   });
    // });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: FutureBuilder(
        future: newsHeadlines,
        builder: (BuildContext context, AsyncSnapshot<NewsHeadlines> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.articles.length,
            itemBuilder: (context, index) {
              return Container(
                height: 180,
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Text(
                      snapshot.data.articles[index].description?? '',
                      overflow: TextOverflow.ellipsis,
                    )
                  )
                ),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_download),
        onPressed: () {
          newsHeadlines = Network.fetchData(url);
          newsHeadlines.then((headlines) {
            print('Total Articles Retrieved: ${headlines.totalResults}');
            headlines.articles.forEach((article) {
              print('Headline: ${article.title}');
            });
          }).timeout(Duration(seconds: 20));
        }
      )
    );
  }
}