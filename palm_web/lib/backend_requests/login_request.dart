import 'package:http/http.dart' as http;

import 'dart:convert';

import '../constants.dart';

Future<http.Response> sendReqLogin(String _username, String _password) async {
  //Send login request to get a token.
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse(backendUrl + '/api/auth-token/'));
  request.body = json.encode({
    "username": _username,
    "password": _password
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resp = await http.Response.fromStream(response);
  return resp;
}