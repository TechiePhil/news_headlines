import 'package:headlines/headlines/model/news_headlines.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Network {
  static Future<NewsHeadlines> fetchData(String url) async {
    NewsHeadlines newsHeadlines;
    Response response = await get(Uri.parse(Uri.encodeFull(url)));
    if (response.statusCode == 200) {
      // print('URL: $url');
      // print('Status: ${jsonDecode(response.body)['status']}');
      // print('Total: ${jsonDecode(response.body)['totalResults']}');
      // print('Articles: ${jsonDecode(response.body)['articles']}');
      // print('Article2: ${jsonDecode(response.body)['articles'][1]}');
      
      newsHeadlines = NewsHeadlines.fromJson(jsonDecode(response.body));
    }
    return newsHeadlines;
  }
}