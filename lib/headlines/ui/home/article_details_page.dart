import 'package:flutter/material.dart';
import 'package:headlines/headlines/model/news_headlines.dart';


// this widget will show the whole news article and it relevant details
class ArticleDetailsPage extends StatelessWidget {
  ArticleDetailsPage(this.article);
  final Articles article;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 300,
                  child: getNetworkImage(article.imageUrl),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Text(
                    article.content?? 'Sorry, nothing to show.',
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 25,
                    )
                  )
                )
              )
            ],
          ),
        ),
      ),
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
        size: 200,
        color: Colors.blueGrey[200])
    );
  }
}