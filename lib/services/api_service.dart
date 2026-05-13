import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  // سيرفر بديل موثوق يعمل في كل مكان
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // ملاحظة: هذا السيرفر يضع المنتجات داخل قائمة اسمها 'products'
        List<dynamic> productsJson = data['products'];
        
        return productsJson.map((item) => Product.fromJson(item)).toList();
      } else {
        throw "فشل الاتصال بالسيرفر: ${response.statusCode}";
      }
    } catch (e) {
      throw "خطأ في الشبكة: $e";
    }
  }
  // دالة جديدة لجلب منتجات قسم معين فقط
Future<List<Product>> fetchProductsByCategory(String categoryName) async {
  try {
    // الرابط يتغير ليصبح /category/اسم_القسم
    final String categoryUrl = "https://dummyjson.com/products/category/$categoryName";
    final response = await http.get(Uri.parse(categoryUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> productsJson = data['products'];
      return productsJson.map((item) => Product.fromJson(item)).toList();
    } else {
      throw "تعذر تحميل قسم $categoryName";
    }
  } catch (e) {
    throw "خطأ في الشبكة: $e";
  }
}
}