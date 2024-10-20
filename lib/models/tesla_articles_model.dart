class TeslaArticles {
  List<TeslaArticle>? articles;

  TeslaArticles({this.articles});

  TeslaArticles.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = <TeslaArticle>[];
      json['articles'].forEach((v) {
        articles!.add(TeslaArticle.fromJson(v));
      });
    }
  }
}

class TeslaArticle {
  String? title;
  String? author;
  String? url;
  String? urlToImage;

  TeslaArticle({this.title, this.author, this.url, this.urlToImage});

  TeslaArticle.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    url = json['url'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = this.title;
    data['author'] = this.author;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    return data;
  }
}
