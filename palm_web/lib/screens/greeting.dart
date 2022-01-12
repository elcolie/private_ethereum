import 'package:flutter/material.dart';
import 'package:palm_web/screens/signup.dart';

import 'login_screen.dart';

class GreetingScreen extends StatelessWidget {
  static const String routeName = '/greeting';
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                child: Text("Signup"),
              ),
              SizedBox(width: 20,),
              TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: Text("Login"),
              )
            ],
          ),
        )
      )
    );
  }
}
