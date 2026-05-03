import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import '../widgets/product_item.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الوصول إلى البيانات داخل الـ Provider
    final shopData = Provider.of<ShopProvider>(context);
    final products = shopData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        // بناء كل عنصر في الشبكة باستخدام Widget مخصص (سننشئه في الخطوة التالية)
        itemBuilder: (ctx, i) => ProductItem(product: products[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,      // عدد العناصر في الصف الواحد
          childAspectRatio: 3 / 2, // نسبة العرض إلى الطول للكارت
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      );
  }
}