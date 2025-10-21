// services/product_service.dart
import 'package:dio/dio.dart';
import '../model/product_model.dart';

class ProductService {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.126:9999/api',
      connectTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<Product>> fetchProducts() async {
    try {
      final Response response = await _dio.get('/products');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = response.data;
        final List<dynamic> jsonList = jsonMap['products'] as List<dynamic>;
        print('Responcs ===> ${jsonList.first}');
        return jsonList.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
      }
      // กรณีสถานะอื่นๆ ที่ไม่ใช่ 200 แต่ไม่ได้ throw error
      throw Exception('Failed to load products: Status ${response.statusCode}');
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Server error: ${e.response!.statusCode} - ${e.response!.statusMessage}');
      } else {
        throw Exception('Network error: Check your server or connection.');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}