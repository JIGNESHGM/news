import 'package:flutter/material.dart';
import '../models/articles_model.dart';
import '../models/tesla_articles_model.dart';

class ArticleTile extends StatelessWidget {
  final Articles article;

  ArticleTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: article.urlToImage != null
            ? Image.network(article.urlToImage!, width: 100, fit: BoxFit.cover)
            : Icon(Icons.article, size: 50),
        title: Text(article.title ?? 'No title'),
        subtitle: Text(article.author ?? 'Unknown author'),
        onTap: () {
          // Handle tap for opening article URL
          print('Article URL: ${article.url}');
        },
      ),
    );
  }
}
