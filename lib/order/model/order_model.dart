import 'package:saga_kart_admin/order/model/order_product_item_model.dart';
import 'package:saga_kart_admin/profile/model/shipping_address_model.dart';

class Order {
  String id;
  String orderNumber;
  String user;
  ShippingAddress shippingAddress;
  List<OrderProductItem> items;
  String orderStatus;
  String createdAt;
  String updatedAt;
  int version;

  // Constructor
  Order({
    required this.id,
    required this.orderNumber,
    required this.user,
    required this.shippingAddress,
    required this.items,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });


  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      user: json['user'] ?? '',
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
      items: (json['items'] as List)
          .map((item) => OrderProductItem.fromJson(item))
          .toList(),
      orderStatus: json['orderStatus'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['__v'] ?? 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderNumber': orderNumber,
      'user': user,
      'shippingAddress': shippingAddress.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'orderStatus': orderStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}