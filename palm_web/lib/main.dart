import 'package:flutter/material.dart';
import 'package:palm_web/screens/finish_signup.dart';
import 'package:palm_web/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routes',
      initialRoute: '/',
      routes: {
        SignupScreen.routeName: (context) => const SignupScreen(),
        FinishSignupScreen.routeName: (context) => const FinishSignupScreen(),
      }
    );
  }
}
