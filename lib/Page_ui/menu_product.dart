import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verify_identity/Page_ui/productDetail_page.dart';
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
    _productsFuture = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'menu_product'.tr(),
          style: GoogleFonts.kanit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading data: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductListItem(product);
              },
            );
          }
          return const Center(child: Text('ไม่พบรายการสินค้า.'));
        },
      ),
    );
  }

  Widget _buildProductListItem(Product product) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        leading: SizedBox(
          width: 70,
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: product.image != null && product.image!.isNotEmpty
                ? Image.network(
              product.image!,
              key: ValueKey(product.image),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 30),
                );
              },
            )
                : Container(
              color: Colors.blueGrey[50],
              child: const Icon(Icons.shopping_bag, color: Colors.blueGrey, size: 40),
            ),
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Brand: ${product.brand}'),
            const SizedBox(height: 4),
            Text('Amount: ${product.amount}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: Text(
          '฿ ${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        onTap: () {
          // ส่ง Product object ไปหน้า ProductDetailPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
      ),
    );
  }



}
