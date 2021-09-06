class Headline {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Headline(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Headline.fromJson(Map<String, dynamic> json) {
    source =
      json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

// class Headline {
//   Headline({
//     this.source,
//     this.author,
//     this.title,
//     this.description,
//     this.url,
//     this.imageUrl,
//     this.published,
//     this.content
//   });
  
//   final Source source;
//   final String author;
//   final String title;
//   final String description;
//   final String url;
//   final String imageUrl;
//   final String published;
//   final String content;
  
//   factory Headline.fromJson(Map<String, dynamic> data) {
//     return Headline(
//       source: data['source'] != null ? Source.fromJson(data['source']): null,
//       author: data['author'],
//       title: data['title'],
//       description: data['description'],
//       url: data['url'],
//       imageUrl: data['imageUrl'],
//       published: data['published'],
//       content: data['content'],
//     );
//   }
// }

// class Source {
//   Source({this.id, this.name});
//   final String id;
//   final String name;
  
//   factory Source.fromJson(Map<String, dynamic> data) {
//     return Source(
//       id: data['id'],
//       name: data['name']
//     );
//   }
// }