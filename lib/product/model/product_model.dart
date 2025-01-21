class Product {
  final String? id;
  final String name;
  final num price;
  final String? image;
  final String description;
  final num? discountAmount;
  final String categoryId;
  final num stock;
  final int? created;
  final int? modified;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    this.discountAmount,
    required this.categoryId,
    required this.stock,
    this.image,
    this.created,
    this.modified,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String?,
      description: (json['description'] ?? '' )as String,
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      categoryId: (json['categoryId'] ?? '') as String,
      stock: (json['stock'] ?? 0) as int,
      created: json['created'] as int?,
      modified: json['modified'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'discountAmount': discountAmount,
      'categoryId': categoryId,
      'stock': stock,
      'created': created,
      'modified': modified,
    };
  }
}