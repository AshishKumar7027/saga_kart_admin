import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:saga_kart_admin/core/api_endpoint.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    String url = ApiEndpoint.getProduct;
    final header = await ApiEndpoint.getHeader();
    ();
    final response = await http.get(
      Uri.parse(url),
      headers: header,
    );
    if (response.statusCode == 200) {
      List<Product> productList = [];
      final mapList = jsonDecode(response.body);
      for (int a = 0; a < mapList.length; a++) {
        final map = mapList[a];
        Product product = Product.fromJson(map);
        productList.add(product);
      }
      return productList;
    } else {
      throw 'Unable to fetch product';
    }
  }

  Future<bool> addProduct(Product product) async {
    String url = ApiEndpoint.addProduct;
    final header = await ApiEndpoint.getHeader();
    String jsonProduct = jsonEncode(product.toJson());
    final response = await http.post(
      Uri.parse(url),
      body: jsonProduct,
      headers: header,
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Product Added Failed';
    }
  }

  Future<bool> updateProduct(String id, Product product) async {
    Uri uri = Uri.parse(ApiEndpoint.updateProduct(id),);
    final header = await ApiEndpoint.getHeader();
    final response = await http.put(
      uri,
      headers: header,
      body: jsonEncode(
        product.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Product Update Failed';
    }
  }

  Future<bool> deleteProduct(String id) async {
    Uri uri = Uri.parse(ApiEndpoint.deleteProduct(id));
    final header = await ApiEndpoint.getHeader();
    Response response = await http.delete(uri, headers: header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Product Delete Failed';
    }
  }
}
