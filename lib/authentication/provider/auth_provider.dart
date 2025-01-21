import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:saga_kart_admin/authentication/model/auth_model.dart';
import 'package:saga_kart_admin/authentication/service/auth_service.dart';
import 'package:saga_kart_admin/core/app_util.dart';
import 'package:saga_kart_admin/core/storage_helper.dart';

class AuthProvider extends ChangeNotifier {
  AuthService authService;

  AuthProvider(this.authService);

  bool success = false;
  bool isLoading = false;
  String? errorMessage;

  Future signUp(User user) async {
    try {
      bool success = await authService.signUp(user);

      notifyListeners();
      if (success) {
        AppUtil.showToast('Congratulations your account has been '
            'created successfully');
      }
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
  }

  Future logIn(User user) async {
    try {
      isLoading = true;
      notifyListeners();
      String? token = await authService.logIn(user);
      await StorageHelper.saveToken(token);
      if (token.isNotEmpty) {
        AppUtil.showToast('Log in successfully.');
        errorMessage = null;
        // return true;
      } else {
        isLoading = false;
        AppUtil.showToast('Invalid username or password.');
        // return false;

      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      if (errorMessage is SocketException) {
        errorMessage = 'Internet not connected, Please try again later';
      }
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future logout() async {
    try {
      errorMessage = null;
      await StorageHelper.removeToken();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
