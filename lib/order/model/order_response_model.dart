import 'package:saga_kart_admin/order/model/order_model.dart';

class OrderResponseModel {
  List<OrderModel>? orders;

  OrderResponseModel({required this.orders});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      orders: (json['orders'] as List)
          .map((order) => OrderModel.fromJson(order))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders?.map((order) => order.toJson()).toList(),
    };
  }
}
