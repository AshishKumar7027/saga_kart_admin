import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:saga_kart_admin/cart/model/cart_model.dart';
import 'package:saga_kart_admin/cart/model/cart_response.dart';
import 'package:saga_kart_admin/core/api_endpoint.dart';

class CartService {
  Future addToCart(CartModel cartModel) async {
    String url = ApiEndpoint.cart;
    final header = await ApiEndpoint.getHeader();
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        cartModel.toJson(),
      ),
      headers: header,
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'product add nhi hua hai cart me';
    }
  }

  Future<CartResponse> fetchCartItems() async {
    String url = ApiEndpoint.cart;
    final header = await ApiEndpoint.getHeader();
    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200){
      String body = response.body;
      final json = jsonDecode(body);
      return CartResponse.fromJson(json);
    } else {
      throw 'Unable to fetch cart Item';
    }
  }

  Future<bool> updateCartQuantity(CartModel cartModel)async{
    String url = ApiEndpoint.cart;
    final header = await ApiEndpoint.getHeader();
    final response = await http.put(Uri.parse(url),
      headers: header,
      body: jsonEncode(cartModel.toJson(),
      ),
    );
    if(response.statusCode == 200){
      return true;
    }
    throw 'Unable to update cart Quantity';

  }
  Future<bool> deleteCartItem(String id) async {
    Uri uri = Uri.parse(ApiEndpoint.deleteCartItem(id));
    final header = await ApiEndpoint.getHeader();
    Response response = await http.delete(uri, headers: header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Unable to delete cart item';
    }
  }
}
