import 'package:flutter/cupertino.dart';
import 'package:saga_kart_admin/core/storage_helper.dart';

class SplashProvider extends ChangeNotifier{

  Future<bool> checkLoggedIn()async{
    bool isLoggedIn=false;
    String? token = await StorageHelper.getToken();
    if(token==null){
      isLoggedIn=true;
      notifyListeners();
    }else{
      isLoggedIn=false;
    }
    return isLoggedIn;
  }
}