import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:palm_web/backend_requests/signup.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _username = '';
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _validatePassword = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? passwordErrorText() {
    if (_password == _confirmPassword) {
      return null;
    } else {
      return 'Password is not match';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 500,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Signup here️'),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  onChanged: (String username) {
                    _username = username;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name',
                  ),
                  onChanged: (String name) {
                    _name = name;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                  ),
                  onChanged: (String email) {
                    _email = email;
                  },
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (String password) {
                    _password = password;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, String> payload = {
                      'username': _username,
                      'name': _name,
                      'email': _email,
                      'password': _password,
                    };
                    http.Response response = await postSignup(payload);
                    print(response.statusCode);
                  },
                  child: Text('submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
