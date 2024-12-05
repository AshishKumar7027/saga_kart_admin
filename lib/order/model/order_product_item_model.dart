class OrderProductItem {
  String product;
  String name;
  int quantity;
  int price;
  int discountAmount;
  int totalPrice;
  String id;

  // Constructor
  OrderProductItem({
    required this.product,
    required this.name,
    required this.quantity,
    required this.price,
    required this.discountAmount,
    required this.totalPrice,
    required this.id,
  });

  // fromJson factory method
  factory OrderProductItem.fromJson(Map<String, dynamic> json) {
    return OrderProductItem(
      product: json['product'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      discountAmount: json['discountAmount'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      id: json['_id'] ?? '',
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'name': name,
      'quantity': quantity,
      'price': price,
      'discountAmount': discountAmount,
      'totalPrice': totalPrice,
      '_id': id,
    };
  }
}