import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../services/api_service_user.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ApiServiceUser _apiService = ApiServiceUser();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your name';
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your email';
                  return null;
                },
              ),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your mobile number';
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
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () => Get.to(() => LoginPage()), // Navigate to Login Page
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        mobile: _mobileController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
      try {
        await _apiService.registerUser(newUser);
        Get.snackbar('Success', 'Registration successful. Please log in.');
        Get.off(() => LoginPage()); // Redirect to login page on success
      } catch (e) {
        Get.snackbar('Error', 'Failed to register: $e');
      }
    }
  }
}
