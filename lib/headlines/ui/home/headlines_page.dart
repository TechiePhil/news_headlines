import 'package:flutter/material.dart';
import 'package:headlines/headlines/model/news_headlines.dart';
import 'package:headlines/headlines/network/network.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
              var articleAuthor = snapshot.data.articles[index].author?? 'N/A';
              var publishDate = snapshot.data.articles[index].pubDate?? 'N/A';
              
              return Card(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Title section
                        Text(
                          snapshot.data.articles[index].title,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 3,
                        ),
                        
                        // Image and description widgets
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                color: Colors.blue
                              ),
                              SizedBox(width: 10),
                              Container(
                                child: Expanded(
                                  child: Text(
                                    snapshot.data.articles[index].description?? 
                                    '- No Description! -'.toUpperCase(),
                                    // overflow: TextOverflow.clip,
                                    // maxLines: 10,
                                  )
                                )
                              )
                            ]
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Author: $articleAuthor',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // SizedBox(width: 5),
                                Text(
                                  'Published: $publishDate',
                                )
                              ]
                            ),
                          ],
                        ),
                      ]
                    ),
                  ),
                )
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