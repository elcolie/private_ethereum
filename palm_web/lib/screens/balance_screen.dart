import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:palm_web/screens/payscreen.dart';

import '../backend_requests/get_balance.dart';

class BalanceScreen extends StatefulWidget {
  static const String routeName = '/balance';
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  String balanceDisplay = '';

  void initState(){
    requestBalance();
    super.initState();
  }

  void requestBalance() async {
    var textDisplay = '';
    http.Response response = await getBalance();
    if(response.statusCode == 200){
      Map<String, dynamic> payload = json.decode(response.body);
      textDisplay = "Balance is : ${payload['balance']}";
    }else{
      //Show error text in the screen.
      textDisplay = "Please login again to renew token";
    }
    setState(() {
      print(textDisplay);
      balanceDisplay = textDisplay;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$balanceDisplay"),
              SizedBox(width: 20,),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, PayScreen.routeName);
              }, child: Text("Make Payment")),
            ],
          ),
        ),
      )
    );
  }
}