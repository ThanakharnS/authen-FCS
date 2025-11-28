import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/ProductDetailProvider.dart';
import '../model/product_model.dart';
import 'menu_product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product; // รับข้อมูลสินค้า

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final quantityProvider = context.watch<ProductDetailProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // รีเซ็ต quantity ก่อนกลับ
            quantityProvider.reset();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuProductPage(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // รูปสินค้า
            Center(
              child: product.image != null && product.image!.isNotEmpty
                  ? Image.network(product.image!, height: 200)
                  : const Icon(Icons.shopping_bag, size: 100),
            ),
            const SizedBox(height: 16),
            Text('Name: ${product.name}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Brand: ${product.brand}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Price: ฿${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.green)),
            const SizedBox(height: 8),
            Text('Amount: ${product.amount}',
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 40),

            // Quantity + Buy Now
            Center(
              child: Column(
                children: [
                  const Text("กรุณาระบุจำนวนสินค้าที่ต้องการ",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ปุ่มลด
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, size: 40),
                        onPressed: () => quantityProvider.decrement(),
                      ),
                      const SizedBox(width: 20),
                      // แสดงค่า quantity
                      Text(
                        "${quantityProvider.quantity}",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      // ปุ่มเพิ่ม
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, size: 40),
                        onPressed: () => quantityProvider.increment(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // ปุ่ม Buy Now
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: quantityProvider.quantity > 0
                          ? () {
                        // แสดง snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "ซื้อ ${product.name} จำนวน ${quantityProvider.quantity} ชิ้นเรียบร้อย!",
                                textAlign: TextAlign.center
                            ),
                          ),
                        );

                        // ไปหน้า MenuProductPage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuProductPage(),
                          ),
                        );

                        // รีเซ็ต quantity
                        quantityProvider.reset();
                      }
                          : null,
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
