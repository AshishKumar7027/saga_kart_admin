import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saga_kart_admin/core/api_endpoint.dart';
import 'package:saga_kart_admin/order/model/order_request_model.dart';
import 'package:saga_kart_admin/order/model/order_response_model.dart';
import 'package:saga_kart_admin/order/model/update_order_status_model.dart';

class OrderService {
  Future<bool> orderPlace(OrderRequestModel orderRequestModel) async {
    final header = await ApiEndpoint.getHeader();
    Uri uri = Uri.parse(ApiEndpoint.order);
    final json = orderRequestModel.toJson();
    final jsonStr = jsonEncode(json);
    final response = await http.post(uri, headers: header, body: jsonStr);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Unable to place order';
    }
  }

  Future<OrderResponseModel> fetchOrder() async {
    final header = await ApiEndpoint.getHeader();
    Uri uri = Uri.parse(ApiEndpoint.order);
    final response = await http.get(
      uri,
      headers: header,
    );
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      OrderResponseModel orderResponseModel = OrderResponseModel.fromJson(json);
      return orderResponseModel;
    } else {
      throw 'Unable to fetch orders';
    }
  }

  Future updateOrderStatus(
      UpdateOrderStatusModel updateOrderStatusModel) async {
    final header = await ApiEndpoint.getHeader();
    Uri uri = Uri.parse(
      ApiEndpoint.updateOrder(updateOrderStatusModel.orderId),
    );
    final jsonStr = jsonEncode(updateOrderStatusModel.toJson());
    final response = await http.put(
      uri,
      headers: header,
      body: jsonStr
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Unable to fetch orders';
    }
  }
}
