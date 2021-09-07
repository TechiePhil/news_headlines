import 'package:flutter/material.dart';
import 'package:headlines/headlines/model/news_headlines.dart';
import 'package:headlines/headlines/network/network.dart';

import 'article_details_page.dart';

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
        title: Text('News Headlines'),
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
              return InkWell(
                child: Card(
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
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              // fontStyle: FontStyle.italic
                              fontWeight: FontWeight.w600
                            )
                          ),
                          
                          // Image and description widgets
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 90,
                                  width: 90,
                                  child: getNetworkImage(
                                    snapshot.data.articles[index].imageUrl                                  
                                  )
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Expanded(
                                    child: Text(
                                      snapshot.data.articles[index].description?? 
                                      '- No Description! -'.toUpperCase(),
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300
                                      )
                                      // overflow: TextOverflow.clip,
                                      // maxLines: 10,
                                    )
                                  ),
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
                ),
                onTap: () {
                  // show a single article on a new route
                  showNewsDetailsPage(snapshot.data.articles[index]);
                }
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_download),
        onPressed: () {
          newsHeadlines = Network.fetchData(url);
          // newsHeadlines.then((headlines) {
          //   // print('Total Articles Retrieved: ${headlines.totalResults}');
          //   headlines.articles.forEach((article) {
          //     print('Image Url: ${article.imageUrl}');
          //   });
          // });
        }
      )
    );
  }
  
  // get then image from the network and display it. if image url is null,
  // show image placeholder.
  Widget getNetworkImage(String url) {
    if (url != null) {
      return Image.network(url, scale: 2);
    }
    return Container(
      child: Icon(
        Icons.image_not_supported, 
        size: 60, 
        color: Colors.blueGrey[200])
    );
  }
  
  // on tap, show the full news of the tapped card widget
  void showNewsDetailsPage(Articles article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ArticleDetailsPage(article);
        }
      )
    );
  }
}
