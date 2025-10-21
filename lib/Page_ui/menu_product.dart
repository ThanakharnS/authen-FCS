import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart'; // เปลี่ยน Cupertino เป็น Material
import 'package:google_fonts/google_fonts.dart';
import '../model/product_model.dart';
import '../Service/product_api_service.dart';

class MenuProductPage extends StatefulWidget {
  const MenuProductPage({super.key});

  @override
  _MenuProductPageState createState() => _MenuProductPageState();
}

class _MenuProductPageState extends State<MenuProductPage> {
  late Future<List<Product>> _productsFuture;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    // 🚀 เรียกใช้ Core API Function ทันทีที่ Widget ถูกสร้าง
    _productsFuture = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'menu_product'.tr(), // ใช้ Easy Localization
          style: GoogleFonts.kanit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture, // 👈 ใช้ Future จากการเรียก Core API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 1. สถานะ: กำลังโหลด (Loading)
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 2. สถานะ: เกิดข้อผิดพลาด (Error)
            return Center(
              child: Text(
                'Error loading data: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // 3. สถานะ: มีข้อมูล (Success)
            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductListItem(product); // 👈 แยก Widget แสดงรายการ
              },
            );
          }
          // 4. สถานะ: ไม่มีข้อมูล (Empty)
          return const Center(child: Text('ไม่พบรายการสินค้า.'));
        },
      ),
    );
  }

  // 🔨 แยก Widget สำหรับแสดงผลรายการสินค้าแต่ละรายการ
  Widget _buildProductListItem(Product product) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(

        // 🔹 LEADING: การแสดงรูปภาพสินค้า
        leading: SizedBox(
          width: 70,
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                ? Image.network(
              product.imageUrl!,
              key: ValueKey(product.imageUrl),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 30),
                );
              },
            )
                : Container( // รูปภาพสำรอง
              color: Colors.blueGrey[50],
              child: const Icon(Icons.shopping_bag, color: Colors.blueGrey, size: 40),
            ),
          ),
        ),

        // 🔹 TITLE & SUBTITLE: รายละเอียดสินค้า
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text('Brand: ${product.brand}'),

        // 🔹 TRAILING: ราคา
        trailing: Text(
          '฿ ${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        onTap: () {
          // Logic เมื่อกดที่รายการสินค้า
        },
      ),
    );
  }
}