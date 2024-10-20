import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/articles_model.dart';

class ApiService {
  final String _apiKey = '6ffa668c520540908d51f0a99d24592d'; // Replace with your API key
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<UsRight> fetchBusinessHeadlines({int page = 1}) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?country=us&category=business&pageSize=100&page=$page&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return UsRight.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load business headlines');
    }
  }
}
