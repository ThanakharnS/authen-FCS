// models/product_model.dart

class Product {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.imageUrl,
  });

  // Factory constructor สำหรับแปลง JSON Map เป็น Product Object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );
  }
}