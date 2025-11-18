import 'package:flutter/material.dart';
import '../model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product; // รับข้อมูลสินค้า

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: product.image != null && product.image!.isNotEmpty
                  ? Image.network(product.image!, height: 200)
                  : const Icon(Icons.shopping_bag, size: 100),
            ),
            const SizedBox(height: 16),
            Text('Name: ${product.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Brand: ${product.brand}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Price: ฿${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, color: Colors.green)),
            const SizedBox(height: 8),
            Text('Amount: ${product.amount}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
