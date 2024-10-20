import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'HomePage.dart'; // Adjust according to your home page
import '../services/api_service_user.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiServiceUser _apiService = ApiServiceUser();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your email';
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your password';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () => Get.to(() => RegisterPage()), // Navigate to Register Page
                child: Text('Don’t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _apiService.loginUser(
          _emailController.text,
          _passwordController.text,
        );
        Get.snackbar('Success', 'Login Successful');
        Get.off(() => HomePage()); // Replace with your main page
      } catch (e) {
        Get.snackbar('Error', 'Login failed. Please check your credentials and try again.');
        print('Detailed error: $e');
      }
    }
  }
}
