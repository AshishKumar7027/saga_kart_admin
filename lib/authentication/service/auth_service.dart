
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:saga_kart_admin/authentication/model/auth_model.dart';
import 'package:saga_kart_admin/core/api_endpoint.dart';



class AuthService {
  Future<bool> signUp(User user) async {
    String url = ApiEndpoint.signUp;
    final encode = jsonEncode(user.toJson());
    // print(encode);
    Response response = await http.post(Uri.parse(url),
        body: encode, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      // print('Sign up successful: ${response.body}');
      return true;
    } else {
      throw ('Something went wrong');
    }
  }

  Future<String> logIn(User user) async {
    String url = ApiEndpoint.login;
    final encode = jsonEncode(user.toJson());
    Response response = await http.post(Uri.parse(url),
        body: encode, headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      print('Sign up successful: ${response.body}');
      String data = response.body;
      final map = jsonDecode(data);
      String token = map['token'];
      return token;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
