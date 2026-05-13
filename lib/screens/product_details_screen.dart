import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ShopProvider.dart';
import '../models/product.dart'; // تأكد من استيراد المودل

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // 1. استخدام دالة البحث الآمنة التي أضفناها في الـ Provider
    final shopProvider = Provider.of<ShopProvider>(context, listen: false);
    final loadedProduct = shopProvider.findById(productId);

    // 2. التحقق من سلامة البيانات قبل البدء برسم الواجهة (مهم جداً لمنع التجمد)
    if (loadedProduct.id == 0) {
      return Scaffold(
        appBar: AppBar(title: const Text('جاري التحميل...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.contain, // استخدم contain لعدم قص تفاصيل المنتج كما في الصور السابقة
                errorBuilder: (ctx, error, stack) => const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.justify, // تنسيق أفضل للنصوص الطويلة
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          shopProvider.addToCart(loadedProduct);
          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // لإخفاء أي سناك بار سابق فوراً
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم إضافة ${loadedProduct.title} للسلة!'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        label: const Text('إضافة للسلة'),
        icon: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}