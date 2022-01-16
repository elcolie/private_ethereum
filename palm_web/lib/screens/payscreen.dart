import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../backend_requests/make_transaction.dart';
import 'balance_screen.dart';

class PayScreen extends StatefulWidget {
  static const String routeName = '/pay';

  const PayScreen({Key? key}) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String _to = '';
  int _value = 0;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 400,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Make Transaction'),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'To',
                  ),
                  onChanged: (value){
                    _to = value;
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Value in ETH',
                  ),
                  onChanged: (__value){
                    print("__value ETH: $__value");
                    double doubleTypeValue = double.parse(__value) * 1000000000000000000;
                    _value = doubleTypeValue.toInt();
                    print("Wei: ${_value}");
                  },
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (value){
                    _password = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(onPressed: () async {
                  Pay sendTransaction = Pay(
                    _to, _value, _password
                  );
                  http.Response response = await makeTransaction(sendTransaction);
                  print("response.body: ${response.body}");
                  if(response.statusCode == 201){
                    final Map<String, dynamic> message = json.decode(response.body);
                    final transactionNumber = message['transaction_number'];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Alert!!"),
                          content: new Text("Your transaction number is ${transactionNumber}"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("OK"),
                              onPressed: () {
                                Navigator.pushNamed(context, BalanceScreen.routeName);;
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }else{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Alert!!"),
                          content: new Text("${response.body}"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }, child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
