import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const String routeName = '/error';
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Unable to process your request"),
              SizedBox(height: 10.0,),
              Text("Please contact engineer 083 932 0427"),
            ],
          ),
        ),
      )
    );
  }
}
