import 'package:flutter/material.dart';
import 'package:palm_web/screens/balance_screen.dart';
import 'package:palm_web/screens/error_screen.dart';
import 'package:palm_web/screens/finish_signup.dart';
import 'package:palm_web/screens/greeting.dart';
import 'package:palm_web/screens/login_screen.dart';
import 'package:palm_web/screens/payscreen.dart';
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
      initialRoute: GreetingScreen.routeName,
      routes: {
        GreetingScreen.routeName: (context) => const GreetingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        PayScreen.routeName: (context) => const PayScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        FinishSignupScreen.routeName: (context) => const FinishSignupScreen(),
        ErrorScreen.routeName: (context) => const ErrorScreen(),
        BalanceScreen.routeName: (context) => const BalanceScreen(),
      }
    );
  }
}
