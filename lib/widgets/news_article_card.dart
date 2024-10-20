import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/articles_model.dart';

class NewsArticleCard extends StatelessWidget {
  final Articles article;

  const NewsArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(article.title ?? 'No Title'),
        subtitle: Text(article.author ?? 'Unknown Author'),
        onTap: () {
          if (article.url != null) {
            _launchURL(article.url!);
          }
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
