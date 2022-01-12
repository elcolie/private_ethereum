import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:palm_web/backend_requests/login_request.dart';
import 'package:palm_web/screens/balance_screen.dart';
import 'package:palm_web/screens/error_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 400,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Welcome to Beauty Coin system',
                    style: TextStyle(fontSize: 20.0)),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  onChanged: (String value) {
                    _username = value;
                  },
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (String value) {
                    _password = value;
                  },
                ),
                TextButton(
                    onPressed: () async {
                      http.Response response =
                          await sendReqLogin(_username, _password);
                      if (response.statusCode == 200) {
                        final storage = new FlutterSecureStorage();
                        Map<String, dynamic> cleanedToken = json.decode(response.body);
                        print(cleanedToken["token"]);
                        await storage.write(key: 'jwt', value: cleanedToken["token"]);
                        Navigator.pushNamed(context, BalanceScreen.routeName);
                      } else {
                        Navigator.pushNamed(context, ErrorScreen.routeName);
                      }
                    },
                    child: Text('Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
