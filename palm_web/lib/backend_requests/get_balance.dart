import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';


Future<http.Response> getBalance() async{
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: "jwt");

  var headers = {
    'Authorization': value!
  };
  print(headers);
  var request = http.Request('GET', Uri.parse(backendUrl + '/balance/'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resp = await http.Response.fromStream(response);
  return resp;

}
