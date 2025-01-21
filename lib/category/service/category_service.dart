import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saga_kart_admin/category/model/category_model.dart';
import 'package:saga_kart_admin/core/api_endpoint.dart';
import 'package:saga_kart_admin/core/app_constant.dart';
import 'package:saga_kart_admin/core/storage_helper.dart';


class CategoryService {
  Future<List<CategoryModel>> fetchCategory() async {
    String url = ApiEndpoint.getCategoryUrl;
    final response = await http.get(Uri.parse(url),
        headers: {'x-api-key': AppConstant.apiKey});
    if(response.statusCode==200){
      final mapList = jsonDecode(response.body);
      List<CategoryModel> categoryList = [];
      for (int a=0;a<mapList.length;a++){
        final map = mapList[a];
        CategoryModel category = CategoryModel.fromJson(map);
        categoryList.add(category);
      }
      return categoryList;
    }else{
      throw 'No Available Category';
    }
  }
  Future<bool> addCategory(CategoryModel category) async {
    String? token = await StorageHelper.getToken();
    if (token == null) {
      throw 'Token is null';
    }
    String url = ApiEndpoint.addCategory;
    String jsonCategory = jsonEncode(category.toJson());
    final response =
    await http.post(Uri.parse(url), body: jsonCategory, headers: {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer $token',
      'x-api-key': AppConstant.apiKey
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Something went wrong';
    }
  }
  Future<bool> deleteCategory(String id) async {
    Uri uri = Uri.parse(ApiEndpoint.deleteCategory(id));
    final header = await ApiEndpoint.getHeader();
    final response = await http.delete(uri, headers:header);
    if(response.statusCode == 200){
      return false;
    }else{
      throw 'unable to delete category';
    }
  }
  Future<bool> updateCategory(String id, CategoryModel updateCategory) async {
    Uri uri = Uri.parse(ApiEndpoint.updateCategory(id));
    final header = await ApiEndpoint.getHeader();
    final response = await http.put(
      uri,
      headers: header,
      body: jsonEncode(
        updateCategory.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Update nhi hua category';
    }
  }
}