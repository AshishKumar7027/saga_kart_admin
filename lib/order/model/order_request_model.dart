import 'package:saga_kart_admin/order/model/order_product_item_model.dart';
import 'package:saga_kart_admin/profile/model/shipping_address_model.dart';

class OrderRequestModel {
  List<OrderProductItem> items;
  ShippingAddress shippingAddress;

  OrderRequestModel({
    required this.items,
    required this.shippingAddress,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      items: (json['items'] as List)
          .map((item) => OrderProductItem.fromJson(item))
          .toList(),
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'shippingAddress': shippingAddress.toJson(),
    };
  }
}
