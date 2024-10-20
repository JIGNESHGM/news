import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tesla_articles_model.dart';

class TeslaNewsService {
  final String _apiKey = '6ffa668c520540908d51f0a99d24592d'; // Replace with your API key
  final String _baseUrl = 'https://newsapi.org/v2/everything?q=tesla';

  Future<TeslaArticles> fetchTeslaArticles(int page) async {
    final response = await http.get(Uri.parse('$_baseUrl&page=$page&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return TeslaArticles.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Tesla articles');
    }
  }
}
