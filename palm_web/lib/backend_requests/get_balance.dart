import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';


Future<http.Response> getBalance() async{
  final prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString('jwt');
  var headers = {
    'Authorization': value!
  };
  print(headers);
  var request = http.Request('GET', Uri.parse(backendUrl + '/api/balance/'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resp = await http.Response.fromStream(response);
  return resp;

}
