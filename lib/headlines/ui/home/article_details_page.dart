import 'package:flutter/material.dart';
import 'package:headlines/headlines/model/news_headlines.dart';


// this widget will show the whole news article and it relevant details
class ArticleDetailsPage extends StatelessWidget {
  ArticleDetailsPage(this.article);
  final Articles article;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Expanded(
              child: Text(
                article.description?? '- no description! -'.toUpperCase(),
                // maxLines: 30,
                // softWrap: true,
                // overflow: TextOverflow.clip,
              )
            )
          ]
        )
      )
    );
  }
}