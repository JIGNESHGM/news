import 'package:dio/dio.dart';
import '../models/user.dart';

class ApiServiceUser {
  final Dio _dio = Dio();

  Future<Response> registerUser(User user) async {
    try {
      Response response = await _dio.post(
        'http://192.168.83.127:8081/api/auth/register', // Replace with your API endpoint
        data: user.toJson(),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<Response> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://192.168.83.127:8081/api/auth/login', // Replace with your API endpoint
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
