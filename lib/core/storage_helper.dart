import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper{
  static const String tokenKey = 'tokenKey';
  static Future saveToken(String token)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(tokenKey, token);

  }
  static Future<String?> getToken()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(tokenKey);
    return token;
  }
  static Future<bool?> removeToken()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
     return sp.remove(tokenKey);

  }
}