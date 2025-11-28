// models/product_model.dart

class Product {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String? image;
  final int amount;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.amount,
  });

  // Factory constructor สำหรับแปลง JSON Map เป็น Product Object
  factory Product.fromJson(Map<String, dynamic> json) {

    //===> set image for support version ios & android
    String? rawImage = json['image'];
    // แก้ปัญหา localhost เพื่อให้ Android โหลดรูปได้
    String? fixedImage;
    if (rawImage != null) {
      fixedImage = rawImage.replaceFirst(
        "http://localhost",
        "http://192.168.1.188",   // Android Emulator
      );
    }



    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      //image: json['image'] as String?,
      image: fixedImage,
      amount: json['amount'] as int,
    );
  }
}