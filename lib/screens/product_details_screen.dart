import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  // نستقبل المعرف عبر الـ Constructor
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // البحث عن المنتج المطابق للمعرف في الـ Provider
    // نستخدم listen: false لأننا نحتاج البيانات مرة واحدة عند بناء الشاشة
    final loadedProduct = Provider.of<ShopProvider>(context, listen: false)
        .items
        .firstWhere((prod) => prod.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView( // للسماح بالتمرير إذا كان الوصف طويلاً
        child: Column(
          children: [
            // عرض صورة المنتج بشكل كبير
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            // عرض السعر
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // عرض الوصف
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      // داخل الـ Scaffold في ملف product_details_screen.dart
floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    Provider.of<ShopProvider>(context, listen: false).addToCart(loadedProduct);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تمت الإضافة للسلة!'), duration: Duration(seconds: 1)),
    );
  },
  label: const Text('إضافة للسلة'),
  icon: const Icon(Icons.add_shopping_cart),
),
    );
  }
}