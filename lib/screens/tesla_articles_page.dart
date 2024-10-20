import 'package:flutter/material.dart';
import '../widgets/article_card.dart';
import '../models/tesla_articles_model.dart';
import '../services/tesla_news_service.dart';

class TeslaArticlesPage extends StatefulWidget {
  @override
  _TeslaArticlesPageState createState() => _TeslaArticlesPageState();
}

class _TeslaArticlesPageState extends State<TeslaArticlesPage> {
  final TeslaNewsService _teslaNewsService = TeslaNewsService();
  List<TeslaArticle> _teslaArticles = [];
  bool _isLoading = true;
  int _currentPage = 1;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _loadTeslaArticles();
  }

  Future<void> _loadTeslaArticles() async {
    setState(() {
      _isFetchingMore = true;
    });
    try {
      TeslaArticles response = await _teslaNewsService.fetchTeslaArticles(_currentPage);
      setState(() {
        _teslaArticles.addAll(response.articles!);
        _isLoading = false;
        _currentPage++;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching Tesla articles: $e");
    } finally {
      setState(() {
        _isFetchingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tesla Articles'),
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _teslaArticles.length + (_teslaArticles.length > 50 ? 2 : 0), // Adding space for first and last options
              itemBuilder: (context, index) {
                if (_teslaArticles.length > 50 && index == 0) {
                  return _buildFirstArticleCard();
                } else if (_teslaArticles.length > 50 && index == _teslaArticles.length + 1) {
                  return _buildLastArticleCard();
                } else {
                  return ArticleCard(article: _teslaArticles[index - (_teslaArticles.length > 50 ? 1 : 0)]);
                }
              },
            ),
          ),
          if (_isFetchingMore) CircularProgressIndicator(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _loadTeslaArticles,
            child: Text('Load More Articles'),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstArticleCard() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('First Article'),
        subtitle: Text('Showing the first article'),
        onTap: () {
          // Handle first article action
        },
      ),
    );
  }

  Widget _buildLastArticleCard() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Last Article'),
        subtitle: Text('Showing the last article'),
        onTap: () {
          // Handle last article action
        },
      ),
    );
  }
}
