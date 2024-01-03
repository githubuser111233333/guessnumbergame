import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
String? loggedInUsername;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/backgroundIMG.jpeg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: RegisterForm(),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _registrationStatus = '';

  Future<void> registerUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://guessnumber1.000webhostapp.com/register.php'),
        body: {'username': username, 'password': password},
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      setState(() {
        if (response.statusCode == 200 && responseData['status'] == 'success') {
          _registrationStatus = 'Registration successful!';
        } else {
          _registrationStatus = 'Failed to register user. ${responseData['message']}';
        }
      });

      if (responseData['status'] == 'success') {
        _registrationStatus = 'Registration successful!';
      }
    } catch (e) {
      setState(() {
        _registrationStatus = 'Failed to register user. Please try again.';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _usernameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await registerUser(
                    _usernameController.text,
                    _passwordController.text,
                  );
                } catch (e) {
                  print('Error registering user: $e');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 30.0,
              ),
            ),
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _registrationStatus,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

