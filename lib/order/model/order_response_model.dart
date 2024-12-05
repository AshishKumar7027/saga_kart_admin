import 'package:saga_kart_admin/order/model/order_model.dart';

class OrderModel {
  List<Order> orders;

  OrderModel({required this.orders});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orders: (json['orders'] as List)
          .map((order) => Order.fromJson(order))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}
