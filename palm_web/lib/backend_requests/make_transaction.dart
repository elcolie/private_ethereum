import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';


class Pay{
  String to = '';
  int value = 0;
  String password = '';
  Pay(this.to, this.value, this.password);
}

Future<http.Response> makeTransaction(
  Pay pay
) async{
  final prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString('jwt');

  var headers = {
    'Authorization': value!,
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse(backendUrl + '/send-transaction/'));
  request.body = json.encode({
    "to": pay.to,
    "value": pay.value,
    "password": pay.password,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resp = await http.Response.fromStream(response);
  return resp;
}
