import 'package:flutter/material.dart';

class FinishSignupScreen extends StatelessWidget {
  static const String routeName = '/done';
  const FinishSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text("Done"),
      ),
    );
  }
}
