import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:palm_web/screens/greeting.dart';
import 'dart:convert';
import 'package:palm_web/screens/payscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create storage
import '../backend_requests/get_balance.dart';

class BalanceScreen extends StatefulWidget {
  static const String routeName = '/balance';
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  String balanceDisplay = '';
  String addressDisplay = '';

  void initState(){
    requestBalance();
    super.initState();
  }

  void requestBalance() async {
    var textDisplay = '';
    var address = '';
    http.Response response = await getBalance();
    if(response.statusCode == 200){
      Map<String, dynamic> payload = json.decode(response.body);
      textDisplay = "Balance is : ${payload['balance'].toStringAsFixed(2)}";
      address = payload['address'];
    }else{
      //Show error text in the screen.
      textDisplay = "Please login again to renew token";
    }
    setState(() {
      print(textDisplay);
      balanceDisplay = textDisplay;
      addressDisplay = address;
    });
  }

  void logout()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Account'),
                  SizedBox(width: 10,),
                  SelectableText(addressDisplay),
                ],
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$balanceDisplay"),
                SizedBox(width: 20,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, PayScreen.routeName);
                }, child: Text("Make Payment")),
                TextButton(onPressed: () async {
                  logout();
                  Navigator.pushNamed(context, GreetingScreen.routeName);
                }, child: Text("Log out")),
              ],
            )],
          ),
        ),
      )
    );
  }
}
