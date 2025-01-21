import 'package:saga_kart_admin/core/app_constant.dart';
import 'package:saga_kart_admin/core/storage_helper.dart';

class ApiEndpoint {
  static const String baseUrl =
      'https://e-commerce-server-zc33.onrender.com/api';
  static const String signUp = '$baseUrl/users/register';
  static const String login = '$baseUrl/users/login';
  static const String getProduct = '$baseUrl/products';
  static const String getCategoryUrl = '$baseUrl/categories';
  static const String addProduct = '$baseUrl/products';
  static const String cart = '$baseUrl/cart';
  static const String order = '$baseUrl/orders';

  static const String addCategory = '$baseUrl/categories';

  static String updateCategory(String id) {
    return '$baseUrl/categories/$id';
  }
  static String updateOrder(String orderId) {
    return '$baseUrl/orders/$orderId';
  }
  static String deleteCategory(String id) {
    return '$baseUrl/categories/$id';
  }

  static String deleteCartItem(String id) {
    return '$baseUrl/cart/$id';
  }

  static String deleteProduct(String id) {
    return '$baseUrl/products/$id';
  }

  static String updateProduct(String id) {
    return '$baseUrl/products/$id';
  }

  static Future<Map<String, String>> getHeader() async {
    String? token = await StorageHelper.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'x-api-key': AppConstant.apiKey,
    };
  }
}
