import 'package:flutter/material.dart';
import '../widgets/news_article_card.dart';
import '../models/articles_model.dart';
import '../services/api_service.dart';

class BusinessHeadlinesPage extends StatefulWidget {
  @override
  _BusinessHeadlinesPageState createState() => _BusinessHeadlinesPageState();
}

class _BusinessHeadlinesPageState extends State<BusinessHeadlinesPage> {
  final ApiService _apiService = ApiService();
  List<Articles> _businessArticles = [];
  bool _isLoading = true;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadBusinessArticles();
  }

  Future<void> _loadBusinessArticles() async {
    try {
      UsRight response = await _apiService.fetchBusinessHeadlines(page: _currentPage);
      setState(() {
        _businessArticles.addAll(response.articles!);
        _isLoading = false;
        _currentPage++;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching business articles: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Headlines'),
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _businessArticles.length,
        itemBuilder: (context, index) {
          return NewsArticleCard(article: _businessArticles[index]);
        },
      ),
    );
  }
}
