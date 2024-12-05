import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saga_kart_admin/core/api_endpoint.dart';
import 'package:saga_kart_admin/order/model/order_request_model.dart';

class OrderService {
  Future<bool>orderPlace(OrderRequestModel orderRequestModel)async{
    final header = await ApiEndpoint.getHeader();
    Uri uri = Uri.parse(ApiEndpoint.order);
    final json = orderRequestModel.toJson();
    final jsonStr = jsonEncode(json);
    final response = await http.post(uri,headers: header,body: jsonStr);
    if(response.statusCode == 201){
      return true;
    }else{
      throw 'Unable to place order';
    }
  }
}
